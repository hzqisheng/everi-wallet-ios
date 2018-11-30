//
//  QSAboutusIconCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAboutusIconCell.h"

@interface QSAboutusIconCell ()

@property (nonatomic, strong) UIImageView *appIconImageView;

@end

@implementation QSAboutusIconCell

- (void)configureCellWithItem:(QSSettingItem *)item {
    self.item = item;
    [self.contentView addSubview:self.appIconImageView];
    CGFloat appIconWH = kRealValue(90);
    self.appIconImageView.frame = CGRectMake(item.cellWidth/2 - appIconWH/2, item.cellHeight/2 - appIconWH/2, appIconWH, appIconWH);
}

- (UIImageView *)appIconImageView {
    if (!_appIconImageView) {
        _appIconImageView = [[UIImageView alloc] init];
        _appIconImageView.image = [UIImage imageNamed:@"icon_guanyuwomen_logo"];
    }
    return _appIconImageView;
}

@end
