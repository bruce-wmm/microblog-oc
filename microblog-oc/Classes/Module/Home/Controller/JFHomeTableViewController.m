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

@interface JFHomeTableViewController ()

@end

@implementation JFHomeTableViewController

- (void)loadView {
    // 根据授权状态加载不同视图
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[JFUserAccount shareUserAccount]);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
