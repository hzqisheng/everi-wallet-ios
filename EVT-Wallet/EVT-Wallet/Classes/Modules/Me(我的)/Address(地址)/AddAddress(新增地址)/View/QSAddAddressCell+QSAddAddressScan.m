//
//  QSAddAddressCell+QSAddAddressScan.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddAddressCell+QSAddAddressScan.h"

@implementation QSAddAddressCell (QSAddAddressScan)

- (void)configureScanSubViewsWithItem:(QSAddAddressItem *)item {
    // configure leftLabel
    [self configureLeftSubViewsWithItem:item];
    
    //textFiled
    [self.contentView addSubview:self.textField];
    self.textField.frame = CGRectMake(item.textFieldLeftMargin, 0, item.cellWidth - item.textFieldLeftMargin - item.textFieldRightMargin, item.cellHeight);
    self.textField.placeholder = item.placeholder;
    self.textField.text = item.textFieldText;
    
    //scanButton
    [self.contentView addSubview:self.scanButton];
    self.scanButton.frame = CGRectMake(item.cellWidth - item.scanButtonSize.width - item.rightSubviewMargin, item.cellHeight/2 - item.scanButtonSize.height/2, item.scanButtonSize.width, item.scanButtonSize.height);
    
    self.textField.width = self.scanButton.x - item.textFieldLeftMargin - 8;
}

@end
