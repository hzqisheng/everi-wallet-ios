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

@property (nonatomic, strong) QSCreateEvt *currentEvt;

- (void)loginWithEvt:(QSCreateEvt *)evt;

+ (instancetype)sharedHelper;

@end

NS_ASSUME_NONNULL_END
