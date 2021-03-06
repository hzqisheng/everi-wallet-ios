//
//  QSWalletHelper.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSCreateEvt.h"
#import "QSNodeSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSWalletFTListModel : QSBaseModel
@end

@interface QSWalletHelper : NSObject

/** 当前选中的钱包 */
@property (nonatomic, readonly, strong) QSCreateEvt *currentEvt;

/** 用户登录保存信息 */
- (void)loginWithEvt:(QSCreateEvt *)evt;

/** 是否登录 */
@property (nonatomic, readonly, assign) BOOL isLogin;

/** 退出登录 */
- (void)logout;

#pragma mark - **************** 钱包相关
/** 导入钱包 */
- (void)addWallet:(QSCreateEvt *)evt;

/** 更新某一个钱包的开启指纹的数据 */
- (void)updateWalletOpenTouchID:(BOOL)isOpen
                   byPrivateKey:(NSString *)privateKey;

/** 获取当前身份下的钱包 */
- (QSCreateEvt * _Nullable)getCurrentIdentityWallet;

/** 获取某一个钱包 */
- (QSCreateEvt *)getWalletByPrivateKey:(NSString *)privateKey;

/** 更新某一个钱包的数据 */
- (void)updateWallet:(QSCreateEvt *)wallet;

/** 获取所有钱包列表 */
- (NSMutableArray *)getWalletArray;

/** 切换钱包 */
- (void)switchWallet:(QSCreateEvt *)evt andIndexPath:(NSIndexPath *)indexPath;

/** 获取当前选择IndexPath */
- (NSIndexPath *)getCurrentIndexPath;

/** 修改某一个钱包密码 */
- (BOOL)changePassword:(NSString *)password byPrivateKey:(NSString *)privateKey;

#pragma mark - **************** 首页钱包缓存
/** 保存一个钱包的代币列表 */
- (void)cacheHomeFTList:(NSArray *)ftList;

/** 获取缓存的首页代币列表 */
- (NSArray *)getHomeFTListByWallet;

#pragma mark - **************** 节点相关
/**
 * 添加自定义节点
 * nodeName节点名称：mainnet1.everitoken.io
 * nodeDetail ：节点描述
 * port ：443
 * protocol ：http
 */
- (void)cacheCustomNode:(NSString *)nodeName
             nodeDetail:(NSString *)nodeDetail
                   port:(NSString *)port
               protocol:(NSString *)protocol;

/** 当前选择的节点 */
@property (nonatomic, strong, readonly) QSNodeSettingItem *currentNode;

/** 修改选择的节点 */
- (void)changeCurrentNode:(QSNodeSettingItem *)nodeItem;

/** 获取所有节点 默认+手动添加的*/
- (NSArray<NSDictionary *> *)getAllNodes;

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
