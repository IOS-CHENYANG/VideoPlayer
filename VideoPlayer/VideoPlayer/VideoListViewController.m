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

@interface VideoListViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation VideoListViewController

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
    [self.navigationController pushViewController:play animated:YES];
}

- (void)showVideoPlayer:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    NSInteger index = tapView.tag - 20170622;
    NSLog(@"点击cell index = %ld",index);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    VideoListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.frame = tapView.bounds;
    [cell.contentView addSubview:view];
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
