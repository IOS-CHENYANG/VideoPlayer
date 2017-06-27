//
//  SuperViewController.m
//  BaseProject
//
//  Created by 陈阳阳 on 2017/2/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // take care :
    // IOS7之前UIViewController的View在显示后会自动调整去掉导航栏的高度
    // IOS7之后UIViewController的View创建后默认是全屏的
    // 可以使用edgesForExtendedLayout去掉向四个方向的延伸
    // 有tabbar和navigationbar的时候view在navigationbar和tabbar之间
    if (SystemVersion > 7.0) {        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}


- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
//    NSLog(@"%@---%s",self.title,__func__);
}

@end
