//
//  FullScreenViewController.m
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/27.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "FullScreenViewController.h"

@interface FullScreenViewController ()

@end

@implementation FullScreenViewController

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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
