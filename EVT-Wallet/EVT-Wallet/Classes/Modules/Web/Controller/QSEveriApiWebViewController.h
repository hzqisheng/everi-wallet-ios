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
#import "QSFT.h"
#import "QSNFT.h"
#import "QSTransferftModel.h"

NS_ASSUME_NONNULL_BEGIN

#define kResponseSuccessCode 1
#define kResponseFailCode    0

typedef void(^QSEveriApiWebViewPrivateKeyBlock)(NSInteger statusCode, NSDictionary *responseDic);

@protocol QSEveriApiProtocol <NSObject>

@optional

- (void)reloadWebView;

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
 * @brief privateToPublic
 * @param privateKey privateKey
 */
- (void)privateToPublicWithPrivateKey:(NSString *)privateKey
                  andCompeleteBlock:(void(^)(NSInteger statusCode, NSString *publicKey))block;

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

/**
 * @brief isValidAddress
 * @param address address
 */
- (void)isValidAddressWithAddress:(NSString *)address
                    andCompeleteBlock:(void(^)(NSInteger statusCode, NSString *isCorrect))block;


/**
 * @brief getEVT
 * @param publicKey publicKey
 */
- (void)getEVTFungiblesListWithPublicKey:(NSString *)publicKey
                    andCompeleteBlock:(void(^)(NSInteger statusCode, NSArray *ftList))block;

/**
 * @brief getEVTFungibleBalanceList
 * @param publicKey publicKey
 */
- (void)getEVTFungibleBalanceListWithPublicKey:(NSString *)publicKey
                       andCompeleteBlock:(void(^)(NSInteger statusCode, NSArray *ftList))block;

/**
 * @brief getNFT
 * @param publicKey publicKey
 */
- (void)getEVTDomainsListWithPublicKey:(NSString *)publicKey
                       andCompeleteBlock:(void(^)(NSInteger statusCode, NSArray *ftList))block;

/**
 * @brief pushTransaction
 * @param actionName actionName
 * @param ft ft
 * @param config config
 */
- (void)pushTransactionWithActionName:(NSString *)actionName 
                      andFt:(QSFT *)ft
                            andConfig:(NSString *)config
                       andCompeleteBlock:(void(^)(NSInteger statusCode, QSFT *ftmodel))block;

/**
 * @brief pushTransactionEveripay
 */
- (void)pushTransactionWithActionEveriLink:(NSString *)everiLink
                                andAsset:(NSString *)asset
                            andaddress:(NSString *)address
                    andCompeleteBlock:(void(^)(NSInteger statusCode))block;

/**
 * @brief issue
 * @param circulation circulation
 * @param address address
 * @param note note
 */
- (void)pushTransactionIssueWithCirculation:(NSString *)circulation
                                 andAddress:(NSString *)address
                                    andNote:(NSString *)note
                    andCompeleteBlock:(void(^)(NSInteger statusCode))block;

/**
 * @brief pushTransactionNFT
 * @param nft nft
 */
- (void)pushTransactionNFTWithNFT:(QSNFT *)nft
                    andCompeleteBlock:(void(^)(NSInteger statusCode, QSNFT *ftmodel))block;


/**
 * @brief getEvtLinkForPayeeCode
 */
- (void)getEvtLinkForPayeeCodeAndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *addressCodeString))block;

/**
 * @brief getUniqueLinkId
 */
- (void)getUniqueLinkIdAndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *linkId))block;

/**
 * @brief getEvtLinkForEveriPay
 */
- (void)getEvtLinkForEveriPayWithSym:(NSString *)sym
                        andMaxAmount:(NSString *)maxAmount
                           andLinkId:(NSString *)linkId
                   AndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *addressCodeString))block;

/**
 * @brief getStatusOfEvtLink
 */
- (void)getStatusOfEvtLinkWithLink:(NSString *)link
                   AndCompeleteBlock:(void(^)(NSInteger statusCode))block;

/**
 * @brief getEVTLinkQrImage
 */
- (void)getEVTLinkQrImageWithSym:(NSString *)sym
                        andMaxAmount:(NSString *)maxAmount
                           andLinkId:(NSString *)linkId
                   AndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *addressCodeString))block;
/**
 * @brief stopEVTLinkQrImageReload
 */
- (void)stopEVTLinkQrImageReload;

/**
 * @brief parseEvtLink
 */
- (void)parseEvtLinkWithAddress:(NSString *)address AndCompeleteBlock:(void(^)(NSInteger statusCode, NSArray *modelList, NSInteger flag))block;

/**
 * @brief getEstimatedChargeForTransaction
 */
- (void)getEstimatedChargeForTransactionWithAddress:(NSString *)address
                                     andBeneficiary:(NSString *)beneficiaryAddress
                                           andCount:(NSString *)count
                                            andMemo:(NSString *)memo
                                  AndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *address))block;

/**
 * @brief pushTransactionFukuan
 */
- (void)pushTransactionFukuanWithAddress:(NSString *)address
                                     andBeneficiary:(NSString *)beneficiaryAddress
                                           andCount:(NSString *)count
                                            andMemo:(NSString *)memo
                                  AndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *address))block;

/**
 * @brief pushTransactionNFT
 */
- (void)pushTransactionNFTWithDomain:(NSString *)domain
                          andNameArr:(NSArray *)nameArr
                                andOwner:(NSString *)owner
                       AndCompeleteBlock:(void(^)(NSInteger statusCode))block;

/**
 * @brief getActions
 */
- (void)getActionsWithFTModel:(QSFT *)FTModel AndCompeleteBlock:(void(^)(NSInteger statusCode , NSArray *transferList))block;

@end

@interface QSEveriApiWebViewController : QSWebViewViewController<QSEveriApiProtocol>

@property (nonatomic, copy) QSEveriApiWebViewPrivateKeyBlock everiApiWebViewPrivateKeyBlock;

+ (instancetype)sharedWebView;

@property (nonatomic, copy) void(^initSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END
