//
//  VideoPlayerControl.m
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/22.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "VideoPlayerControl.h"

@interface VideoPlayerControl ()

// 标题
@property (nonatomic,strong) UILabel *titleLabel;
// 播放按钮
@property (nonatomic,strong) UIButton *playButton;
// 当前播放时长
@property (nonatomic,strong) UILabel *currentTimeLabel;
// 总时长
@property (nonatomic,strong) UILabel *totalTimeLabel;
// 缓冲进度条
@property (nonatomic,strong) UIProgressView *progressView;
// 当前播放进度
@property (nonatomic,strong) VideoPlayerSlider *slider;
// 全屏按钮
@property (nonatomic,strong) UIButton *fullScreenButton;
// 加载菊花
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;
// 返回按钮
@property (nonatomic,strong) UIButton *backButton;

@property (nonatomic,strong) UIImageView *placeholderImageView;
@property (nonatomic,strong) UIImageView *topPanelImageView;
@property (nonatomic,strong) UIImageView *bottomPanelImageView;

@end

@implementation VideoPlayerControl

#pragma mark - 初始化

- (void)dealloc {
    NSLog(@"--------------- VideoPlayerControl dealloc ---------------");
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.placeholderImageView];
        [self addSubview:self.topPanelImageView];
        [self addSubview:self.bottomPanelImageView];
//        [self addSubview:self.lockButton];
        [self addSubview:self.activityIndicatorView];
        
        [self.topPanelImageView addSubview:self.backButton];
        [self.topPanelImageView addSubview:self.titleLabel];
        
        [self.bottomPanelImageView addSubview:self.playButton];
        [self.bottomPanelImageView addSubview:self.currentTimeLabel];
        [self.bottomPanelImageView addSubview:self.progressView];
        [self.bottomPanelImageView addSubview:self.slider];
        [self.bottomPanelImageView addSubview:self.totalTimeLabel];
        [self.bottomPanelImageView addSubview:self.fullScreenButton];
        
//        [self makeSubViewsConstraints];
        
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints {
    
    NSLog(@"----------- updateConstraints -----------");
    if (self.isFullScreen) {
//        [self.topPanelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_top).offset(0);
//            make.leading.and.trailing.equalTo(self);
//            make.height.mas_equalTo(44);
//        }];

        NSLog(@"-----全屏 ---------------");
        
    }else {
        
        [self.bottomPanelImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(39);
            make.leading.trailing.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [self.playButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(36);
            make.left.equalTo(self.bottomPanelImageView.mas_left).offset(6);
            make.centerY.equalTo(self.bottomPanelImageView.mas_centerY);
        }];
        [self.fullScreenButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(18);
            make.right.equalTo(self.bottomPanelImageView.mas_right).offset(-12);
            make.centerY.equalTo(self.bottomPanelImageView.mas_centerY);
        }];
        [self.totalTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
            make.centerY.equalTo(self.fullScreenButton.mas_centerY);
            make.right.equalTo(self.fullScreenButton.mas_left).offset(-12);
        }];
        [self.currentTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
            make.centerY.equalTo(self.fullScreenButton.mas_centerY);
            make.right.equalTo(self.totalTimeLabel.mas_left).offset(0);
            make.left.equalTo(self.slider.mas_right).offset(12);
        }];
        
        [self.slider mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playButton.mas_right).offset(12);
            make.centerY.equalTo(self.playButton.mas_centerY);
            make.right.equalTo(self.currentTimeLabel.mas_left).offset(-12);
        }];
    }
    
    [super updateConstraints];
}

#pragma mark - 响应事件

- (void)lockButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"锁屏幕");
}

- (void)backButtonClick:(UIButton *)sender {
    NSLog(@"返回按钮");
}

- (void)playButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"播放按钮");
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"Video_player_play_"] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(pause:)]) {
            [self.delegate pause:sender];
        }
    }else {
        [sender setImage:[UIImage imageNamed:@"Video_player_pause_"] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(play:)]) {
            [self.delegate play:sender];
        }
    }
}

- (void)sliderTouchBegin:(UISlider *)sender {
    NSLog(@"开始滑动");
}

- (void)sliderValueChanged:(UISlider *)sender {
    NSLog(@"滑动中");
}

- (void)sliderTouchEnd:(UISlider *)sender {
    NSLog(@"滑动结束");
}

