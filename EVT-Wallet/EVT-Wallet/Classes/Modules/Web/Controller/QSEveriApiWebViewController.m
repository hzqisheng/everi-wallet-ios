//
//  QSEveriApiWebViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriApiWebViewController.h"
#import "QSPrivatekeyAlertView.h"
#import "QSAuthorizers.h"
#import "QSScanGetAddress.h"
#import "QSScanAddress.h"
#import "NSBundle+QSLanguageUtils.h"

#define kResponseArrayKey @"data"
#define kResponseStringKey @"data"
#define kResponseNumberKey @"data"
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
    [[self.webView configuration].userContentController addScriptMessageHandler:self name:@"needPrivateKey"];
    WKUserContentController *userCC = [self.webView configuration].userContentController;
    [userCC addScriptMessageHandler:self name:@"log"];
    [self showConsole];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.120:8080/h5/"]]];
}


- (void)showConsole {
    //rewrite the method of console.log
    NSString *jsCode = @"console.log = (function(oriLogFunc){\
    return function(str)\
    {\
    window.webkit.messageHandlers.log.postMessage(str);\
    oriLogFunc.call(console,str);\
    }\
    })(console.log);";
    
    //injected the method when H5 starts to create the DOM tree
    [self.webView.configuration.userContentController addUserScript:[[WKUserScript alloc] initWithSource:jsCode injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES]];
}

- (void)reloadWebView {
    [self.webView reload];
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
    
    if ([message.name isEqualToString:@"log"]) {
        NSLog(@"consule.log:%@",message.body);
        return;
    }
    
    NSString *responseJsonString = message.body;
    NSDictionary *responseDataDic = [self dictionaryWithJsonString:responseJsonString];
    NSNumber *code = responseDataDic[@"code"];
    id messageObject = responseDataDic[@"message"];
    NSDictionary *dic = responseDataDic[@"data"];
    NSLog(@"messageName:%@",message.name);
    DLog(@"\n\n\n%@\n\n\n",message.body);    
    if (![code.stringValue isEqualToString:@"1"]) {
        if ([messageObject isKindOfClass:[NSDictionary class]]) {
            NSString *chineseMsg = messageObject[@"cn"];
            NSString *englishMsg = messageObject[@"en"];
            if ([NSBundle isChineseLanguage]) {
                [QSAppKeyWindow showAutoHideHudWithText:chineseMsg];
            } else {
                [QSAppKeyWindow showAutoHideHudWithText:englishMsg];
            }
        } else if ([messageObject isKindOfClass:[NSString class]]) {
            [QSAppKeyWindow showAutoHideHudWithText:messageObject];
        }
        
        for (NSString *key in self.methodAndCallbackDic.allKeys) {
            if ([key isEqualToString:message.name]) {
                    DataResponseBlock responseBlock = [self.methodAndCallbackDic objectForKey:key];
                    responseBlock(kResponseFailCode,dic);
                    break;
            }
        }
        return;
    }
    
    if ([dic isKindOfClass:[NSArray class]]) {
        dic = @{kResponseArrayKey: dic};
    } else if ([dic isKindOfClass:[NSString class]]) {
        dic = @{kResponseStringKey : dic};
    } else if ([dic isKindOfClass:[NSNumber class]]) {
        dic = @{kResponseNumberKey : dic};
    }
    NSLog(@"收到回调=========\n%@",dic);// 传递的数据
    if ([message.name isEqualToString:@"needPrivateKey"]) {
        //需要私钥 弹出输入框
        WeakSelf(weakSelf);
        [QSPasswordHelper verificationPasswordByPrivateKey:QSPrivateKey andSuccessBlock:^{
            [weakSelf needPrivateKeyResponseWithMessage:message andDic:dic];
        }];
    } else {
        //请求回调
        for (NSString *key in self.methodAndCallbackDic.allKeys) {
            if ([key isEqualToString:message.name]) {
                DataResponseBlock responseBlock = [self.methodAndCallbackDic objectForKey:key];
                responseBlock(kResponseSuccessCode,dic);
                break;
            }
        }
    }
}

#pragma mark - **************** Api
- (void)createEvtWalletWithPassword:(NSString *)password andCompeleteBlock:(void (^)(NSInteger, QSCreateEvt * _Nonnull))block {
    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_alert_content_isCreate")];
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
    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_alert_content_isRecover")];
    NSString *jsString = [NSString stringWithFormat:@"importEVTWallet('%@','%@')",mnemoinc, password];
    [self excuteRequestWithMethodName:@"importEVTWallet"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSCreateEvt *evt;
                        if (statusCode == kResponseSuccessCode) {
                            [QSAppKeyWindow hideHud];
                            evt = [QSCreateEvt mj_objectWithKeyValues:responseDic];
                        }
                        block (statusCode, evt);
                    }];
}

