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
#import "QSEvtLinkStatus.h"
#import "QSCollectImageModel.h"
#import "QSAppVersion.h"
#import "QSNFTTransferLog.h"

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
 * @brief validateMnemonic
 */
- (void)checkValidateMnemonic:(NSString *)mnemonic
            andCompeleteBlock:(void(^)(NSInteger statusCode, BOOL isValidate))block;

/**
 * @brief isValidPrivateKey
 */
- (void)checkValidPrivateKey:(NSString *)privateKey
            andCompeleteBlock:(void(^)(NSInteger statusCode, BOOL isValid))block;

/**
 * @brief checkValidPublicKey
 */
- (void)checkValidPublicKey:(NSString *)privateKey
          andCompeleteBlock:(void(^)(NSInteger statusCode, BOOL isValid))block;

/**
 * @brief privateToPublic
 * @param privateKey privateKey
 */
- (void)privateToPublicWithPrivateKey:(NSString *)privateKey
                  andCompeleteBlock:(void(^)(NSInteger statusCode, NSString *publicKey))block;

/**
 evt init
 */
- (void)evtInitAndCompeleteyBlock:(void (^)(void))block;

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
 * @brief getDomain Detail
 * @param name      name
 */
- (void)getDomainDetailByName:(NSString *)name andCompeleteBlock:(void (^)(NSInteger statusCode, QSNFT * _Nullable domainDetail))block;

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
                   AndCompeleteBlock:(void(^)(NSInteger statusCode, QSEvtLinkStatus *status))block;

/**
 * @brief getEVTLinkQrImage everiPay
 */
- (void)getEVTLinkQrImageWithSym:(NSString *)sym
                        andMaxAmount:(NSString *)maxAmount
                           andLinkId:(NSString *)linkId
                   AndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *addressCodeString))block;

/**
 * @brief getEVTLinkQrImage everiPass
 */
- (void)getEveriPassQrImageWithDomain:(NSString *)domain
                                 name:(NSString *)name
               andCompeleteBlock:(void(^)(NSInteger statusCode, NSString *addressCodeString))block;

/**
 * @brief stopEVTLinkQrImageReload
 */
- (void)stopEVTLinkQrImageReload;

/**
 * @brief parseEvtLink
 */
- (void)parseEvtLinkWithAddress:(NSString *)address AndCompeleteBlock:(void(^)(NSInteger statusCode, NSArray *modelList, NSInteger flag, NSArray *publicKeys))block;

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

/**
 * @brief changeNetwork
 */
- (void)changeNetworkByHost:(NSString *)host
                       port:(NSString *)port
                   protocol:(NSString *)protocol
          andCompeleteBlock:(void(^)(NSInteger statusCode))block;

/**
 * @brief getTransactionDetail
 */
- (void)getTransactionDetailById:(NSString *)transactionId
               andCompeleteBlock:(void(^)(NSInteger statusCode, NSString *transactionNumber))block;

/**
 * @brief getAPPVersion
 */
- (void)getAPPVersionAndCompeleteBlock:(void(^)(NSInteger statusCode, QSAppVersion *appVersion))block;

/**
 * @brief randomValidSymbolId
 */
- (void)getRandomValidSymbolIdAndCompeleteBlock:(void(^)(NSInteger statusCode, NSString *symbolID))block;

/**
 *checkNetwork
 */
- (void)checkNetworkByProtocol:(NSString *)protocol
                          port:(NSString *)port
                          host:(NSString *)host
             andCompeleteBlock:(void(^)(NSInteger statusCode))block;

/**
 * getEVTLinkQrImage
 */
- (void)getEVTLinkQrImageByFungibleId:(NSInteger)fungibleId
                               amount:(NSString * _Nullable)amount
                    andCompeleteBlock:(void(^)(NSInteger statusCode, QSCollectImageModel *collectImage))block;

/**
 * Create Group
 * @param actionName newgroup/updategroup
 */
- (void)pushGroupByActionName:(NSString *)actionName
                groupsStructure:(NSDictionary *)groups
             andCompeleteBlock:(void(^)(NSInteger statusCode))block;

/**
 * getManagedGroups
 */
- (void)getManagedGroupsAndCompeleteBlock:(void(^)(NSInteger statusCode, NSArray * _Nullable data))block;

/**
 * getGroupDetail
 */
- (void)getGroupDetailByGroupName:(NSString *)groupName
                andCompeleteBlock:(void(^)(NSInteger statusCode, NSDictionary * _Nullable data))block;

/**
 * pushTransaction 通用方法
 */
- (void)pushTransactionByActionName:(NSString *)actionName
                            actions:(NSDictionary *)actions
                             config:(NSDictionary * _Nullable)config
                             domain:(NSString * _Nullable)domain
                                key:(NSString * _Nullable)key
                  completionHandler:(void (^)(NSInteger statusCode, NSDictionary *responseDic))completionHandler;

/**
 * @brief addMeta 通用方法
 *
 * @param actionKey     actionKey
 * @param actionValue   actionValue
 * @param actionCreator actionCreator
 * @param domain        域，如:.group
 * @param key           domain对应的值
 @
 */

- (void)addMetaByActionKey:(NSString *)actionKey
               actionValue:(NSString *)actionValue
             actionCreator:(NSString *)actionCreator
                    domain:(NSString *)domain
                       key:(NSString *)key
         andCompeleteBlock:(void(^)(NSInteger statusCode))block;


/**
 * 获取NFT转移记录
 */
- (void)getNFTTrasferLogsByDomain:(NSString *)domain
                             name:(NSString *)name
                andCompeleteBlock:(void(^)(NSInteger statusCode, NSArray<QSNFTTransferLog *> *transferLogList))block;

/**
 * 获取NFT转移手续费
 */
- (void)getEstimatedChargeForTransaction:(NSDictionary *)actions
                       andCompeleteBlock:(void(^)(NSInteger statusCode, NSString *chargeString))block;


@end

@interface QSEveriApiWebViewController : QSWebViewViewController<QSEveriApiProtocol>

@property (nonatomic, copy) QSEveriApiWebViewPrivateKeyBlock everiApiWebViewPrivateKeyBlock;

+ (instancetype)sharedWebView;

/** web加载 sdk初始成功的回调 */
@property (nonatomic, copy) void(^webAndEvtInitSuccessBlock)(void);

@end

NS_ASSUME_NONNULL_END
