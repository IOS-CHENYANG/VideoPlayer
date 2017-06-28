//
//  VideoListViewController.m
//  VideoPlayer
//
//  Created by 陈阳阳 on 2017/6/26.
//  Copyright © 2017年 cyy. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoPlayerModel.h"
#import "VideoListCell.h"
#import "PlayViewController.h"

#import "VideoPlayerView.h"
#import "VideoPlayerControl.h"
#import "VideoPlayerModel.h"

#import "FullScreenViewController.h"

@interface VideoListViewController () <UITableViewDataSource,UITableViewDelegate,VideoPlayerControlDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,assign) NSInteger currentPlayIndex;

@property (nonatomic,strong) VideoPlayerView *playerView;

@property (nonatomic,strong) FullScreenViewController *fullScreenVc;

@end

@implementation VideoListViewController

- (FullScreenViewController *)fullScreenVc {
    if (!_fullScreenVc) {
        _fullScreenVc = [[FullScreenViewController alloc]init];
    }
    return _fullScreenVc;
}



- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self videoList];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoListCell *cell = [VideoListCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *videoInfo = self.dataArray[indexPath.row];
    NSString *cover = videoInfo[@"cover"];
    NSString *title = videoInfo[@"title"];
    [cell.coverImageView sd_setImageWithURL:[NSURL URLWithString:cover]];;
    cell.titleLabel.text = title;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showVideoPlayer:)];
    [cell.coverImageView addGestureRecognizer:tap];
    cell.coverImageView.tag = indexPath.row + 20170622;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayViewController *play = [[PlayViewController alloc]init];
    NSDictionary *videoInfo = self.dataArray[indexPath.row];
    play.playUrl = videoInfo[@"url"];
    play.videoTitle = videoInfo[@"title"];
    if (self.playerView) {
        [self.playerView destroyPlayer];
    }
    [self.navigationController pushViewController:play animated:YES];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.playerView.tag) {
        [self.playerView destroyPlayer];
    }
}

- (void)showVideoPlayer:(UITapGestureRecognizer *)tap {
    if (self.playerView) {
        [self.playerView destroyPlayer];
        self.playerView = nil;
    }
    UIView *tapView = tap.view;
    NSInteger index = tapView.tag - 20170622;
    self.currentPlayIndex = index;
    NSDictionary *videoInfo = self.dataArray[index];
    NSString *playUrl = videoInfo[@"url"];
    NSLog(@"点击cell index = %ld",index);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    VideoListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    VideoPlayerModel *model = [[VideoPlayerModel alloc]init];
    model.playUrl = [NSURL URLWithString:playUrl];
    VideoPlayerView *playerView = [[VideoPlayerView alloc]initWithFrame:cell.coverImageView.bounds];
    playerView.tag = index;
    self.playerView = playerView;
    [cell.contentView addSubview:playerView];
    VideoPlayerControl *playerControl = [[VideoPlayerControl alloc]init];
    playerControl.delegate = self;
    [playerView configPlayerWithControl:playerControl Model:model];
    [playerView play];
}

- (void)fullscreen:(UIButton *)fullscreenButton playerControl:(VideoPlayerControl *)control{
    __weak typeof(self) weakSelf = self;

    if (control.isFullScreen) {
        NSLog(@"全屏");

        [UIView animateWithDuration:0.4 animations:^{
            control.isFullScreen = NO;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentPlayIndex inSection:0];
            VideoListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            [cell.contentView addSubview:weakSelf.playerView];
            weakSelf.playerView.frame = cell.coverImageView.bounds;
        } completion:^(BOOL finished) {
            [self.fullScreenVc dismissViewControllerAnimated:YES completion:^{
            }];

        }];
       
        
    }else {
        [self presentViewController:self.fullScreenVc animated:YES completion:^{
            control.isFullScreen = YES;
            [weakSelf.fullScreenVc.view addSubview:weakSelf.playerView];
            weakSelf.playerView.frame = weakSelf.fullScreenVc.view.bounds;
        }];
        NSLog(@"小屏");
    }
}

- (void)videoList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"video.plist" ofType:nil];
    NSArray *dataArray = [[NSArray alloc]initWithContentsOfFile:path];
    
    NSLog(@"dataArray = %@",dataArray);
    self.dataArray = dataArray;
    [self.tableView reloadData];
    
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = self.view.bounds.size.width * 9 / 16 + 60;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end
