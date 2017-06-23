//
//  UIColor+Extension.h
//  BaseProject
//
//  Created by 陈阳阳 on 2017/2/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

// 十六进制字符串  @"#C8C8C8"
+ (UIColor *) colorWithHexString:(NSString*)hexString;
// RGB  200.0f 200.0f 200.0f
+ (UIColor *) R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
// 随机颜色
+ (UIColor *)randomColor;

@end
