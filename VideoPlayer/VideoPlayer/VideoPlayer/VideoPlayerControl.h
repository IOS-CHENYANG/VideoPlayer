//
//  VideoPlayerControl.h
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/22.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayerControlDelegate.h"

@interface VideoPlayerSlider : UISlider

@end

@interface VideoPlayerControl : UIControl

@property (nonatomic,assign) BOOL isFullScreen;

@property (nonatomic,weak) id <VideoPlayerControlDelegate> delegate;

//@property (nonatomic,copy) void (^play) ();
//@property (nonatomic,copy) void (^pause) ();

- (void)currentTime:(double)currentTime totalTime:(double)totalTime;

@end
