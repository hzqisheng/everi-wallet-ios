//
//  QSAddressHelper.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/15.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSAddress.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSAddressHelper : NSObject

/** 增加地址 */
- (void)addAddress:(QSAddress *)address;

/** 增加地址 */
- (void)deleteAddress:(NSString *)publicKey;

/** 获取地址 */
- (NSMutableArray *)getAddress;

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
