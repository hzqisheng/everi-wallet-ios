//
//  QSWebViewViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSWebViewViewController : QSBaseViewController<WKNavigationDelegate, WKUIDelegate>

/// 是否使用网页标题作为nav标题，默认YES
@property (nonatomic, assign) BOOL useMPageTitleAsNavTitle;

/// 是否显示加载进度，默认YES
@property (nonatomic, assign) BOOL showLoadingProgress;

/// 是否禁止历史记录，默认NO
@property (nonatomic, assign) BOOL disableBackButton;

/// 是否显示网页的来源信息，默认YES
@property (nonatomic, assign) BOOL showPageInfo;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) WKWebView *webView;

- (id)initWithUrl:(NSString *)urlString;

- (id)initWithRequest:(NSURLRequest *)request;

- (void)loadRequest:(NSURLRequest *)request;

- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

@end

NS_ASSUME_NONNULL_END
