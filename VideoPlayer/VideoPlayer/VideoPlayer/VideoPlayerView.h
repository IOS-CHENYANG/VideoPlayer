//
//  VideoPlayerView.h
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/22.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoPlayerModel;

typedef NS_ENUM(NSInteger,VideoGravity) {
    VideoGravityResize,              // 拉伸完全填充整个视图区域
    VideoGravityResizeAspect,        // 保持视频比例拉伸直到一个方向到达视图区域边界
    VideoGravityResizeAspectFill     // 保持视频比例拉伸直到填充整个视图区域，视频可能会被裁剪
};

@interface VideoPlayerView : UIView

@property (nonatomic,assign) VideoGravity videoGravity; // 填充模式

- (void)configPlayerWithControl:(UIControl *)control Model:(VideoPlayerModel *)model;

- (void)play;

- (void)pause;

- (void)destroyPlayer;

@end
