//
//  WBViewController.m
//  WBPullRefresh
//
//  Created by bing on 03/05/2019.
//  Copyright (c) 2019 bing. All rights reserved.
//

#import "WBViewController.h"
#import <WBPullRefresh/WBPullRefresh.h>
#import "CustomTipView.h"

@interface WBViewController ()

@end

@implementation WBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    
    // 初始化刷新组件
    [self setupRefreshing];
}

- (void)setup {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"WBPullRefresh";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView reloadData];
}

- (void)setupRefreshing {
    WBPullRefreshContentView *contentView = [WBPullRefreshContentView contentViewWithHeight:70 imagesArray:[self images]];
    WBPullRefreshHeaderView *headerView = [WBPullRefreshHeaderView headerViewWithHeight:70 contentView:contentView];
    
    __weak typeof(self) weakSelf = self;
    headerView.tipViewBlock = ^UIView *{
        // 自定义效果
        //return [CustomTipView tipViewWithText:@"推荐了10条更新"];
        // 默认效果
        return [WBPullRefreshDefaultTipView tipViewWithText:@"推荐了10条更新" colors:@[[UIColor redColor], [UIColor blueColor], [UIColor orangeColor]]];
    };
    
    __weak typeof(headerView) weakHeader = headerView;
    headerView.refreshingActionBlock = ^{
        __strong typeof(weakHeader) strongHeader = weakHeader;
        [weakSelf fetchDataWithCompletion:^{
            // 显示tip
            [strongHeader showTipForTime:1];
            // 不显示tip
            //[strongHeader endRefreshing];
        }];
    };
    
    self.tableView.wb_headerView = headerView;
}

- (void)fetchDataWithCompletion:(void (^)(void))completion {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

- (NSArray *)images {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 21; i++) {
        NSString *imgName = [NSString stringWithFormat:@"loading%zd", i];
        [images addObject:[UIImage imageNamed:imgName]];
    }
    return images;
}
@end
