//
//  QSAddAddressCell+QSAddAddressType.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddAddressCell+QSAddAddressType.h"

@implementation QSAddAddressCell (QSAddAddressType)

- (void)configureTypeButtonSubViewsWithItem:(QSAddAddressItem *)item {
    [self configureLeftSubViewsWithItem:item];
    
    [self.contentView addSubview:self.evtButton];
    CGFloat buttonY = item.cellHeight/2 - item.typeButtonSize.height/2;
    self.evtButton.frame = CGRectMake(item.typeButtonLeftMargin, buttonY, item.typeButtonSize.width, item.typeButtonSize.height);
    
    [self.contentView addSubview:self.ethButton];
    self.ethButton.frame = CGRectMake(self.evtButton.maxX + item.typeButtonSpace, self.evtButton.y, self.evtButton.width, self.evtButton.height);
    
    [self.contentView addSubview:self.eosButton];
    self.eosButton.frame = CGRectMake(self.ethButton.maxX + item.typeButtonSpace, self.evtButton.y, self.evtButton.width, self.evtButton.height);
}

@end
