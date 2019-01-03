//
//  QSManageSelectAddressItem.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSManageSelectAddressItem.h"

@implementation QSManageSelectAddressItem

- (instancetype)init {
    if (self = [super init]) {
        self.cellIdentifier = @"QSManageSelectAddressCell";
        self.cellHeight = kRealValue(64);
    }
    return self;
}

@end
