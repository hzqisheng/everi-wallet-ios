//
//  QSIssuePopupView.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/10.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssuePopupView.h"

@interface QSIssuePopupView ()

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, copy) IssueClickedBlock issueClickedBlock;

@end

@implementation QSIssuePopupView

+ (void)showIssuePopupViewAndIssueClickedBlock:(IssueClickedBlock)issueClickedBlock {
    QSIssuePopupView *view = [[QSIssuePopupView alloc] initWithFrame:kScreenBounds];
    view.issueClickedBlock = issueClickedBlock;
    [view show];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupSubViews];
    }
    return self;
}

- (void)p_setupSubViews {
    //mask
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    [self addSubview:maskView];
    _maskView = maskView;
    [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)]];
    
    //FT
    UIImageView *issueFTImageView = [[UIImageView alloc] init];
    issueFTImageView.image = [UIImage imageNamed:@"bg_zichan_faxing"];
    [self addSubview:issueFTImageView];
    [issueFTImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-kRealValue(8));
        make.left.equalTo(self).offset(kRealValue(28));
        make.right.equalTo(self).offset(-kRealValue(28));
        make.height.equalTo(@kRealValue(95));
    }];
    issueFTImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *ftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(issueFTTapped)];
    [issueFTImageView addGestureRecognizer:ftTap];
    
    UILabel *issueFTTitleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_issue_ft_pop_up_title") font:[UIFont qs_boldFontOfSize16] textColor:[UIColor qs_colorBlack14161A] textAlignment:NSTextAlignmentCenter];
    [issueFTImageView addSubview:issueFTTitleLabel];
    [issueFTTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(issueFTImageView).offset(kRealValue(27));
        make.left.equalTo(issueFTImageView).offset(kRealValue(10));
        make.right.equalTo(issueFTImageView).offset(-kRealValue(10));
    }];
    
    UILabel *issueFTContentLabel = [UILabel labelWithName:QSLocalizedString(@"qs_issue_ft_pop_up_content") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentCenter];
    issueFTContentLabel.numberOfLines = 0;
    [issueFTImageView addSubview:issueFTContentLabel];
    [issueFTContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(issueFTTitleLabel.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(issueFTImageView).offset(kRealValue(20));
        make.right.equalTo(issueFTImageView).offset(-kRealValue(20));
    }];
    
    //NFT
    UIImageView *issueNFTImageView = [[UIImageView alloc] init];
    issueNFTImageView.image = [UIImage imageNamed:@"bg_zichan_faxing"];
    [self addSubview:issueNFTImageView];
    [issueNFTImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(kRealValue(8));
        make.left.equalTo(self).offset(kRealValue(28));
        make.right.equalTo(self).offset(-kRealValue(28));
        make.height.equalTo(@kRealValue(95));
    }];
    issueNFTImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *nftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(issueNFTTapped)];
    [issueNFTImageView addGestureRecognizer:nftTap];
    
    UILabel *issueNFTTitleLabel = [UILabel labelWithName:QSLocalizedString(@"qs_issue_nft_pop_up_title") font:[UIFont qs_boldFontOfSize16] textColor:[UIColor qs_colorBlack14161A] textAlignment:NSTextAlignmentCenter];
    [issueNFTImageView addSubview:issueNFTTitleLabel];
    [issueNFTTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(issueNFTImageView).offset(kRealValue(27));
        make.left.equalTo(issueNFTImageView).offset(kRealValue(10));
        make.right.equalTo(issueNFTImageView).offset(-kRealValue(10));
    }];
    
    UILabel *issueNFTContentLabel = [UILabel labelWithName:QSLocalizedString(@"qs_issue_nft_pop_up_content") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentCenter];
    issueNFTContentLabel.numberOfLines = 0;
    [issueNFTImageView addSubview:issueNFTContentLabel];
    [issueNFTContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(issueNFTTitleLabel.mas_bottom).offset(kRealValue(5));
        make.left.equalTo(issueNFTImageView).offset(kRealValue(20));
        make.right.equalTo(issueNFTImageView).offset(-kRealValue(20));
    }];
}

#pragma mark - **************** Private Methods
- (void)show {
    [QSAppKeyWindow addSubview:self];
    [UIView animateWithDuration:.3f animations:^{
        self.maskView.alpha = 0.5;
    }];
}

- (void)dissmiss {
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - **************** Event Response
- (void)issueNFTTapped {
    if (self.issueClickedBlock) {
        self.issueClickedBlock(QSIssueTypeNFTS);
    }
    [self dissmiss];
}

- (void)issueFTTapped {
    if (self.issueClickedBlock) {
        self.issueClickedBlock(QSIssueTypeFTS);
    }
    [self dissmiss];
}

@end
