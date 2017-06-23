//
//  NSString+Extension.m
//  BaseProject
//
//  Created by 陈阳阳 on 2017/3/20.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)convertTime:(CGFloat)second {
    NSString *str_hour = [NSString stringWithFormat:@"%02d",(int)second/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02d",(int)(int)second%3600/60];
    NSString *str_second = [NSString stringWithFormat:@"%02d",(int)second%60];
    if (second/3600 >= 1) {
        return [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }else {
        return [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }
}

@end

