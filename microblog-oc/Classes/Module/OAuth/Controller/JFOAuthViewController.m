//
//  JFOAuthViewController.m
//  microblog-oc
//
//  Created by jianfeng on 15/10/29.
//  Copyright © 2015年 六阿哥. All rights reserved.
//

#import "JFOAuthViewController.h"
#import "JFHTTPTools.h"
#import "JFWelcomeViewController.h"
#import "UIApplication+Extension.h"

@interface JFOAuthViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JFOAuthViewController

/**
 *  替换视图
 */
- (void)loadView {
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载授权请求界面
    [self.webView loadRequest:[NSURLRequest requestWithURL: [[JFHTTPTools shareHTTPTools] getOAuthUrl]]];
    
    // 添加导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自动填充密码" style:UIBarButtonItemStylePlain target:self action:@selector(autoEditPassword)];
}

/**
 *  关闭授权界面
 */
- (void)close {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  自动输入资料
 */
- (void)autoEditPassword {
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('userId').value = 'micfeng@hotmail.com';document.getElementById('passwd').value = 'feng100.0918';"];
}

#pragma mark - UIWebViewDelegate
/**
 *  开始加载
 */
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:@"正在加载" maskType:SVProgressHUDMaskTypeBlack];
}

/**
 *  加载完成
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

/**
 *  是否要加载网络请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // 获取完整请求字符串
    NSString *absoluteString = [request.URL absoluteString];
    
    // 如果不是回调地址就加载
    if (![absoluteString hasPrefix:kRedirect_uri]) {
        return YES;
    }
    
    // 是回调地址再判断是点击了取消还是授权
    // 获取请求参数
    NSString *queryString = request.URL.query;
    // 确认授权的参数前缀一定是 code=
    NSString *preString = @"code=";
    
    // 如果参数前缀不是 code= 点击了取消
    if (![queryString hasPrefix:preString]) {
        [self close];
        return NO;
    }
    
    // 截取code
    NSString *code = [queryString substringFromIndex:preString.length];
    
    // 根据code获取access_token
    [[JFHTTPTools shareHTTPTools] loadAccessToken:code finished:^(NSDictionary *result, NSError *error) {
        if (result == nil && error != nil) {
            // 获取失败
            [SVProgressHUD showWithStatus:@"授权失败" maskType:SVProgressHUDMaskTypeBlack];
            [self close];
        } else {
            // 获取access_token成功，先归档一次用户账号
            [[JFUserAccount shareUserAccount] saveUserInfoWithDictionary:result];
            
            // 加载用户信息
            [[JFUserAccount shareUserAccount] loadUserInfo:^(NSError *error) {
                if (error) {
                    // 获取失败
                    [SVProgressHUD showWithStatus:@"加载用户信息失败" maskType:SVProgressHUDMaskTypeBlack];
                    // 关闭当前控制器
                    [self close];
                } else {
                    // 加载用户信息成功，进入欢迎页
                    [UIApplication switchViewController:[[JFWelcomeViewController alloc] init]];
                    // 关闭当前控制器
                    [self close];
                }
            }];
        }
    }];
    
    return NO;
}

#pragma mark - setters and getters or 懒加载
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
    
}

@end
