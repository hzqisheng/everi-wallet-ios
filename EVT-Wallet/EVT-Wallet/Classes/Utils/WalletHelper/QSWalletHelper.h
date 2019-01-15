//
//  QSWalletHelper.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSCreateEvt.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSWalletHelper : NSObject

/** 当前身份下的钱包 */
@property (nonatomic, readonly, strong) QSCreateEvt *currentIdentityEvt;

/** 当前选中的钱包 */
@property (nonatomic, readonly, strong) QSCreateEvt *currentEvt;

/** 用户登录保存信息 */
- (void)loginWithEvt:(QSCreateEvt *)evt;

/** 是否登录 */
@property (nonatomic, readonly, assign) BOOL isLogin;

/** 退出登录 */
- (void)logout;

/** 导入钱包 */
- (void)addWallet:(QSCreateEvt *)evt;

/** 更新某一个钱包的开启指纹的数据 */
- (void)updateWalletOpenTouchID:(BOOL)isOpen
                   byPrivateKey:(NSString *)privateKey;

/** 获取某一个钱包 */
- (QSCreateEvt *)getWalletByPrivateKey:(NSString *)privateKey;

/** 获取钱包列表 */
- (NSMutableArray *)getWalletArray;

/** 切换钱包 */
- (void)switchWallet:(QSCreateEvt *)evt andIndexPath:(NSIndexPath *)indexPath;

/** 获取当前选择IndexPath */
- (NSIndexPath *)getCurrentIndexPath;

/** 修改钱包密码 */
- (void)changePassword:(NSString *)password;

/**
 * @brief返回首页操作
 */
- (void)turnToHomeViewController;

/**
 * @brief弹出登录页面操作
 */
- (void)turnToLoginViewController;

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
