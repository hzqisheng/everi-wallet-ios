//
//  QSEveriPassTransferLogCell.m
//  EVT-Wallet
//
//  Created by SJ on 2019/8/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassTransferLogCell.h"

@interface QSEveriPassTransferLogCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation QSEveriPassTransferLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    _timeLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRealValue(15));
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.height.equalTo(@([UIFont qs_fontOfSize14].lineHeight));
    }];
    
    _addressLabel = [UILabel labelWithName:@"" font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [_addressLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    _addressLabel.numberOfLines = 0;
    [self.contentView addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(kRealValue(8));
        make.left.equalTo(self.contentView).offset(kRealValue(15));
        make.right.equalTo(self.contentView).offset(-kRealValue(15));
        make.bottom.equalTo(self.contentView).offset(-kRealValue(15));
    }];
}

- (void)setTransferLog:(QSNFTTransferLog *)transferLog {
    _transferLog = transferLog;
    
    _timeLabel.text = [NSString stringWithFormat:@"%@%@",QSLocalizedString(@"qs_transfer_nft_log_transfer_time_title"), [transferLog.timestamp transformServerTimeToLocalTime]];

    NSString *transferAddress = @"";
    for (int i = 0; i < transferLog.data.to.count; i ++) {
        NSString *address = transferLog.data.to[i];
        if (i == 0) {
            transferAddress = address;
        } else {
            transferAddress = [NSString stringWithFormat:@"%@\n%@",transferAddress,address];
        }
    }

    _addressLabel.text = [NSString stringWithFormat:@"%@\n%@",QSLocalizedString(@"qs_transfer_nft_log_transfer_to_title"),transferAddress];
}

@end
