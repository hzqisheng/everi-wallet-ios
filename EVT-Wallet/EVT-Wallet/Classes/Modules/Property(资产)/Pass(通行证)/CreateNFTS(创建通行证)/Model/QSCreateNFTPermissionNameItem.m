//
//  QSCreateNFTPermissionNameItem.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTPermissionNameItem.h"
#import "QSCreateNFTPermissionNameCell.h"

@implementation QSCreateNFTPermissionNameItem

@synthesize cellIdentifier     = _cellIdentifier;
@synthesize cellTag            = _cellTag;
@synthesize cellHeight         = _cellHeight;
@synthesize cellWidth          = _cellWidth;
@synthesize cellSeapratorInset = _cellSeapratorInset;

- (instancetype)init {
    if (self = [super init]) {
        _cellIdentifier = NSStringFromClass([QSCreateNFTPermissionNameCell class]);
        _cellHeight = kRealValue(50);
        _cellWidth = kScreenWidth - kRealValue(30);
        _cellSeapratorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

@end
