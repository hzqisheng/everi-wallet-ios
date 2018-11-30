//
//  QSSettingCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/27.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSettingCell.h"

@implementation QSSettingCell

- (void)configureSubViews {
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

#pragma mark - **************** Setter Getter
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
    }
    return _leftTitleLabel;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] init];
    }
    return _rightTitleLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"icon_wode_enter"];
    }
    return _arrowImageView;
}

- (void)configureCellWithItem:(QSSettingItem *)item {
    _item = item;
    if (item.cellType == QSSettingItemTypeDefault) {
        //image
        [self.contentView addSubview:self.leftImageView];
        self.leftImageView.frame = CGRectMake(item.leftSubviewMargin, item.cellHeight/2 - item.leftImageSize.height/2, item.leftImageSize.width, item.leftImageSize.height);
        self.leftImageView.image = item.leftImage;
        //left text
        [self.contentView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = item.leftTitleFont;
        self.leftTitleLabel.textColor = item.leftTitleColor;
        self.leftTitleLabel.frame = CGRectMake(self.leftImageView.maxX + item.leftImageAndTitleSpace, item.cellHeight/2 - item.leftTitleLabelSize.height/2, item.leftTitleLabelSize.width, item.leftTitleLabelSize.height);
        self.leftTitleLabel.text = item.leftTitle;
        //arrow
        [self.contentView addSubview:self.arrowImageView];
        self.arrowImageView.frame = CGRectMake(item.cellWidth - item.rightSubviewMargin - item.arrowImageViewSize.width, item.cellHeight/2 - item.arrowImageViewSize.height/2, item.arrowImageViewSize.width, item.arrowImageViewSize.height);
    } else if (item.cellType == QSSettingItemTypeAccessnory) {
        //left text
        [self.contentView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = item.leftTitleFont;
        self.leftTitleLabel.textColor = item.leftTitleColor;
        self.leftTitleLabel.frame = CGRectMake(item.leftSubviewMargin, item.cellHeight/2 - item.leftTitleLabelSize.height/2, item.leftTitleLabelSize.width, item.leftTitleLabelSize.height);
        self.leftTitleLabel.text = item.leftTitle;
        //arrow
        [self.contentView addSubview:self.arrowImageView];
        self.arrowImageView.frame = CGRectMake(item.cellWidth - item.rightSubviewMargin - item.arrowImageViewSize.width, item.cellHeight/2 - item.arrowImageViewSize.height/2, item.arrowImageViewSize.width, item.arrowImageViewSize.height);
    } else if (item.cellType == QSSettingItemTypeLeftRightTitleAccessnory) {
        //left text
        [self.contentView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = item.leftTitleFont;
        self.leftTitleLabel.textColor = item.leftTitleColor;
        self.leftTitleLabel.frame = CGRectMake(item.leftSubviewMargin, item.cellHeight/2 - item.leftTitleLabelSize.height/2, item.leftTitleLabelSize.width, item.leftTitleLabelSize.height);
        self.leftTitleLabel.text = item.leftTitle;
        //arrow
        [self.contentView addSubview:self.arrowImageView];
        self.arrowImageView.frame = CGRectMake(item.cellWidth - item.rightSubviewMargin - item.arrowImageViewSize.width, item.cellHeight/2 - item.arrowImageViewSize.height/2, item.arrowImageViewSize.width, item.arrowImageViewSize.height);
        //right text
        [self.contentView addSubview:self.rightTitleLabel];
        self.rightTitleLabel.frame = CGRectMake(self.arrowImageView.x - item.rightArrowAndTitleSpace - item.rightTitleLabelSize.width, item.cellHeight/2 - item.rightTitleLabelSize.height/2, item.rightTitleLabelSize.width, item.rightTitleLabelSize.height);
        self.rightTitleLabel.textColor = item.rightTitleColor;
        self.rightTitleLabel.font = item.rightTitleFont;
        self.rightTitleLabel.text = item.rightTitle;
    } else if (item.cellType == QSSettingItemTypeImageAndLeftRightTitle) {
        //image
        [self.contentView addSubview:self.leftImageView];
        self.leftImageView.frame = CGRectMake(item.leftSubviewMargin, item.cellHeight/2 - item.leftImageSize.height/2, item.leftImageSize.width, item.leftImageSize.height);
        self.leftImageView.image = item.leftImage;
        //left text
        [self.contentView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = item.leftTitleFont;
        self.leftTitleLabel.textColor = item.leftTitleColor;
        self.leftTitleLabel.frame = CGRectMake(self.leftImageView.maxX + item.leftImageAndTitleSpace, item.cellHeight/2 - item.leftTitleLabelSize.height/2, item.leftTitleLabelSize.width, item.leftTitleLabelSize.height);
        self.leftTitleLabel.text = item.leftTitle;
        //arrow
        [self.contentView addSubview:self.arrowImageView];
        self.arrowImageView.frame = CGRectMake(item.cellWidth - item.rightSubviewMargin - item.arrowImageViewSize.width, item.cellHeight/2 - item.arrowImageViewSize.height/2, item.arrowImageViewSize.width, item.arrowImageViewSize.height);
        //right text
        [self.contentView addSubview:self.rightTitleLabel];
        self.rightTitleLabel.frame = CGRectMake(self.arrowImageView.x - item.rightArrowAndTitleSpace - item.rightTitleLabelSize.width, item.cellHeight/2 - item.rightTitleLabelSize.height/2, item.rightTitleLabelSize.width, item.rightTitleLabelSize.height);
        self.rightTitleLabel.textColor = item.rightTitleColor;
        self.rightTitleLabel.font = item.rightTitleFont;
        self.rightTitleLabel.text = item.rightTitle;
    } else if (item.cellType == QSSettingItemTypeLeftRightTitle) {
        //left text
        [self.contentView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = item.leftTitleFont;
        self.leftTitleLabel.textColor = item.leftTitleColor;
        self.leftTitleLabel.frame = CGRectMake(item.leftSubviewMargin, item.cellHeight/2 - item.leftTitleLabelSize.height/2, item.leftTitleLabelSize.width, item.leftTitleLabelSize.height);
        self.leftTitleLabel.text = item.leftTitle;
        
        //right text
        [self.contentView addSubview:self.rightTitleLabel];
        self.rightTitleLabel.frame = CGRectMake(item.cellWidth - item.rightSubviewMargin -item.rightTitleLabelSize.width, item.cellHeight/2 - item.rightTitleLabelSize.height/2, item.rightTitleLabelSize.width, item.rightTitleLabelSize.height);
        self.rightTitleLabel.textColor = item.rightTitleColor;
        self.rightTitleLabel.font = item.rightTitleFont;
        self.rightTitleLabel.text = item.rightTitle;
    }
}

@end
