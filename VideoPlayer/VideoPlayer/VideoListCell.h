//
//  VideoListCell.h
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/26.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListCell : UITableViewCell

@property (nonatomic,strong) UIImageView *coverImageView;

@property (nonatomic,strong) UIImageView *playImageView;

@property (nonatomic,strong) UILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
