//
//  QSWalletHelper.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSWalletHelper.h"
#import "QSMainViewController.h"
#import "QSCreateIdentityHomeViewController.h"
#import "QSCreateEvt.h"
#import "QSNodeSettingDetailViewController.h"

static NSString * const kSelectedNodeKey = @"kSelectedNodeItemKey";
static NSString * const kWalletKey = @"kWalletKey";
static NSString * const kCurrentWalletKey = @"kCurrentWalletKey";
static NSString * const kCurrentIndexPath = @"kCurrentIndexPath";
static NSString * const kAddressKey = @"kAddressKey";
static NSString * const kHomeFTListKey = @"kHomeFTListKey";
static NSString * const kCustemNodeKey = @"kCustemNodeKey";

@interface QSWalletFTListModel ()

@property (nonatomic, copy) NSString *privateKey;
@property (nonatomic, strong) NSArray *ftList;

@end

@implementation QSWalletFTListModel
@end

@interface QSWalletHelper ()

@property (nonatomic,strong) QSCreateEvt *currentEvt;
@property (nonatomic, strong) QSNodeSettingItem *currentNode;

@end

@implementation QSWalletHelper 

+ (instancetype)sharedHelper {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSData *walletData = [QSUserDefaults objectForKey:kCurrentWalletKey];
        if (walletData) {
            QSCreateEvt *wallet = [NSKeyedUnarchiver unarchiveObjectWithData:walletData];
            _currentEvt = wallet;
            DLog(@"_evt:%@",_currentEvt);
        }
        
        NSData *walletListData = [QSUserDefaults objectForKey:kWalletKey];
        if (walletListData) {
            NSMutableArray *walletArray = [NSKeyedUnarchiver unarchiveObjectWithData:walletListData];
            _currentIdentityEvt = walletArray.firstObject;
            DLog(@"_idevt:%@",_currentIdentityEvt);
        }
        
        _currentNode = [self getCurrentNode];
        if (!_currentNode) {
            //默认上海
            /*
             @"title"   : @"mainnet14.everitoken.io",
             @"detail"  : @"MainNet(SHANGHAI)(with history plugin)",
             @"port"    : @"443",
             @"protocol": @"https"
             */
            _currentNode = [[QSNodeSettingItem alloc] init];
            _currentNode.title = @"mainnet14.everitoken.io";
            _currentNode.protocol = @"https";
            _currentNode.port = @"443";
            _currentNode.detail = @"MainNet(SHANGHAI)(with history plugin)";
        }
        DLog(@"_currentNode:%@",_currentNode);
    }
    return self;
}

- (void)loginWithEvt:(QSCreateEvt *)evt {
    _currentEvt = evt;
    _currentIdentityEvt = evt;
    
    NSData *currentData = [NSKeyedArchiver archivedDataWithRootObject:evt];
    [QSUserDefaults setObject:currentData forKey:kCurrentWalletKey];
    
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSData *indexPathData = [NSKeyedArchiver archivedDataWithRootObject:currentIndexPath];
    [QSUserDefaults setObject:indexPathData forKey:kCurrentIndexPath];
    
    NSMutableArray *walletArray = [NSMutableArray array];
    [walletArray addObject:evt];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:walletArray];
    [QSUserDefaults setObject:data forKey:kWalletKey];
    [QSUserDefaults synchronize];
}

- (void)turnToHomeViewController {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[QSMainViewController alloc] init];
    [QSAppWindow insertSubview:[QSEveriApiWebViewController sharedWebView].view atIndex:0];
}

- (void)turnToLoginViewController {
    if ([[UIViewController currentViewController] isKindOfClass:NSClassFromString(@"QSLoginViewController")]) {
        return;
    }
    [UIApplication sharedApplication].keyWindow.rootViewController = [[RTRootNavigationController alloc] initWithRootViewController:[[QSCreateIdentityHomeViewController alloc] init]];
    [QSAppWindow insertSubview:[QSEveriApiWebViewController sharedWebView].view atIndex:0];
    CATransition * transition = [[CATransition alloc] init];
    transition.type = @"fade";
    transition.duration = 0.2;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:nil];
    
}

