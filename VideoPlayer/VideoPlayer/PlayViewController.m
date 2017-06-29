//
//  PlayViewController.m
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/26.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "PlayViewController.h"

#import "VideoPlayerView.h"
#import "VideoPlayerModel.h"
#import "VideoPlayerControl.h"

@interface PlayViewController () <VideoPlayerControlDelegate>

@property (nonatomic,strong) VideoPlayerView *playerView;
@property (nonatomic,strong) VideoPlayerControl *playerControl;

@end

@implementation PlayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.supportLandscapeOrientation = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.supportLandscapeOrientation = NO;
}

- (void)fullscreen:(UIButton *)fullscreenButton playerControl:(VideoPlayerControl *)control {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.videoTitle;

    VideoPlayerModel *model = [[VideoPlayerModel alloc]init];
    model.playUrl = [NSURL URLWithString:self.playUrl];
    VideoPlayerView *playerView = [[VideoPlayerView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16)];
    self.playerView = playerView;
    [self.view addSubview:playerView];
    VideoPlayerControl *playerControl = [[VideoPlayerControl alloc]init];
    self.playerControl = playerControl;
    playerControl.delegate = self;
    [playerView configPlayerWithControl:playerControl Model:model];
    [playerView play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}


#pragma mark - 监听屏幕旋转
- (void)statusBarOrientationChange:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        if (orientation == UIInterfaceOrientationLandscapeRight) {
            self.navigationController.navigationBarHidden = YES;
            self.playerView.transform =CGAffineTransformMakeRotation(M_PI_2);
            self.playerView.frame = self.view.bounds;
            self.playerControl.isFullScreen = YES;
            
        }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
            self.navigationController.navigationBarHidden = YES;
            self.playerView.transform = CGAffineTransformMakeRotation(-M_PI_2);
            self.playerView.frame = self.view.bounds;
            self.playerControl.isFullScreen = YES;
        }else {
            self.playerView.transform = CGAffineTransformMakeRotation(0);
            self.playerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
            self.navigationController.navigationBarHidden = NO;
            self.playerControl.isFullScreen = NO;
        }
        self.playerControl.frame = self.playerView.bounds;
        
        // 更新约束
        [self.playerControl setNeedsUpdateConstraints];
        [self.playerControl updateConstraintsIfNeeded];
        [self.playerControl layoutIfNeeded];
        
    }];
}

#pragma mark - 进入前后台

- (void)appDidEnterBackground {
    NSLog(@"进入后台");
    [self.playerView pause];
}

- (void)appWillEnterForeground {
    NSLog(@"进入前台");
    [self.playerView play];
}


#pragma mark - VideoPlayerControlDelegate

- (void)play:(UIButton *)playButton {
    [self.playerView play];
}

- (void)pause:(UIButton *)playButton {
    [self.playerView pause];
}

- (void)fullscreen:(UIButton *)fullscreenButton {
    fullscreenButton.selected = !fullscreenButton.selected;
    
    if (self.playerControl.isFullScreen) {
        [[UIDevice currentDevice] setValue:@1 forKey:@"orientation"];
    }else {
        [[UIDevice currentDevice] setValue:@3 forKey:@"orientation"];
    }

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortraitUpsideDown;
}

@end