- (void)checkValidateMnemonic:(NSString *)mnemonic
            andCompeleteBlock:(nonnull void (^)(NSInteger, BOOL))block {
    NSString *jsString = [NSString stringWithFormat:@"validateMnemonic('%@')",mnemonic];
    [self excuteRequestWithMethodName:@"validateMnemonic"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSNumber *resultNumber;
                        if (statusCode == kResponseSuccessCode) {
                            resultNumber = responseDic[@"data"];
                        }
                        block (statusCode, resultNumber.boolValue);
                    }];
}

- (void)checkValidPrivateKey:(NSString *)privateKey
           andCompeleteBlock:(void(^)(NSInteger statusCode, BOOL isValid))block {
    NSString *jsString = [NSString stringWithFormat:@"isValidPrivateKey('%@')",privateKey];
    [self excuteRequestWithMethodName:@"isValidPrivateKey"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSNumber *resultNumber;
                        if (statusCode == kResponseSuccessCode) {
                            resultNumber = responseDic[@"data"];
                        }
                        block (statusCode, resultNumber.boolValue);
                    }];
}

- (void)privateToPublicWithPrivateKey:(NSString *)privateKey andCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"privateToPublic('%@')",privateKey];
    [self excuteRequestWithMethodName:@"privateToPublic"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *publicKey = @"";
                        if (statusCode == kResponseSuccessCode) {
                            publicKey = responseDic[kResponseStringKey];
                        }
                        block (statusCode, publicKey);
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
    NSString *jsString = [NSString stringWithFormat:@"getFungibleSymbolDetail(%@)",symId];
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

- (void)isValidAddressWithAddress:(NSString *)address andCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"isValidPublicKey('%@')",address];
    [self excuteRequestWithMethodName:@"isValidPublicKey"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        if (statusCode == kResponseSuccessCode) {
                            NSNumber *isCorrect = responseDic[kResponseNumberKey];
                            block(statusCode, [isCorrect stringValue]);
                        } else {
                            block(statusCode, @"");
                        }
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

- (void)getEVTFungiblesListWithPublicKey:(NSString *)publicKey andCompeleteBlock:(void (^)(NSInteger, NSArray * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"getEVTFungiblesList('%@')",QSPublicKey];
    [self excuteRequestWithMethodName:@"getEVTFungiblesList"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSArray *ftArray;
                        if (statusCode == kResponseSuccessCode) {
                            ftArray = [QSFT mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
                        }
                        block(statusCode, ftArray);
                    }];
}

- (void)getEVTFungibleBalanceListWithPublicKey:(NSString *)publicKey andCompeleteBlock:(void (^)(NSInteger, NSArray * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"getEVTFungibleBalanceList('%@')",QSPublicKey];
    [self excuteRequestWithMethodName:@"getEVTFungibleBalanceList"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSArray *ftArray;
                        if (statusCode == kResponseSuccessCode) {
                            ftArray = [QSFT mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
                        }
                        block(statusCode, ftArray);
                    }];
}

- (void)getEVTDomainsListWithPublicKey:(NSString *)publicKey andCompeleteBlock:(void (^)(NSInteger, NSArray * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"getEVTDomainsList('%@')",publicKey];
    [self excuteRequestWithMethodName:@"getEVTDomainsList"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSArray *ftArray;
                        if (statusCode == kResponseSuccessCode) {
                            ftArray = [QSNFT mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
                        }
                        block(statusCode, ftArray);
                    }];
}

- (void)pushTransactionWithActionName:(NSString *)actionName andFt:(QSFT *)ft andConfig:(NSString *)config andCompeleteBlock:(void (^)(NSInteger, QSFT * _Nonnull))block {
    QSFTIssue *issue = ft.issue;
    NSArray *issueAuthorizers = @[];
    if (issue.threshold == 1) {
        QSAuthorizers *issueAuth = issue.authorizers[0];
        issueAuthorizers = @[@{
                                 @"ref": QSNoNilString(issueAuth.ref),
                                 @"weight": @(issueAuth.weight)
                                 }];
    }
    
    NSArray *manageAuthorizers = @[];
    QSFTManage *manage = ft.manage;
    if (manage.threshold == 1) {
        QSAuthorizers *manageAuth = manage.authorizers[0];
        manageAuthorizers = @[@{
                                 @"ref": QSNoNilString(manageAuth.ref),
                                 @"weight": @(manageAuth.weight)
                                 }];
    }

    NSDictionary *newFungibleDic = @{
                                     @"availablePublicKeys": @[
                                             QSPublicKey
                                             ],
                                     @"creator": QSPublicKey,
                                     @"issue": @{
                                             @"authorizers": issueAuthorizers,
                                             @"name": @"issue",
                                             @"threshold": @(issue.threshold)
                                             },
                                     @"manage": @{
                                             @"authorizers": manageAuthorizers,
                                             @"name": @"manage",
                                             @"threshold": @(manage.threshold)
                                             },
                                     @"name": ft.name,
                                     @"sym": ft.sym,
                                     @"sym_name": ft.sym_name,
                                     @"total_supply": ft.total_supply
                                     };
    
    NSString *creator = [NSString stringWithFormat:@"[A] %@",QSPublicKey];
    NSString *valueString = config.length ? [NSString stringWithFormat:@"data:image/jpeg;base64,%@",config] : @"";
    NSDictionary *addMetaDic = @{@"key":@"icon",
                                 @"value":valueString,
                                 @"creator":creator};
    
    NSArray *bodyArray = @[newFungibleDic,addMetaDic];
    NSString *bodyArrayJsonString = [bodyArray mj_JSONString];
    NSString *restJsonString = [NSString stringWithFormat:@",{},'.fungible',%@",ft.assetNumber];
    NSString *totalString = [bodyArrayJsonString stringByAppendingString:restJsonString];

    NSString *jsString = [NSString stringWithFormat:@"pushTransaction('newfungible,addmeta',%@)",totalString];
    [self excuteRequestWithMethodName:@"pushTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSFT *ftmodel;
                        if (statusCode == kResponseSuccessCode) {
                            
                        }
                        block(statusCode, ftmodel);
                    }];
}

