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
@property (nonatomic,weak)   id timeObserver;

@property (nonatomic,strong) UIControl     *playerControl;
@property (nonatomic,strong) VideoPlayerModel *playerModel;

@end

@implementation VideoPlayerView

- (void)dealloc {
    NSLog(@"--------------- VideoPlayerView dealloc ---------------");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    if (self.playerControl) {        
        self.playerControl.frame = self.bounds;
    }
}

- (void)configPlayerWithControl:(UIControl *)control Model:(VideoPlayerModel *)model {
    
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

- (void)destroyPlayer {
    
}

@end
