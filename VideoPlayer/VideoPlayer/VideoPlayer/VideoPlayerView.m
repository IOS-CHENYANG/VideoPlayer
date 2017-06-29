//
//  VideoPlayerView.m
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/22.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "VideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>

#import "VideoPlayerControl.h"
#import "VideoPlayerModel.h"

@interface VideoPlayerView ()

@property (nonatomic,strong) AVURLAsset    *urlAsset;
@property (nonatomic,strong) AVPlayerItem  *playerItem;
@property (nonatomic,strong) AVPlayer      *player;
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@property (nonatomic,weak)   id     timeObserver;
@property (nonatomic,assign) double currentTime;

@property (nonatomic,strong) VideoPlayerControl *playerControl;
@property (nonatomic,strong) VideoPlayerModel   *playerModel;


@end

static void *PlayViewStatusObservationContext = &PlayViewStatusObservationContext;

@implementation VideoPlayerView

- (void)dealloc {
    NSLog(@"--------------- VideoPlayerView dealloc ---------------");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.player removeTimeObserver:self.timeObserver];

}

- (void)destroyPlayer {
    [self.player pause];
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    self.player = nil;
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    if (self.playerControl) {        
        self.playerControl.frame = self.bounds;
    }
}

- (void)configPlayerWithControl:(VideoPlayerControl *)control Model:(VideoPlayerModel *)model {
    
    self.playerModel = model;
    self.backgroundColor = [UIColor blackColor];
    
    self.urlAsset = [AVURLAsset assetWithURL:self.playerModel.playUrl];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer addSublayer:self.playerLayer];
    
    if (control) {
        self.playerControl = control;
        [self addSubview:self.playerControl];
    }
    
    self.currentTime = 0;
    
    // 监听播放器播放状态
    [self.player.currentItem addObserver:self
                              forKeyPath:@"status"
                                 options:NSKeyValueObservingOptionNew
                                 context:PlayViewStatusObservationContext];
    // 监听播放器播放缓存
    [self.playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    // 监听播放结束
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEndTime) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (context == PlayViewStatusObservationContext) {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerItemStatusUnknown:
                NSLog(@"-----------未知------------");
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"----------准备播放----------");
                [self readyToPlay];
                break;
            case AVPlayerItemStatusFailed:
                NSLog(@"----------播放失败-----------");
                break;
            default:
                break;
        }
        
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        
        
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        
        
    }
}

// 开始准备播放
- (void)readyToPlay {
    
//    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];

    __weak typeof(self) weakSelf = self;
    // 添加定时器，更新播放进度
    
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        // 更新播放进度
        double currentTime =  CMTimeGetSeconds([weakSelf.player currentTime]);
        weakSelf.currentTime = currentTime;
        [weakSelf.playerControl currentTime:currentTime totalTime:[weakSelf duration]];
    }];
}

- (double)currentTime {
    return self.currentTime;
}

// 获取视频总时长
- (double)duration {
    AVPlayerItem *playerItem = [self.player currentItem];
    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        return CMTimeGetSeconds([playerItem duration]);
    }
    return CMTimeGetSeconds(kCMTimeInvalid);

}

- (void)setVideoGravity:(VideoGravity)videoGravity {
    switch (videoGravity) {
        case VideoGravityResize:
        {
            self.playerLayer.videoGravity = AVLayerVideoGravityResize;
        }
            break;
        case VideoGravityResizeAspect:
        {
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        }
            break;
        case VideoGravityResizeAspectFill:
        {
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        }
            break;
        default:
            break;
    }
}

- (void)play {
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

@end