- (void)pushTransactionWithActionEveriLink:(NSString *)everiLink andAsset:(NSString *)asset andaddress:(NSString *)address andCompeleteBlock:(void (^)(NSInteger))block {
    NSString *content = [NSString stringWithFormat:@"{\"link\":\"%@\",\"payee\":\"%@\",\"number\":\"%@\"}",everiLink,address,asset];
    NSString *jsString = [NSString stringWithFormat:@"pushTransaction('%@','%@')",@"everipay",content];
    [self excuteRequestWithMethodName:@"pushTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        block(statusCode);
                    }];
}

- (void)pushTransactionIssueWithCirculation:(NSString *)circulation andAddress:(NSString *)address andNote:(NSString *)note andCompeleteBlock:(void (^)(NSInteger))block {
    NSString *content = [NSString stringWithFormat:@"{\"address\":\"%@\",\"memo\":\"%@\",\"number\":\"%@\"}",address,note,circulation];
    NSString *jsString = [NSString stringWithFormat:@"pushTransaction('%@','%@')",@"issuefungible",content];
    [self excuteRequestWithMethodName:@"pushTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        block(statusCode);
                    }];
}

- (void)pushTransactionNFTWithNFT:(QSNFT *)nft andCompeleteBlock:(void (^)(NSInteger, QSNFT * _Nonnull))block {
    QSNFTTransfer *issue = [[QSNFTTransfer alloc] init];
    issue = nft.issue;
    issue.threshold = 1;
    
    NSString *issueString = @"";
    if (issue.threshold == 1) {
        QSAuthorizers *issueAuth = issue.authorizers[0];
        issueString = [NSString stringWithFormat:@"[{\"ref\":\"%@\",\"weight\":%ld}]",issueAuth.ref,(long)issueAuth.weight];
    } else {
        issueString = [NSString stringWithFormat:@"[]"];
    }
    QSNFTTransfer *manage = [[QSNFTTransfer alloc] init];
    manage = nft.manage;
    manage.threshold = 1;
    
    
    NSString *manageString = @"";
    if (manage.threshold == 1) {
        QSAuthorizers *manageAuth = manage.authorizers[0];
        manageString = [NSString stringWithFormat:@"[{\"ref\":\"%@\",\"weight\":%ld}]",manageAuth.ref,(long)manageAuth.weight];
    } else {
        manageString = [NSString stringWithFormat:@"[]"];
    }
    QSNFTTransfer *transfer = [[QSNFTTransfer alloc] init];
    transfer = nft.manage;
    transfer.threshold = 1;
    
    
    NSString *transferString = @"";
    if (transfer.threshold == 1) {
        QSAuthorizers *transferAuth = transfer.authorizers[0];
        transferString = [NSString stringWithFormat:@"[{\"ref\":\"%@\",\"weight\":%ld}]",transferAuth.ref,(long)transferAuth.weight];
    } else {
        transferString = [NSString stringWithFormat:@"[]"];
    }
    
    NSString *content = [NSString stringWithFormat:@"{\"creator\":\"%@\",\"issue\":{\"authorizers\":%@,\"name\":\"issue\",\"threshold\":%ld},\"manage\":{\"authorizers\":%@,\"name\":\"manage\",\"threshold\":%ld},\"transfer\":{\"authorizers\":%@,\"name\":\"transfer\",\"threshold\":%ld},\"metas\":[{\"key\":\"symbol-icon\",\"value\":\"data:image/png;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/4gHoSUNDX\"}],\"name\":\"%@\"}",nft.creator,issueString,(long)issue.threshold,manageString,(long)manage.threshold,transferString,(long)transfer.threshold,nft.name];
    NSString *jsString = [NSString stringWithFormat:@"pushTransaction('%@','%@')",@"newdomain",content];
    [self excuteRequestWithMethodName:@"pushTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSNFT *NFTModel;
                        if (statusCode == kResponseSuccessCode) {
                            
                        }
                        block(statusCode, NFTModel);
                    }];
}

