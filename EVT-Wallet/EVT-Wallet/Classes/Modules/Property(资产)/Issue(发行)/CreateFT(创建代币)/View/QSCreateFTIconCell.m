//
//  QSCreateFTIconCell.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/11.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateFTIconCell.h"
#import "QSCreateFTIconItem.h"

@implementation QSCreateFTIconCell

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
    
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kRealValue(20));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(11));
        make.size.mas_equalTo(CGSizeMake(kRealValue(40), kRealValue(40)));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSCreateFTIconItem *FTItem = (QSCreateFTIconItem *)item;
    self.titleLabel.text = FTItem.title;
}

#pragma mark - **************** Event Response
- (void)addIcon {
    [QSAppKeyWindow.rootViewController showPictureSelectActionSheetWithMaxPicCount:1 completeBlock:^(NSArray *selectImageArray, BOOL isCancel) {
        if (selectImageArray.count) {
            UIImage *seletedImage = selectImageArray[0];
            UIImage *pngIcon = nil;
            if (seletedImage) {
                NSData * data = UIImagePNGRepresentation(seletedImage);
                pngIcon = [UIImage imageWithData:data];
            }
            QSCreateFTIconItem *FTItem = (QSCreateFTIconItem *)self.item;
            if (FTItem.createFTIconItemSelectedImageBlock) {
                FTItem.createFTIconItemSelectedImageBlock(pngIcon);
            }
            [self.imageButton setImage:pngIcon forState:UIControlStateNormal];
        }
    }];
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

- (UIButton *)imageButton {
    if (!_imageButton) {
        _imageButton = [[UIButton alloc] init];
        [_imageButton setImage:[UIImage imageNamed:@"icon_chuagnjiandaibi_plus"] forState:UIControlStateNormal];
        [_imageButton addTarget:self action:@selector(addIcon) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_imageButton];
    }
    return _imageButton;
}

@end
