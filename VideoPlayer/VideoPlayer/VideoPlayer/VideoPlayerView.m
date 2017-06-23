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
@property (nonatomic,strong) id timeObserver;

@property (nonatomic,strong) UIControl *playerControl;
@property (nonatomic,strong) VideoPlayerModel *playerModel;

@end

@implementation VideoPlayerView

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}

- (void)dealloc {
    NSLog(@"--------------- VideoPlayerView dealloc ---------------");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    self.playerControl.frame = self.bounds;
}

- (void)configPlayerWithControl:(UIControl *)control Model:(VideoPlayerModel *)model {
    if (control) {
        self.playerControl = control;
    }else {
        VideoPlayerControl *control = [[VideoPlayerControl alloc]init];
        self.playerControl = control;
    }
    [self addSubview:self.playerControl];
    self.playerModel = model;
    self.backgroundColor = [UIColor blackColor];
    self.urlAsset = [AVURLAsset assetWithURL:self.playerModel.playUrl];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer addSublayer:self.playerLayer];
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