- (void)getEvtLinkForPayeeCodeAndCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *content = [NSString stringWithFormat:@"{\"address\":\"%@\"}",QSPublicKey];
    NSString *jsString = [NSString stringWithFormat:@"getEvtLinkForPayeeCode('%@')",content];
    [self excuteRequestWithMethodName:@"getEvtLinkForPayeeCode"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *addressCodeString = @"";
                        if (statusCode == kResponseSuccessCode) {
                            addressCodeString = responseDic[@"rawText"];
                        }
                        block(statusCode , addressCodeString);
                    }];
}

- (void)getUniqueLinkIdAndCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *jsString = [NSString stringWithFormat:@"getUniqueLinkId()"];
    [self excuteRequestWithMethodName:@"getUniqueLinkId"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *linkId = @"";
                        if (statusCode == kResponseSuccessCode) {
                            linkId = responseDic[@"data"];
                        }
                        block(statusCode , linkId);
                    }];
}

- (void)getEvtLinkForEveriPayWithSym:(NSString *)sym andMaxAmount:(NSString *)maxAmount andLinkId:(NSString *)linkId AndCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *content = [NSString stringWithFormat:@"{\"keyProvider\":[\"%@\"],\"symbol\":%@,\"maxAmount\":%@,\"linkId\":\"%@\"}",QSPrivateKey,sym,maxAmount,linkId];
    NSString *jsString = [NSString stringWithFormat:@"getEvtLinkForEveriPay('%@')",content];
    [self excuteRequestWithMethodName:@"getEvtLinkForEveriPay"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *addressCodeString = @"";
                        if (statusCode == kResponseSuccessCode) {
                            addressCodeString = responseDic[@"rawText"];
                        }
                        block(statusCode , addressCodeString);
                    }];
}

- (void)getStatusOfEvtLinkWithLink:(NSString *)link AndCompeleteBlock:(nonnull void (^)(NSInteger, QSEvtLinkStatus * _Nonnull))block {
    NSString *content = [NSString stringWithFormat:@"'{\"linkId\":\"%@\"}'",link];
    NSString *jsString = [NSString stringWithFormat:@"getStatusOfEvtLink(%@)",content];
    [self excuteRequestWithMethodName:@"getStatusOfEvtLink"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        QSEvtLinkStatus *status;
                        if (statusCode == kResponseSuccessCode) {
                             status = [QSEvtLinkStatus mj_objectWithKeyValues:responseDic];
                        }
                        block(statusCode, status);
                    }];
}

