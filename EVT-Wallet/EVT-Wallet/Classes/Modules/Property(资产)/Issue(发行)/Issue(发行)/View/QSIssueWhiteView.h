//
//  QSIssueWhiteView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSIssueWhiteViewDidClickChooseAddressButtonBlock)(void);
typedef void(^QSIssueWhiteViewDidClickSweepButtonBlock)(void);

@interface QSIssueWhiteView : UIView

@property (nonatomic, strong) UILabel *circulationLabel;
@property (nonatomic, strong) UITextField *circulationGrayTextField;

@property (nonatomic, strong) UIView *lineView1;

@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UIImageView *addressImageView;
@property (nonatomic, strong) UIButton *sweepButton;

@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UITextField *remarkTextField;

@property (nonatomic, copy) QSIssueWhiteViewDidClickChooseAddressButtonBlock issueWhiteViewDidClickChooseAddressButtonBlock;
@property (nonatomic, copy) QSIssueWhiteViewDidClickSweepButtonBlock issueWhiteViewDidClickSweepButtonBlock;

@end

NS_ASSUME_NONNULL_END
