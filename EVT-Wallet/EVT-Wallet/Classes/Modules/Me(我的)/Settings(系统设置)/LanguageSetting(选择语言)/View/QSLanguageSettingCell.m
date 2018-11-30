//
//  QSLanguageSettingCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSLanguageSettingCell.h"
#import "QSSettingLanguageItem.h"

@interface QSLanguageSettingCell ()

@property (nonatomic, strong) UIImageView *checkImageView;

@end

@implementation QSLanguageSettingCell

- (void)configureCellWithItem:(QSSettingItem *)item {
    item.cellType = QSSettingItemTypeAccessnory;
    [super configureCellWithItem:item];
    //hide super arrow
    self.arrowImageView.hidden = YES;
    
    QSSettingLanguageItem *settingItem = (QSSettingLanguageItem *)item;
    //checkImageView
    [self.contentView addSubview:self.checkImageView];
    self.checkImageView.frame = CGRectMake(settingItem.cellWidth - settingItem.rightSubviewMargin - settingItem.rightCheckImageSize.width, settingItem.cellHeight/2 - settingItem.rightCheckImageSize.height/2, settingItem.rightCheckImageSize.width, settingItem.rightCheckImageSize.height);
    self.checkImageView.hidden = !settingItem.isChecked;
}

#pragma mark - **************** Setter Getter
- (UIImageView *)checkImageView {
    if (!_checkImageView) {
        _checkImageView = [[UIImageView alloc] init];
        _checkImageView.image = [UIImage imageNamed:@"icon_xuanzeyuyan_selected"];
    }
    return _checkImageView;
}

@end