- (void)logout {
    _currentEvt = nil;
    [QSUserDefaults removeObjectForKey:kWalletKey];
    [QSUserDefaults removeObjectForKey:kCurrentIndexPath];
    [QSUserDefaults removeObjectForKey:kCurrentWalletKey];
    [QSUserDefaults removeObjectForKey:kAddressKey];
    [QSUserDefaults removeObjectForKey:kHomeFTListKey];
    [QSUserDefaults removeObjectForKey:kCustemNodeKey];
    [QSUserDefaults synchronize];
}

- (void)addWallet:(QSCreateEvt *)evt {
    NSData *walletData = [QSUserDefaults objectForKey:kWalletKey];
    NSMutableArray *walletArray = [NSKeyedUnarchiver unarchiveObjectWithData:walletData];
    for (QSCreateEvt *newEVT in walletArray) {
        if ([newEVT.privateKey isEqualToString:evt.privateKey]) {
            [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_wallet_imported_already")];
            return;
        }
    }
    [walletArray addObject:evt];
    walletData = [NSKeyedArchiver archivedDataWithRootObject:walletArray];
    [QSUserDefaults setObject:walletData forKey:kWalletKey];
    [QSUserDefaults synchronize];
    [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_content_isRecover_success")];
}

- (void)switchWallet:(QSCreateEvt *)evt andIndexPath:(NSIndexPath *)indexPath {
    _currentEvt = evt;
    NSData *currentEvtData = [NSKeyedArchiver archivedDataWithRootObject:evt];
    [QSUserDefaults setObject:currentEvtData forKey:kCurrentWalletKey];
    NSData *indexPathData = [NSKeyedArchiver archivedDataWithRootObject:indexPath];
    [QSUserDefaults setObject:indexPathData forKey:kCurrentIndexPath];
    [QSUserDefaults synchronize];
}

- (NSIndexPath *)getCurrentIndexPath {
    NSData *currentIndexData = [QSUserDefaults objectForKey:kCurrentIndexPath];
    NSIndexPath *currentIndexPath = [NSKeyedUnarchiver unarchiveObjectWithData:currentIndexData];
    return currentIndexPath;
}

- (NSMutableArray *)getWalletArray {
    NSData *walletData = [QSUserDefaults objectForKey:kWalletKey];
    NSMutableArray *walletArray = [NSKeyedUnarchiver unarchiveObjectWithData:walletData];
    return walletArray;
}

- (void)changePassword:(NSString *)password {
    NSData *currentData = [QSUserDefaults objectForKey:kCurrentWalletKey];
    QSCreateEvt *currentWallet = [NSKeyedUnarchiver unarchiveObjectWithData:currentData];
    currentWallet.password = password;
    NSData *arrayData = [QSUserDefaults objectForKey:kWalletKey];
    NSMutableArray *walletArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:walletArray];
    for (QSCreateEvt *newWallet in walletArray) {
        if ([newWallet.privateKey isEqualToString:currentWallet.privateKey]) {
            [newArray removeObject:newWallet];
            [newArray addObject:currentWallet];
        }
    }
    currentData = [NSKeyedArchiver archivedDataWithRootObject:currentWallet];
    arrayData = [NSKeyedArchiver archivedDataWithRootObject:newArray];
    [QSUserDefaults setObject:currentData forKey:kCurrentWalletKey];
    [QSUserDefaults setObject:arrayData forKey:kWalletKey];
    [QSUserDefaults synchronize];
}

- (void)updateWalletOpenTouchID:(BOOL)isOpen
                   byPrivateKey:(NSString *)privateKey {
    NSData *currentData = [QSUserDefaults objectForKey:kCurrentWalletKey];
    QSCreateEvt *currentWallet = [NSKeyedUnarchiver unarchiveObjectWithData:currentData];
    if ([currentWallet.privateKey isEqualToString:privateKey]) {
        currentWallet.isOpenFingerprint = isOpen;
    }
    
    NSData *arrayData = [QSUserDefaults objectForKey:kWalletKey];
    NSMutableArray *walletArray = [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
    for (QSCreateEvt *newWallet in walletArray) {
        if ([newWallet.privateKey isEqualToString:currentWallet.privateKey]) {
            newWallet.isOpenFingerprint = isOpen;
        }
    }

    currentData = [NSKeyedArchiver archivedDataWithRootObject:currentWallet];
    arrayData = [NSKeyedArchiver archivedDataWithRootObject:walletArray];
    [QSUserDefaults setObject:currentData forKey:kCurrentWalletKey];
    [QSUserDefaults setObject:arrayData forKey:kWalletKey];
    [QSUserDefaults synchronize];
}

- (QSCreateEvt *)getWalletByPrivateKey:(NSString *)privateKey {
    NSMutableArray *walletArray = [self getWalletArray];
    for (QSCreateEvt *evt in walletArray) {
        if ([evt.privateKey isEqualToString:privateKey]) {
            return evt;
        }
    }
    return nil;
}

- (void)cacheHomeFTList:(NSArray *)ftList {
    [self cacheHomeFTList:ftList
       byWalletPrivateKey:self.currentEvt.privateKey];
}

- (NSArray *)getHomeFTListByWallet {
    return [self getHomeFTListByWalletPrivateKey:self.currentEvt.privateKey];
}

- (void)cacheHomeFTList:(NSArray<QSFT *> *)ftList
     byWalletPrivateKey:(NSString *)privateKey {
    if (!ftList.count
        || !privateKey.length) {
        return;
    }
    
    NSMutableArray *allWalletFtList = [[self getAllFTList] mutableCopy];
    BOOL isAddBefore = NO;
    for (QSWalletFTListModel *walletFt in allWalletFtList) {
        if ([walletFt.privateKey isEqualToString:privateKey]) {
            walletFt.ftList = ftList;
            isAddBefore = YES;
            break;
        }
    }
    
    if (!isAddBefore) {
        QSWalletFTListModel *walletFtListModel = [[QSWalletFTListModel alloc] init];
        walletFtListModel.privateKey = privateKey;
        walletFtListModel.ftList = ftList;
        [allWalletFtList addObject:walletFtListModel];
    }
    
    NSData *allWalletFtListData = [NSKeyedArchiver archivedDataWithRootObject:allWalletFtList];
    [QSUserDefaults setObject:allWalletFtListData forKey:kHomeFTListKey];
}

- (NSArray *)getHomeFTListByWalletPrivateKey:(NSString *)privateKey {
    NSMutableArray *allWalletFtList = [[self getAllFTList] mutableCopy];
    
    for (QSWalletFTListModel *walletFt in allWalletFtList) {
        if ([walletFt.privateKey isEqualToString:privateKey]) {
            return walletFt.ftList;
        }
    }
    return nil;
}

- (NSArray *)getAllFTList {
    NSData *ftListData = [QSUserDefaults objectForKey:kHomeFTListKey];
    if (ftListData) {
        NSArray *ftList = [NSKeyedUnarchiver unarchiveObjectWithData:ftListData];
        return ftList;
    }
    return [NSArray array];
}

#pragma mark - **************** 节点相关
- (void)cacheCustomNode:(NSString *)nodeName
             nodeDetail:(NSString *)nodeDetail
                   port:(NSString *)port
               protocol:(NSString *)protocol {
    if (nodeName.length
        && nodeDetail.length) {
        NSDictionary *newNodeDic = @{
                                     @"title"   : nodeName,
                                     @"detail"  : nodeDetail,
                                     @"port"    : port,
                                     @"protocol": protocol
                                     };
        
        NSArray *nodeList = [QSUserDefaults objectForKey:kCustemNodeKey];
        NSMutableArray *newNodeList = [NSMutableArray array];
        if (nodeList) {
            [newNodeList addObjectsFromArray:nodeList];
        }
        [newNodeList addObject:newNodeDic];
        
        [QSUserDefaults setObject:[newNodeList copy] forKey:kCustemNodeKey];
        [QSUserDefaults synchronize];
    }
}

- (NSMutableArray *)getCustomNodes {
    return [QSUserDefaults objectForKey:kCustemNodeKey];
}

- (QSNodeSettingItem *)getCurrentNode {
    NSData *currentNodeData = [QSUserDefaults objectForKey:kSelectedNodeKey];
    if (currentNodeData) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:currentNodeData];
    }
    return nil;
}

