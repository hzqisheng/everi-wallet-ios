//
//  QSCreateNFTPermissionNameCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTPermissionNameCell.h"
#import "QSCreateNFTPermissionNameItem.h"

@interface QSCreateNFTPermissionNameCell ()

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation QSCreateNFTPermissionNameCell

- (void)configureSubViews {
    [self.contentView addSubview:self.blueView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addButton];

    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kRealValue(2), kRealValue(14)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blueView.mas_right).offset(kRealValue(9));
        make.centerY.equalTo(self.blueView);
        make.width.lessThanOrEqualTo(@kRealValue(100));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(10));
        make.width.equalTo(@kRealValue(80));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    if (![item isKindOfClass:[QSCreateNFTPermissionNameItem class]]) {
        return;
    }
    
    QSCreateNFTPermissionNameItem *nameItem = (QSCreateNFTPermissionNameItem *)self.item;
    
    self.titleLabel.text = nameItem.permissionName;
}

#pragma mark - ***************** Event Response
- (void)addButtonClicked {
    QSCreateNFTPermissionNameItem *nameItem = (QSCreateNFTPermissionNameItem *)self.item;
    if (nameItem.addPermissionClickedBlock) {
        nameItem.addPermissionClickedBlock(nameItem);
    }
}

#pragma mark - ***************** Setter Getter
- (UIView *)blueView {
    if (!_blueView) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor qs_colorBlue4D7BF3];
        [self addSubview:_blueView];
    }
    return _blueView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        _titleLabel.font = [UIFont qs_boldFontOfSize16];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithImage:@"icon_wodeyu_plus1" taget:self action:@selector(addButtonClicked)];
        [_addButton setTitle:QSLocalizedString(@"qs_pass_createNFTS_add_permission_title") forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor qs_colorGray686868] forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont qs_fontOfSize15];
        _addButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _addButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    }
    return _addButton;
}

@end