- (void)getEVTLinkQrImageWithSym:(NSString *)sym andMaxAmount:(NSString *)maxAmount andLinkId:(NSString *)linkId AndCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *content = [NSString stringWithFormat:@"{\"keyProvider\":[\"%@\"],\"symbol\":%@,\"maxAmount\":%@,\"linkId\":\"%@\"}",QSPrivateKey,sym,maxAmount,linkId];
    NSString *autoReload = @"{\"autoReload\":\"ture\"}";
    NSString *jsString = [NSString stringWithFormat:@"getEVTLinkQrImage('%@','%@','%@')",@"everiPay",content,autoReload];
    [self excuteRequestWithMethodName:@"getEVTLinkQrImage"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *addressCodeString = @"";
                        if (statusCode == kResponseSuccessCode) {
                            NSMutableString * dataString = [[NSMutableString alloc] initWithString:responseDic[@"dataUrl"]];
                            NSRange range = [dataString rangeOfString:@"data:image/png;base64,"];
                            [dataString deleteCharactersInRange:range];
                            addressCodeString = dataString;
                        }
                        block(statusCode , addressCodeString);
                    }];
}

- (void)getEveriPassQrImageWithDomain:(NSString *)domain
                                 name:(NSString *)name
                    andCompeleteBlock:(void(^)(NSInteger statusCode, NSString *addressCodeString))block {
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [bodyDic setObject:QSNoNilString(domain) forKey:@"domainName"];
    [bodyDic setObject:QSNoNilString(name) forKey:@"tokenName"];
    bool bool_false = false;
    [bodyDic setObject:@(bool_false) forKey:@"autoDestroying"];
    NSString *bodyJsonString = [bodyDic mj_JSONString];
    
    NSMutableDictionary *bodyDicReload = [[NSMutableDictionary alloc] initWithCapacity:0];
    bool bool_true = true;
    [bodyDicReload setObject:@(bool_true) forKey:@"autoReload"];
    NSString *bodyDicReloadJsonString = [bodyDicReload mj_JSONString];

    NSString *jsString = [NSString stringWithFormat:@"getEVTLinkQrImage('%@','%@','%@')",@"everiPass",bodyJsonString,bodyDicReloadJsonString];
    [self excuteRequestWithMethodName:@"getEVTLinkQrImage"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *addressCodeString = @"";
                        if (statusCode == kResponseSuccessCode) {
                            NSMutableString * dataString = [[NSMutableString alloc] initWithString:responseDic[@"dataUrl"]];
                            NSRange range = [dataString rangeOfString:@"data:image/png;base64,"];
                            [dataString deleteCharactersInRange:range];
                            addressCodeString = dataString;
                        }
                        block(statusCode , addressCodeString);
                    }];
}

- (void)stopEVTLinkQrImageReload {
    NSString *jsString = [NSString stringWithFormat:@"stopEVTLinkQrImageReload()"];
    [self excuteRequestWithMethodName:@"stopEVTLinkQrImageReload"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                    }];
}

- (void)parseEvtLinkWithAddress:(NSString *)address AndCompeleteBlock:(nonnull void (^)(NSInteger, NSArray * _Nonnull, NSInteger))block {
    NSString *jsString = [NSString stringWithFormat:@"parseEvtLink('%@')",address];
    [self excuteRequestWithMethodName:@"parseEvtLink"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSArray *modelList;
                        NSInteger flag = 0;
                        if (statusCode == kResponseSuccessCode) {
                            QSScanGetAddress *getAddress = [QSScanGetAddress mj_objectWithKeyValues:responseDic];
                            modelList = [NSArray arrayWithArray:getAddress.segments];
                            flag = [responseDic[@"flag"] integerValue];
                        }
                        block(statusCode , modelList, flag);
                    }];
}

- (void)getEstimatedChargeForTransactionWithAddress:(NSString *)address andBeneficiary:(NSString *)beneficiaryAddress andCount:(NSString *)count andMemo:(NSString *)memo AndCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *contentStr = [NSString stringWithFormat:@"{\"from\":\"%@\",\"to\":\"%@\",\"number\":\"%@\",\"memo\":\"%@\"}",QSPublicKey,beneficiaryAddress,count,memo];
    NSString *publicKeyStr = [NSString stringWithFormat:@"{\"availablePublicKeys\":[\"%@\"]}",QSPublicKey];
    NSString *jsString = [NSString stringWithFormat:@"getEstimatedChargeForTransaction('%@','%@','%@')",@"transferft",contentStr,publicKeyStr];
    [self excuteRequestWithMethodName:@"getEstimatedChargeForTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *addressCodeString = @"";
                        if (statusCode == kResponseSuccessCode) {
                            NSNumber *number = responseDic[@"charge"];
                            double money = [number doubleValue];
                            addressCodeString = [NSString stringWithFormat:@"%f",money * 0.00001];
                        }
                        block(statusCode , addressCodeString);
                    }];
}

