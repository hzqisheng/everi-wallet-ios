//
//  QSEveriApiWebViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriApiWebViewController.h"

#define kResponseArrayKey @"data"

typedef void(^DataResponseBlock)(NSInteger statusCode, NSDictionary *responseDic);

@interface QSEveriApiWebViewController ()<WKScriptMessageHandler>

@property (nonatomic, strong) NSMutableDictionary<NSString *,DataResponseBlock> *methodAndCallbackDic;

@end

@implementation QSEveriApiWebViewController

+ (instancetype)sharedWebView {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:@"needPrivateKey"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [super webView:webView didFinishNavigation:navigation];

    @weakify(self);
    [self evtInitAndCompeleteyBlock:^{
        @strongify(self);
        if (self.initSuccessBlock) {
            self.initSuccessBlock();
        }
    }];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSString *responseJsonString = message.body[@"content"];
    NSDictionary *responseDataDic = [self dictionaryWithJsonString:responseJsonString];
    NSLog(@"收到回调方法%@",message.name);// 方法名
    if ([responseDataDic isKindOfClass:[NSArray class]]) {
        responseDataDic = @{kResponseArrayKey: responseDataDic};
    }
    NSLog(@"收到回调=========\n%@",responseDataDic);// 传递的数据
    if ([message.name isEqualToString:@"needPrivateKey"]) {
        //需要私钥 弹出输入框
        DLog(@"需要私钥");
    } else {
        //请求回调
        for (NSString *key in self.methodAndCallbackDic.allKeys) {
            if ([key isEqualToString:message.name]) {
                DataResponseBlock responseBlock = [self.methodAndCallbackDic objectForKey:key];
                responseBlock(kResponseSuccessCode,responseDataDic);
                break;
            }
        }
    }
}

#pragma mark - **************** Api
- (void)createEvtWalletWithPassword:(NSString *)password andCompeleteBlock:(void (^)(NSInteger, QSCreateEvt * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"createEVTWallet('%@')",password];
    [self excuteRequestWithMethodName:@"createEVTWallet"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSCreateEvt *evt;
                        if (statusCode == kResponseSuccessCode) {
                            evt = [QSCreateEvt mj_objectWithKeyValues:responseDic];
                        }
                        block (statusCode, evt);
                    }];
}

- (void)importEVTWalletWithMnemoinc:(NSString *)mnemoinc password:(NSString *)password andCompeleteBlock:(nonnull void (^)(NSInteger, QSCreateEvt * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"importEVTWallet('%@','%@')",mnemoinc, password];
    [self excuteRequestWithMethodName:@"importEVTWallet"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSCreateEvt *evt;
                        if (statusCode == kResponseSuccessCode) {
                            evt = [QSCreateEvt mj_objectWithKeyValues:responseDic];
                        }
                        block (statusCode, evt);
                    }];
}

- (void)evtInitAndCompeleteyBlock:(void (^)(void))block {
    NSString *jsString = [NSString stringWithFormat:@"EVTInit()"];
    [self excuteRequestWithMethodName:@"EVTInit"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        block();
                    }];
}

- (void)getOwnedTokensWithPublicKeys:(NSString *)publicKeys andCompeleteBlock:(nonnull void (^)(NSInteger, NSArray<QSOwnedToken *> * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"getOwnedTokens('%@')",publicKeys];
    [self excuteRequestWithMethodName:@"getOwnedTokens"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSArray *ownedTokens;
                        if (statusCode == kResponseSuccessCode) {
                            ownedTokens = [QSOwnedToken mj_objectArrayWithKeyValuesArray:responseDic[kResponseArrayKey]];
                        }
                        block(statusCode, ownedTokens);
                    }];
}

- (void)getFungibleBalanceWithAddress:(NSString *)address andCompeleteBlock:(void (^)(NSInteger, NSArray<NSString *> * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"getFungibleBalance('%@')",address];
    [self excuteRequestWithMethodName:@"getFungibleBalance"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        block(statusCode, responseDic[kResponseArrayKey]);
                    }];
}

- (void)getCreatedFungiblesWithPublicKeys:(NSString *)publicKeys andCompeleteBlock:(void (^)(NSInteger, NSArray<NSString *> * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"getCreatedFungibles('%@')",publicKeys];
    [self excuteRequestWithMethodName:@"getCreatedFungibles"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSArray *fungibles;
                        if (statusCode == kResponseSuccessCode) {
                            fungibles = responseDic[@"ids"];
                        }
                        block(statusCode, fungibles);
                    }];
}

- (void)getFungibleSymbolDetailWithSymId:(NSString *)symId
                       andCompeleteBlock:(void(^)(NSInteger statusCode, QSFungibleSymbol * fungibleSymbol))block {
    NSString *jsString = [NSString stringWithFormat:@"getFungibleSymbolDetail('%@')",symId];
    [self excuteRequestWithMethodName:@"getFungibleSymbolDetail"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSFungibleSymbol *fungibleSymbol;
                        if (statusCode == kResponseSuccessCode) {
                            fungibleSymbol = [QSFungibleSymbol mj_objectWithKeyValues:responseDic];
                        }
                        block(statusCode, fungibleSymbol);
                    }];
}

- (void)pushTransactionAndCompeleteBlock:(void (^)(NSInteger, QSFungibleSymbol * _Nonnull))block {
    NSString *publicKey = [QSWalletHelper sharedHelper].currentEvt.publicKey;//publickey
    NSString *content = [NSString stringWithFormat:@"{\"name\":\"ABC.POINTS\",\"sym_name\":555,\"sym\":\"5,S#555\",\"creator\":\"EVT6qVps8htVyXVn4NjXVNJeJukT8GrLyfQVYtgL5gyHpHbSgtTCa\",\"manage\":{\"name\":\"manage\",\"threshold\":1,\"authorizers\":[{\"ref\":\"[A] %@\",\"weight\":1}]},\"issue\":{\"name\":\"issue\",\"threshold\":1,\"authorizers\":[{\"ref\":\"[A] %@\",\"weight\":1}]},\"total_supply\":\"100000.00000 S#555\"}",publicKey,publicKey];
    NSString *jsString = [NSString stringWithFormat:@"pushTransaction('newfungible','%@')",content];
    [self excuteRequestWithMethodName:@"pushTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSFungibleSymbol *fungibleSymbol;
                        if (statusCode == kResponseSuccessCode) {
                            fungibleSymbol = [QSFungibleSymbol mj_objectWithKeyValues:responseDic];
                        }
                        block(statusCode, fungibleSymbol);
                    }];
}

- (void)excuteRequestWithMethodName:(NSString *)methodsName
                           jsString:(NSString *)jsString
                     completionHandler:(void (^)(NSInteger statusCode, NSDictionary *responseDic))completionHandler {
    NSString *callbackMethodName = [NSString stringWithFormat:@"%@Callback",methodsName];
    [[self.webView configuration].userContentController removeScriptMessageHandlerForName:callbackMethodName];
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:callbackMethodName];
    [self.methodAndCallbackDic setObject:completionHandler forKey:callbackMethodName];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
    }];
}

#pragma mark - **************** Private Methods
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSMutableDictionary<NSString *,DataResponseBlock> *)methodAndCallbackDic {
    if (!_methodAndCallbackDic) {
        _methodAndCallbackDic = [NSMutableDictionary dictionary];
    }
    return _methodAndCallbackDic;
}


@end
