//
//  QSHelpCenterFunctionOverviewCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSHelpCenterFunctionOverviewCell.h"
#import "QSHelpCenterOverViewItem.h"

@interface QSHelpCenterFunctionOverviewCell ()

@property (nonatomic, strong) UILabel *functionOverViewLabel;
@property (nonatomic, strong) UIView *functionOverViewLabelBackgroundView;

@end

@implementation QSHelpCenterFunctionOverviewCell

- (void)configureCellWithItem:(QSSettingItem *)item {
    item.cellType = QSSettingItemTypeAccessnory;
    //setup text and arrow
    [super configureCellWithItem:item];
    
    QSHelpCenterOverViewItem *overViewItem = (QSHelpCenterOverViewItem *)item;
    
    //change leftLabel arrow Y
    self.leftTitleLabel.y = overViewItem.leftTitleTopMargin;
    self.leftTitleLabel.width = kRealValue(285);
    self.arrowImageView.centerY = self.leftTitleLabel.centerY;
    
    //functionOverViewLabelBackgroundView
    [self.contentView addSubview:self.functionOverViewLabelBackgroundView];
    self.functionOverViewLabelBackgroundView.frame = CGRectMake(0, self.leftTitleLabel.maxY, item.cellWidth, item.cellHeight - self.leftTitleLabel.maxY);
    self.functionOverViewLabelBackgroundView.hidden = !overViewItem.isExpand;
    
    //functionOverViewLabel
    [self.contentView addSubview:self.functionOverViewLabel];
    self.functionOverViewLabel.frame = CGRectMake(self.leftTitleLabel.left, self.leftTitleLabel.maxY + overViewItem.functionOverViewTopMargin, overViewItem.functionOverViewSize.width, overViewItem.functionOverViewSize.height);
    self.functionOverViewLabel.text = overViewItem.functionOverView;
    self.functionOverViewLabel.textColor = overViewItem.functionOverViewTextColor;
    self.functionOverViewLabel.font = overViewItem.functionOverViewFont;
    self.functionOverViewLabel.hidden = !overViewItem.isExpand;
}

#pragma mark - **************** Setter Getter
- (UILabel *)functionOverViewLabel {
    if (!_functionOverViewLabel) {
        _functionOverViewLabel = [[UILabel alloc] init];
        _functionOverViewLabel.numberOfLines = 0;
    }
    return _functionOverViewLabel;
}

- (UIView *)functionOverViewLabelBackgroundView {
    if (!_functionOverViewLabelBackgroundView) {
        _functionOverViewLabelBackgroundView = [[UIView alloc] init];
        _functionOverViewLabelBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _functionOverViewLabelBackgroundView;
}

@end