- (void)pushTransactionFukuanWithAddress:(NSString *)address andBeneficiary:(NSString *)beneficiaryAddress andCount:(NSString *)count andMemo:(NSString *)memo AndCompeleteBlock:(void (^)(NSInteger, NSString * _Nonnull))block {
    NSString *contentStr = [NSString stringWithFormat:@"{\"from\":\"%@\",\"to\":\"%@\",\"number\":\"%@\",\"memo\":\"%@\"}",QSPublicKey,beneficiaryAddress,count,memo];
    NSString *jsString = [NSString stringWithFormat:@"pushTransaction('%@','%@')",@"transferft",contentStr];
    [self excuteRequestWithMethodName:@"pushTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSString *addressCodeString = @"";
                        if (statusCode == kResponseSuccessCode) {
                            NSNumber *number = responseDic[@"charge"];
                            double money = [number doubleValue];
                            addressCodeString = [NSString stringWithFormat:@"%f",money * 0.00001];
                        }
                        block(statusCode , addressCodeString);
                    }];
}

- (void)pushTransactionNFTWithDomain:(NSString *)domain andNameArr:(NSArray *)nameArr andOwner:(NSString *)owner AndCompeleteBlock:(void (^)(NSInteger))block {
    NSString *arrStr = @"";
    for (int i = 0; i < nameArr.count; i++) {
        if (i == 0) {
            NSString *arrstring = nameArr[i];
            arrStr = [arrStr stringByAppendingString:[NSString stringWithFormat:@"\"%@\"",arrstring]];
        } else {
            NSString *arrstring = nameArr[i];
            arrStr = [arrStr stringByAppendingString:[NSString stringWithFormat:@",\"%@\"",arrstring]];
        }
    }
    NSString *contentStr = [NSString stringWithFormat:@"{\"domain\":\"%@\",\"names\":[%@],\"owner\":[\"%@\"]}",domain,arrStr,owner];
    NSString *jsString = [NSString stringWithFormat:@"pushTransaction('%@','%@')",@"issuetoken",contentStr];
    [self excuteRequestWithMethodName:@"pushTransaction"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        if (statusCode == kResponseSuccessCode) {
                            
                        }
                        block(statusCode);
                    }];
}

- (void)getActionsWithFTModel:(QSFT *)FTModel AndCompeleteBlock:(nonnull void (^)(NSInteger, NSArray * _Nonnull))block {
    NSString *numberStr = @"";
    NSArray *numberArr = [FTModel.sym componentsSeparatedByString:@"#"];
    if (numberArr.count == 2) {
        numberStr = numberArr[1];
    }
    NSString *content = [NSString stringWithFormat:@"%@,\"%@\",0,10",numberStr,QSPublicKey];
    NSString *jsString = [NSString stringWithFormat:@"getFungibleActionsByAddress(%@)",content];
    [self excuteRequestWithMethodName:@"getFungibleActionsByAddress"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        NSArray *list = @[];
                        if (statusCode == kResponseSuccessCode) {
                            NSDictionary *dataDic = responseDic[@"data"];
                            list = [QSTransferftModel mj_objectArrayWithKeyValuesArray:dataDic];
                        }
                        block(statusCode,list);
                    }];
}

- (void)changeNetworkByHost:(NSString *)host
          andCompeleteBlock:(void(^)(NSInteger statusCode))block {
    NSDictionary *dataDic = @{
                              @"host":QSNoNilString(host),
                              @"port":@(443),
                              @"protocol":@"https"
                              };
    
    NSString *jsString = [NSString stringWithFormat:@"changeNetwork(%@)",[dataDic mj_JSONString]];
    [self excuteRequestWithMethodName:@"changeNetwork"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        block(statusCode);
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

- (void)needPrivateKeyResponseWithMessage:(WKScriptMessage *)message andDic:(NSDictionary *)responseDic {
    WeakSelf(weakSelf);
    NSString *jsString = [NSString stringWithFormat:@"needPrivateKeyResponse('%@')",QSPrivateKey];
    [self excuteRequestWithMethodName:@"needPrivateKeyResponse"
                             jsString:jsString
                    completionHandler:^(NSInteger statusCode, NSDictionary *responseDic) {
                        if (statusCode == kResponseSuccessCode) {
                            //请求回调
                            for (NSString *key in weakSelf.methodAndCallbackDic.allKeys) {
                                if ([key isEqualToString:message.name]) {
                                    DataResponseBlock responseBlock = [weakSelf.methodAndCallbackDic objectForKey:key];
                                    responseBlock(kResponseSuccessCode,responseDic);
                                    break;
                                }
                            }
                        }
                    }];
}


@end
