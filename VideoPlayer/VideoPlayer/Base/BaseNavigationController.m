//
//  BaseNavigationController.m
//  BaseProject
//
//  Created by 陈阳阳 on 2017/2/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
}

- (BOOL)shouldAutorotate{
    
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
    
}


@end
