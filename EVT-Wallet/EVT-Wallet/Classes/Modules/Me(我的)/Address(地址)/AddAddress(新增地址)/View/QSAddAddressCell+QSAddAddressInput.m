//
//  QSAddAddressCell+QSAddAddressInput.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddAddressCell+QSAddAddressInput.h"

@implementation QSAddAddressCell (QSAddAddressInput)

- (void)configureLeftTitleAndInputSubViewsWithItem:(QSAddAddressItem *)item {
    [self configureLeftSubViewsWithItem:item];
    
    //textFiled
    [self.contentView addSubview:self.textField];
    self.textField.frame = CGRectMake(item.textFieldLeftMargin, 0, item.cellWidth - item.textFieldLeftMargin - item.textFieldRightMargin, item.cellHeight);
    self.textField.placeholder = item.placeholder;
    self.textField.text = item.textFieldText;
}

@end
