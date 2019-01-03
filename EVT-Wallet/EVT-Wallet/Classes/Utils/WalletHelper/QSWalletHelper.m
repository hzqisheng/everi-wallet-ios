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
#import "QSNavigationController.h"
#import "QSCreateEvt.h"

@interface QSWalletHelper ()

@property (nonatomic,strong) QSCreateEvt *currentEvt;

@end

static NSString * const kWalletKey = @"kWalletKey";
static NSString * const kCurrentWalletKey = @"kCurrentWalletKey";
static NSString * const kCurrentIndexPath = @"kCurrentIndexPath";
static NSString * const kAddressKey = @"kAddressKey";

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
        QSCreateEvt *wallet = [NSKeyedUnarchiver unarchiveObjectWithData:walletData];
        _currentEvt = wallet;
        DLog(@"_evt:%@",_currentEvt);
    }
    return self;
}

- (void)loginWithEvt:(QSCreateEvt *)evt {
    _currentEvt = evt;
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
    [UIApplication sharedApplication].keyWindow.rootViewController = [[QSNavigationController alloc] initWithRootViewController:[[QSCreateIdentityHomeViewController alloc] init]];
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

#pragma mark - **************** Setter Getter
- (BOOL)isLogin {
    return self.currentEvt != nil && self.currentEvt.password.length && self.currentEvt.privateKey.length && self.currentEvt.publicKey.length && self.currentEvt.type.length;
}



@end