- (void)fullScreenButtonClick:(UIButton *)sender {
    NSLog(@"全屏按钮");
    if ([self.delegate respondsToSelector:@selector(fullscreen:)]) {
        [self.delegate fullscreen:sender];
    }
}

- (void)appDidEnterBackground {
    NSLog(@"进入后台");
}

- (void)appWillEnterForeground {
    NSLog(@"进入前台");
}

- (void)deviceOrientationDidChange {
    NSLog(@"设置旋转");
}

#pragma mark - 设置约束

- (void)makeSubViewsConstraints {
    
    
    
    
    [self.placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topPanelImageView.mas_leading).offset(10);
        make.top.equalTo(self.topPanelImageView.mas_top).offset(3);
        make.height.and.width.mas_equalTo(40);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.backButton.mas_trailing).offset(5);
        make.centerY.equalTo(self.backButton.mas_centerY);
        make.trailing.equalTo(self.topPanelImageView);
    }];
    
//    [self.bottomPanelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
}

- (void)updateSubViewsConstraints {
    
    [self.topPanelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.leading.and.trailing.equalTo(self);
        make.height.mas_equalTo(44);
    }];

}

#pragma mark - 懒加载

- (UIImageView *)placeholderImageView {
    if (!_placeholderImageView) {
        _placeholderImageView = [[UIImageView alloc]init];
        _placeholderImageView.userInteractionEnabled = YES;
    }
    return _placeholderImageView;
}

- (UIImageView *)topPanelImageView {
    if (!_topPanelImageView) {
        _topPanelImageView = [[UIImageView alloc]init];
        _topPanelImageView.userInteractionEnabled = YES;
        _topPanelImageView.image = [UIImage imageNamed:@"Video_player_mask_"];
    }
    return _topPanelImageView;
}

- (UIImageView *)bottomPanelImageView {
    if (!_bottomPanelImageView) {
        _bottomPanelImageView = [[UIImageView alloc]init];
        _bottomPanelImageView.userInteractionEnabled = YES;
        _bottomPanelImageView.image = [UIImage imageNamed:@"Video_player_mask_"];
    }
    return _bottomPanelImageView;
}

// 锁定屏幕方向按钮
//- (UIButton *)lockButton {
//    if (!_lockButton) {
//        _lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_lockButton setImage:[UIImage imageNamed:@"ZFPlayer_unlock-nor"] forState:UIControlStateNormal];
//        [_lockButton setImage:[UIImage imageNamed:@"ZFPlayer_lock-nor"] forState:UIControlStateSelected];
//        [_lockButton addTarget:self action:@selector(lockButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _lockButton;
//}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"ZFPlayer_back_full"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"Video_player_pause_"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc]init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font = [UIFont systemFontOfSize:12];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        _currentTimeLabel.text = @"00:00";
        _currentTimeLabel.backgroundColor = [UIColor redColor];
    }
    return _currentTimeLabel;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[VideoPlayerSlider alloc]init];
        [_slider setThumbImage:[UIImage imageNamed:@"Video_player_point_higlight_"] forState:UIControlStateNormal];
        _slider.minimumValue = 0;
        _slider.maximumValue = 1;
        _slider.minimumTrackTintColor = [UIColor whiteColor];
        _slider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [_slider addTarget:self action:@selector(sliderTouchBegin:) forControlEvents:UIControlEventTouchDown];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(sliderTouchEnd:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
    }
    return _slider;
}

- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]init];
        _totalTimeLabel.textColor = [UIColor grayColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:12];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.text = @"/00:00";
        _totalTimeLabel.backgroundColor = [UIColor greenColor];
    }
    return _totalTimeLabel;
}

- (UIButton *)fullScreenButton {
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"fullscreen_ico_"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"Video_player_shrink_"] forState:UIControlStateSelected];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

@end

@implementation VideoPlayerSlider

// 解决UISlider两边的空隙
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 4;
    rect.size.width = rect.size.width + 8;
    return [super thumbRectForBounds:bounds trackRect:rect value:value];
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    bounds = [super trackRectForBounds:bounds]; // 必须通过调用父类的trackRectForBounds 获取一个 bounds 值，否则 Autolayout 会失效，UISlider 的位置会跑偏。
    return CGRectMake(bounds.origin.x, bounds.origin.y - 2, bounds.size.width, 4);
}

@end
