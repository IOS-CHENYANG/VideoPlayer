//
//  VideoPlayerModel.h
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/22.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoPlayerModel : NSObject

// 标题
@property (nonatomic,strong) NSString *title;
// 播放地址
@property (nonatomic,strong) NSURL  *playUrl;
// 清晰度
@property (nonatomic,strong) NSDictionary *definitionDict;

@end
