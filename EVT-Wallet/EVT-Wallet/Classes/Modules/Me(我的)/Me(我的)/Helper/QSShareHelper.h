//
//  QSShareHelper.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSShareHelper : NSObject

+ (instancetype)sharedHelper;

- (void)shareURL:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
