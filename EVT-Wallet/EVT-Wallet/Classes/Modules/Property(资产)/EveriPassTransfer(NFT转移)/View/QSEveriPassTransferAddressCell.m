//
//  QSEveriPassTransferAddressCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassTransferAddressCell.h"
#import "QSEveriPassTransferAddressItem.h"

@interface QSEveriPassTransferAddressCell ()

@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation QSEveriPassTransferAddressCell

- (void)configureSubViews {
    UILabel *addressLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    _addressLabel = addressLabel;
    [self.contentView addSubview:addressLabel];
    
    UIButton *deleteButton = [UIButton buttonWithImage:@"icon_wodeyu_cancel" taget:self action:@selector(deleteButtonClicked)];
    [self.contentView addSubview:deleteButton];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(deleteButton.mas_left).offset(-kRealValue(15));
    }];
    
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.width.and.height.equalTo(@kRealValue(30));
    }];
}

- (void)deleteButtonClicked {
    QSEveriPassTransferAddressItem *addressItem = (QSEveriPassTransferAddressItem *)self.item;
    
    if (addressItem.everiPassTransferAddressDeleteBlock) {
        addressItem.everiPassTransferAddressDeleteBlock(addressItem);
    }
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    QSEveriPassTransferAddressItem *addressItem = (QSEveriPassTransferAddressItem *)item;
    
    self.addressLabel.text = addressItem.address;
}

@end
