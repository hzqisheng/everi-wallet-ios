//
//  QSCreateNFTAuthorizerCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateNFTAuthorizerCell.h"
#import "QSCreateNFTAuthorizerItem.h"

@interface QSCreateNFTAuthorizerCell ()

@property (nonatomic, strong) UILabel *authorizerLabel;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation QSCreateNFTAuthorizerCell

- (void)configureSubViews {
    [self.contentView addSubview:self.authorizerLabel];
    [self.contentView addSubview:self.deleteButton];
    
    [self.authorizerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.deleteButton.mas_left).offset(-kRealValue(10));
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.width.and.height.equalTo(@kRealValue(30));
    }];
}

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    
    if (![item isKindOfClass:[QSCreateNFTAuthorizerItem class]]) {
        return;
    }
    
    QSCreateNFTAuthorizerItem *authorizerItem = (QSCreateNFTAuthorizerItem *)self.item;
    
    self.authorizerLabel.text = authorizerItem.authorizer;
}

#pragma mark - ***************** Event Response
- (void)deleteButtonClicked {
    QSCreateNFTAuthorizerItem *authorizerItem = (QSCreateNFTAuthorizerItem *)self.item;

    if (authorizerItem.deleteAuthorizerClickedBlock) {
        authorizerItem.deleteAuthorizerClickedBlock(authorizerItem);
    }
}

#pragma mark - ***************** Setter Getter
- (UILabel *)authorizerLabel {
    if (!_authorizerLabel) {
        _authorizerLabel = [UILabel labelWithName:nil font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorBlack313745] textAlignment:NSTextAlignmentLeft];
        _authorizerLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _authorizerLabel;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_wodeyu_cancel"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
