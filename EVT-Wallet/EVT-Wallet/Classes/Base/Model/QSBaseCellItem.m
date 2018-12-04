//
//  QSBaseCellItem.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

@implementation QSBaseCellItem

- (instancetype)init {
    if (self = [super init]) {
        _cellIdentifier = @"QSBaseTableViewCell";
        _cellHeight = kRealValue(52);
        _cellWidth = kScreenWidth - kRealValue(30);
        _cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

@end
