//
//  QSIssuePermissionsIssueView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSIssuePermissionsIssueViewClickEditBlock)(void);

@interface QSIssuePermissionsIssueView : UIView

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView1;

@property (nonatomic, strong) UIButton *onlyButton;
@property (nonatomic, strong) UILabel *onlyLabel;

@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UIButton *manualButton;
@property (nonatomic, strong) UILabel *manualLabel;
@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, copy) QSIssuePermissionsIssueViewClickEditBlock issuePermissionsIssueViewClickEditBlock;

@end

NS_ASSUME_NONNULL_END
