//
//  JFHomeTableViewController.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFHomeTableViewController.h"
#import "JFHomeVisitorView.h"
#import "JFOAuthViewController.h"
#import "JFNavigationController.h"
#import "JFStatus.h"
#import "JFStatusCell.h"
#import "JFNormalStatusCell.h"
#import "JFForwardStatusCell.h"

static NSString * const normalCell = @"normalCell";
static NSString * const forwardCell = @"forwardCell";

@interface JFHomeTableViewController ()
/**
 *  微博模型数组
 */
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation JFHomeTableViewController

- (void)loadView {
    // 根据授权状态切换视图
    [self chooseDefaultView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 授权后才加载
    if ([JFUserAccount shareUserAccount].isAuth) {
        
        // 加载微博数据
        [self loadStatus];
        
        // 注册cell
        [self.tableView registerClass:[JFNormalStatusCell class] forCellReuseIdentifier:normalCell];
        [self.tableView registerClass:[JFForwardStatusCell class] forCellReuseIdentifier:forwardCell];
        
        // 隐藏分割线
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
}

#pragma mark - 根据授权状态加载视图
/**
 *  根据授权状态加载不同视图
 */
- (void)chooseDefaultView {
    if ([JFUserAccount shareUserAccount].isAuth) {
        [super loadView];
    } else {
        JFHomeVisitorView *homeVisitor = [[JFHomeVisitorView alloc] init];
        homeVisitor.delegateSignal = [RACSubject subject];
        [homeVisitor.delegateSignal subscribeNext:^(id x) {
            // modal出授权控制器
            [self presentViewController:[[JFNavigationController alloc] initWithRootViewController:[[JFOAuthViewController alloc] init]] animated:YES completion:nil];
        }];
        self.view = homeVisitor;
        
    }
}

#pragma mark - 加载微博数据
/**
 *  加载微博数据
 */
- (void)loadStatus {
    [SVProgressHUD showWithStatus:@"正在加载微博数据" maskType:SVProgressHUDMaskTypeBlack];
    
    // 加载微博数据
    [JFStatus loadStatus:^(NSArray *list, NSError *error) {
        
        // 加载出错
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"加载微博数据失败" maskType:SVProgressHUDMaskTypeBlack];
            return;
        }
        
        // 没有新数据
        if (list == nil || list.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"没有新的微博数据" maskType:SVProgressHUDMaskTypeBlack];
            return;
        }
        
        // 隐藏提示
        [SVProgressHUD dismiss];
        self.statuses = [list mutableCopy];
        
        // 刷新
        [self.tableView reloadData];
        
//        NSLog(@"%@",self.statuses);
        
    }];
}


#pragma mark - Table view data source

/**
 *  第section组有多少行cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

/**
 *  创建每行cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取当前cell对应微博模型
    JFStatus *status = self.statuses[indexPath.row];
    
    // 判断是否是转发微博，创建不同cell
    JFStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:status.retweeted_status ? forwardCell : normalCell forIndexPath:indexPath];
    
    cell.status = status;
    
    return cell;
}

/**
 *  返回每行cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取当前cell的微博模型
    JFStatus *status = self.statuses[indexPath.row];
    
    // 获取当前cell
    JFStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:status.retweeted_status ? forwardCell : normalCell];
    
    // 重新布局当前cell并计算cell高度
    CGFloat rowHeight = [cell rowHeight:status];
    
    return rowHeight;
}

/**
 *  选中了某行cell
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - setters and getters or 懒加载
// 懒加载微博模型数组
- (NSMutableArray *)statuses {
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

@end
