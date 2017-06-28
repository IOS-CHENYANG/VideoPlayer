//
//  VideoPlayerControlDelegate.h
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/26.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoPlayerControl;

@protocol VideoPlayerControlDelegate <NSObject>

// 播放
- (void)play:(UIButton *)playButton;
// 暂停
- (void)pause:(UIButton *)playButton;
// 全屏
- (void)fullscreen:(UIButton *)fullscreenButton playerControl:(VideoPlayerControl *)control;

@end
