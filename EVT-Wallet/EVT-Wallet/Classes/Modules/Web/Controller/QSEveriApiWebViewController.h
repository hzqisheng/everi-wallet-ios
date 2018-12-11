//
//  QSEveriApiWebViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSWebViewViewController.h"
#import "QSCreateEvt.h"
#import "QSOwnedToken.h"
#import "QSFungibleSymbol.h"

NS_ASSUME_NONNULL_BEGIN

#define kResponseSuccessCode 1
#define kResponseFailCode    0

@protocol QSEveriApiProtocol <NSObject>

@optional

/**
 * @brief createEvtWallet
 * @param password password
 */
- (void)createEvtWalletWithPassword:(NSString *)password
                  andCompeleteBlock:(void(^)(NSInteger statusCode, QSCreateEvt *EvtModel))block;

/**
 * @brief importEVTWallet
 * @param mnemoinc mnemoinc
 * @param password password
 */
- (void)importEVTWalletWithMnemoinc:(NSString *)mnemoinc
                           password:(NSString *)password
                  andCompeleteBlock:(void(^)(NSInteger statusCode, QSCreateEvt *EvtModel))block;

/**
 * @brief getOwnedTokens
 * @param publicKeys selected wallet publicKeys
 */
- (void)getOwnedTokensWithPublicKeys:(NSString *)publicKeys
                   andCompeleteBlock:(void(^)(NSInteger statusCode, NSArray<QSOwnedToken *> * ownedTokens))block;

/**
 * @brief getFungibleBalance
 * @param address address
 */
- (void)getFungibleBalanceWithAddress:(NSString *)address
                   andCompeleteBlock:(void(^)(NSInteger statusCode, NSArray<NSString *> * fungibleBalances))block;


/**
 * @brief getCreatedFungibles
 * @param publicKeys selected wallet publicKeys
 */
- (void)getCreatedFungiblesWithPublicKeys:(NSString *)publicKeys
                        andCompeleteBlock:(void(^)(NSInteger statusCode, NSArray<NSString *> * fungibles))block;

/**
 * @brief getFungibleSymbolDetail
 * @param symId  symId
 */
- (void)getFungibleSymbolDetailWithSymId:(NSString *)symId
                       andCompeleteBlock:(void(^)(NSInteger statusCode, QSFungibleSymbol * fungibleSymbol))block;

/**
 * @brief pushTransaction
 */
- (void)pushTransactionAndCompeleteBlock:(void(^)(NSInteger statusCode, QSFungibleSymbol * fungibleSymbol))block;

@end

@interface QSEveriApiWebViewController : QSWebViewViewController<QSEveriApiProtocol>

+ (instancetype)sharedWebView;

@property (nonatomic, copy) void(^initSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END
