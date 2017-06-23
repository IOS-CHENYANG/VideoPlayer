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
@property (nonatomic,strong) UISlider *slider;
// 全屏按钮
@property (nonatomic,strong) UIButton *fullScreenButton;
// 锁定屏幕方向按钮
@property (nonatomic,strong) UIButton *lockButton;
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
        [self addSubview:self.lockButton];
        [self addSubview:self.activityIndicatorView];
        
        [self.topPanelImageView addSubview:self.backButton];
        [self.topPanelImageView addSubview:self.titleLabel];
        
        [self.bottomPanelImageView addSubview:self.playButton];
        [self.bottomPanelImageView addSubview:self.currentTimeLabel];
        [self.bottomPanelImageView addSubview:self.progressView];
        [self.bottomPanelImageView addSubview:self.slider];
        [self.bottomPanelImageView addSubview:self.totalTimeLabel];
        [self.bottomPanelImageView addSubview:self.fullScreenButton];
        
        [self makeSubViewsConstraints];
        
        UITapGestureRecognizer *single = [UITapGestureRecognizer alloc];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
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
    [self.topPanelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.leading.and.trailing.equalTo(self);
        make.height.mas_equalTo(50);
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
        _topPanelImageView.image = [UIImage imageNamed:@"ZFPlayer_top_shadow"];
    }
    return _topPanelImageView;
}

- (UIImageView *)bottomPanelImageView {
    if (!_bottomPanelImageView) {
        _bottomPanelImageView = [[UIImageView alloc]init];
        _bottomPanelImageView.userInteractionEnabled = YES;
        _bottomPanelImageView.image = [UIImage imageNamed:@"ZFPlayer_bottom_shadow"];
    }
    return _bottomPanelImageView;
}

- (UIButton *)lockButton {
    if (!_lockButton) {
        _lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lockButton setImage:[UIImage imageNamed:@"ZFPlayer_unlock-nor"] forState:UIControlStateNormal];
        [_lockButton setImage:[UIImage imageNamed:@"ZFPlayer_lock-nor"] forState:UIControlStateSelected];
        [_lockButton addTarget:self action:@selector(lockButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lockButton;
}

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
        [_playButton setImage:[UIImage imageNamed:@"ZFPlayer_play"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"ZFPlayer_pause"] forState:UIControlStateSelected];
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
        _slider = [[UISlider alloc]init];
        [_slider setThumbImage:[UIImage imageNamed:@"ZFPlayer_slider"] forState:UIControlStateNormal];
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
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:12];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}

- (UIButton *)fullScreenButton {
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"ZFPlayer_fullscreen"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"ZFPlayer_shrinkscreen"] forState:UIControlStateNormal];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}

@end
