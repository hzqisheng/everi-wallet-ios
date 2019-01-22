//
//  QSIssueFTNFTHelpCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueFTNFTHelpCell.h"

@interface QSIssueFTNFTHelpCell ()

@property (nonatomic, strong) UIView *grayRoundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QSIssueFTNFTHelpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _grayRoundView = [[UIView alloc] init];
        _grayRoundView.backgroundColor = [UIColor qs_colorGrayB0B0B0];
        _grayRoundView.layer.cornerRadius = kRealValue(4);
        [self.contentView addSubview:_grayRoundView];
        [_grayRoundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(kRealValue(19));
            make.left.equalTo(self.contentView).offset(kRealValue(15));
            make.width.and.height.equalTo(@kRealValue(8));
        }];
        
        _titleLabel = [UILabel labelWithName:@"title" font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(kRealValue(15));
            make.left.equalTo(self.grayRoundView.mas_right).offset(kRealValue(9));
            make.right.equalTo(self.contentView).offset(-kRealValue(15));
        }];
        
        _contentLabel = [UILabel labelWithName:@"content" font:[UIFont qs_fontOfSize16] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(kRealValue(10));
            make.left.equalTo(self.grayRoundView.mas_right).offset(kRealValue(9));
            make.right.equalTo(self.contentView).offset(-kRealValue(15));
            make.bottom.equalTo(self.contentView).offset(-kRealValue(15));
        }];
    }
    return self;
}

- (void)setIssueFTNFTHelpModel:(QSIssueFTNFTHelpModel *)issueFTNFTHelpModel {
    _issueFTNFTHelpModel = issueFTNFTHelpModel;
    
    _titleLabel.text = issueFTNFTHelpModel.title;
    
    _contentLabel.text = issueFTNFTHelpModel.content;
}

@end
