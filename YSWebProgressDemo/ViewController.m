//
//  ViewController.m
//  YSWebProgressDemo
//
//  Created by zys on 2016/11/2.
//  Copyright © 2016年 张永帅. All rights reserved.
//

#import "ViewController.h"
#import "YSWebProgress.h"

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) YSWebProgress *webProgress;

@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters
- (YSWebProgress *)webProgress {
    if (!_webProgress) {
        _webProgress = [YSWebProgress new];
        [self.webView addSubview:_webProgress];
    }
    return _webProgress;
}

#pragma mark - load web
- (IBAction)loadWeb:(id)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:request];
    self.navigationItem.title = @"加载中...";
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.webProgress startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webProgress endProgress];
    NSString *h5Title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = h5Title;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.webProgress endProgress];
    self.navigationItem.title = @"出错了～";
}

@end
