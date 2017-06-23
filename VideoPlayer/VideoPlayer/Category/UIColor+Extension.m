//
//  UIColor+Extension.m
//  BaseProject
//
//  Created by 陈阳阳 on 2017/2/21.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)hex
{
    hex= [[hex uppercaseString] substringFromIndex:1];
    CGFloat valueArray[3];
    NSArray *strArray=[NSArray arrayWithObjects:[hex substringWithRange:NSMakeRange(0, 2)],[hex substringWithRange:NSMakeRange(2, 2)],[hex substringWithRange:NSMakeRange(4, 2)] ,nil];
    for( int i=0;i<strArray.count;i++){
        hex=strArray[i];
        CGFloat value=([hex characterAtIndex:0]>'9'?[hex characterAtIndex:0]-'A'+10:[hex characterAtIndex:0]-'0')*16.0f+([hex characterAtIndex:1]>'9'?[hex characterAtIndex:1]-'A'+10:[hex characterAtIndex:1]-'0');
        valueArray[i]=value;
    }
    return [UIColor colorWithRed:valueArray[0]/255 green:valueArray[1]/255 blue:valueArray[2]/255 alpha:1];
}

+ (UIColor *) R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b
{
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
