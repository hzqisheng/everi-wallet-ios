//
//  QSIssueMoreSettingTopView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSIssueMoreSettingTopView : UIView

@property (nonatomic, strong) UILabel *EVTLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *lineView1;

@property (nonatomic, strong) UILabel *issueLabel;
@property (nonatomic, strong) UILabel *issueThresholdLabel;
@property (nonatomic, strong) UILabel *issueLetterLabel;

@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UILabel *managementLabel;
@property (nonatomic, strong) UILabel *managementThresholdLabel;

@end

NS_ASSUME_NONNULL_END
