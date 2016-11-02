# YSWebProgress
YSWebProgress是一款仿照微信的webView加载进度条控件。
使用示例：

```
// 创建progress对象，作为实例成员
- (YSWebProgress *)webProgress {
    if (!_webProgress) {
        _webProgress = [YSWebProgress new];
        [self.webView addSubview:_webProgress];
    }
    return _webProgress;
}
```

```
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 开始加载，显示进度条
    [self.webProgress startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 结束加载，隐藏进度条
    [self.webProgress endProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 结束加载，隐藏进度条
    [self.webProgress endProgress];
}
```
