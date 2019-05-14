//
//  QSNFT.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSNFT.h"

@implementation QSNFT

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"metas":@"QSMetas"
             };
}

- (instancetype)init {
    if (self = [super init]) {
        _issue = [[QSNFTTransfer alloc] init];
        _manage = [[QSNFTTransfer alloc] init];
        _transfer = [[QSNFTTransfer alloc] init];
    }
    return self;
}

@end
