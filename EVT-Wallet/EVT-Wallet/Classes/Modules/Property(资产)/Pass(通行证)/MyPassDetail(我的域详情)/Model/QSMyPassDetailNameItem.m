//
//  QSMyPassDetailNameItem.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyPassDetailNameItem.h"
#import "QSMyPassDetailNameCell.h"

@implementation QSMyPassDetailNameItem

@synthesize cellIdentifier     = _cellIdentifier;
@synthesize cellTag            = _cellTag;
@synthesize cellHeight         = _cellHeight;
@synthesize cellWidth          = _cellWidth;
@synthesize cellSeapratorInset = _cellSeapratorInset;

- (instancetype)init {
    if (self = [super init]) {
        _cellIdentifier = NSStringFromClass([QSMyPassDetailNameCell class]);
        _cellWidth = kScreenWidth - kRealValue(30);
        _cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}


@end
