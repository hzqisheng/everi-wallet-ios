//
//  QSMyPassDetailPermissionCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMyPassDetailPermissionCell.h"
#import "QSMyPassDetailPermissionItem.h"
#import "QSAuthorizers.h"

@interface QSMyPassDetailPermissionCell ()

@end

@implementation QSMyPassDetailPermissionCell

- (void)configureCellWithItem:(id<QSBaseCellItemDataProtocol>)item {
    self.item = item;
    QSMyPassDetailPermissionItem *permissionItem = (QSMyPassDetailPermissionItem *)item;
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //名称
    UILabel *nameLabel = [UILabel labelWithName:permissionItem.name font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRealValue(15));
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
    }];
    
    //threshold
    UILabel *threshold = [UILabel labelWithName:[NSString stringWithFormat:@"%@：%ld",QSLocalizedString(@"qs_pass_mypass_detail_threshold_title"),permissionItem.threshold] font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:threshold];
    [threshold mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(kRealValue(10));
        make.left.and.right.equalTo(nameLabel);
    }];
    
    //authorizers
    UIView *lastView = threshold;
    for (QSAuthorizers *authorizers in permissionItem.authorizers) {
        NSString *authorizersTitle = [NSString stringWithFormat:@"%@,%ld",authorizers.ref, (long)authorizers.weight];
        UILabel *authorizersLabel = [UILabel labelWithName:authorizersTitle font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
        authorizersLabel.numberOfLines = 0;
        [self.contentView addSubview:authorizersLabel];
        [authorizersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom).offset(kRealValue(10));
            make.left.and.right.equalTo(nameLabel);
            if (authorizers == permissionItem.authorizers.lastObject) {
                make.bottom.equalTo(self.contentView).offset(-kRealValue(15)).priorityLow();
            }
        }];
        
        lastView = authorizersLabel;
    }
}

@end