- (void)cacheCurrentNode:(QSNodeSettingItem *)nodeItem {
    self.currentNode = nodeItem;
    if (nodeItem.title.length
        &&nodeItem.protocol.length
        &&nodeItem.port.length) {
        NSData *nodeItemData = [NSKeyedArchiver archivedDataWithRootObject:nodeItem];
        [[NSUserDefaults standardUserDefaults] setObject:nodeItemData forKey:kSelectedNodeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)changeCurrentNode:(QSNodeSettingItem *)nodeItem {
    if (!nodeItem.title.length
        || !nodeItem.port.length
        || !nodeItem.protocol.length) {
        return;
    }
    
    [[QSEveriApiWebViewController sharedWebView] changeNetworkByHost:nodeItem.title port:nodeItem.port protocol:nodeItem.protocol andCompeleteBlock:^(NSInteger statusCode) {}];
    [self cacheCurrentNode:nodeItem];
    [[QSEveriApiWebViewController sharedWebView] evtInitAndCompeleteyBlock:^{
        [self turnToHomeViewController];
    }];
}

- (NSArray<NSDictionary *> *)getAllNodes {
    NSMutableArray *defaultNodes = [@[
                                     @{
                                         @"title"   : @"mainnet1.everitoken.io",
                                         @"detail"  : @"MainNet(HONG KONG)(with history plugin)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet2.everitoken.io",
                                         @"detail"  : @"MainNet(CALIFORNIA)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet3.everitoken.io",
                                         @"detail"  : @"MainNet(TOKYO)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet4.everitoken.io",
                                         @"detail"  : @"MainNet(FRANKFURT)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet5.everitoken.io",
                                         @"detail"  : @"MainNet(SEOUL)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet6.everitoken.io",
                                         @"detail"  : @"MainNet(BRAZIL)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet7.everitoken.io",
                                         @"detail"  : @"MainNet(SINGAPORE)(with history plugin)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet8.everitoken.io",
                                         @"detail"  : @"MainNet(FRANKFURT)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet9.everitoken.io",
                                         @"detail"  : @"MainNet(KUALA LUMPUR)(with history plugin)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet10.everitoken.io",
                                         @"detail"  : @"MainNet(TOKYO)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet11.everitoken.io",
                                         @"detail"  : @"MainNet(CALIFORNIA)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet12.everitoken.io",
                                         @"detail"  : @"MainNet(HONG KONG)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet13.everitoken.io",
                                         @"detail"  : @"MainNet(VIRGINIA)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet14.everitoken.io",
                                         @"detail"  : @"MainNet(SHANGHAI)(with history plugin)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"mainnet15.everitoken.io",
                                         @"detail"  : @"MainNet(SINGAPORE)(with history plugin)",
                                         @"port"    : @"443",
                                         @"protocol": @"https"
                                         },
                                     @{
                                         @"title"   : @"testnet1.everitoken.io",
                                         @"detail"  : @"TestNet",
                                         @"port"    : @"8888",
                                         @"protocol": @"http"
                                         }] mutableCopy];
    
    NSArray *addNodeList = [QSUserDefaults objectForKey:kCustemNodeKey];
    if (addNodeList.count) {
        [defaultNodes addObjectsFromArray:addNodeList];
    }
    return defaultNodes;
}

#pragma mark - **************** Setter Getter
- (BOOL)isLogin {
    return self.currentEvt != nil && self.currentEvt.password.length && self.currentEvt.privateKey.length && self.currentEvt.publicKey.length && self.currentEvt.type.length;
}

@end
