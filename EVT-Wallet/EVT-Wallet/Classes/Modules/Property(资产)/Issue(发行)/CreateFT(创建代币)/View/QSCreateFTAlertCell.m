//
//  QSCreateFTAlertCell.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateFTAlertCell.h"
#import "QSCreateFTAlertItem.h"

@implementation QSCreateFTAlertCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self loadUI];
}

- (void)loadUI {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.top.equalTo(self.contentView).offset(kRealValue(14));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(16));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(9));
        make.right.equalTo(self.contentView).offset(-kRealValue(20));
        make.height.equalTo(@kRealValue(33));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSCreateFTAlertItem *FTItem = (QSCreateFTAlertItem *)item;
    self.titleLabel.text = FTItem.title;
    switch (FTItem.jurisdiction) {
        case 0:
        {
            self.contentLabel.text = [NSString stringWithFormat:@"  %@", QSLocalizedString(@"qs_select_ft_permissions_content0")];
        }
            break;
        case 1:
        {
            self.contentLabel.text = [NSString stringWithFormat:@"  %@", QSLocalizedString(@"qs_select_ft_permissions_content1")];
        }
            break;
        case 2:
        {
            self.contentLabel.text = [NSString stringWithFormat:@"  %@", QSLocalizedString(@"qs_select_ft_permissions_content2")];
        }
            break;
        default:
            break;
    }
}

#pragma mark - **************** Event Response
- (void)changeJurisdiction {
    [self alertWithArr:@[QSLocalizedString(@"qs_select_ft_permissions_content0"),QSLocalizedString(@"qs_select_ft_permissions_content1")]];
}

#pragma mark - **************** Private Methods
- (void)alertWithArr:(NSArray *)array {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < array.count; i++) {
        UIAlertAction *alert=[UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QSCreateFTAlertItem *FTItem = (QSCreateFTAlertItem *)self.item;
            switch (i) {
                case 0:
                {
                    self.contentLabel.text = [NSString stringWithFormat:@"  %@", QSLocalizedString(@"qs_select_ft_permissions_content0")];
                    if (FTItem.createFTAlertItemJurisdictionBlock) {
                        FTItem.createFTAlertItemJurisdictionBlock(i);
                    }
                }
                    break;
                case 1:
                {
                    self.contentLabel.text = [NSString stringWithFormat:@"  %@", QSLocalizedString(@"qs_select_ft_permissions_content1")];
                    if (FTItem.createFTAlertItemJurisdictionBlock) {
                        FTItem.createFTAlertItemJurisdictionBlock(i);
                    }
                }
                    break;
//                case 2:
//                {
//                    self.contentLabel.text = [NSString stringWithFormat:@"  %@", QSLocalizedString(@"qs_select_ft_permissions_content2")];
//                    
//                    
//                    
//                }
//                    break;
            }
        }];
        [ac addAction:alert];
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:QSLocalizedString(@"qs_cancel") style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:cancel];
    [self.viewController presentViewController:ac animated:YES completion:nil];
}

#pragma mark - **************** Setter Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont qs_fontOfSize16];
        _titleLabel.textColor = [UIColor qs_colorBlack333333];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.layer.borderWidth = BORDER_WIDTH_1PX;
        _contentLabel.layer.borderColor = [UIColor qs_colorGray686868].CGColor;
        _contentLabel.layer.cornerRadius = kRealValue(3);
        _contentLabel.textColor = [UIColor qs_colorGray686868];
        _contentLabel.font = [UIFont qs_fontOfSize14];
        _contentLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeJurisdiction)];
        [_contentLabel addGestureRecognizer:tap];
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end
