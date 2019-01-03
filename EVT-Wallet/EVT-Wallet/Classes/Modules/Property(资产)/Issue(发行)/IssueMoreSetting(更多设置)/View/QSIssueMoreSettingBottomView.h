//
//  QSIssueMoreSettingBottomView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSIssueMoreSettingBottomViewAddMetadataBlock)(void);

@interface QSIssueMoreSettingBottomView : UIView

@property (nonatomic, strong) UILabel *metadataLabel;
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, copy) QSIssueMoreSettingBottomViewAddMetadataBlock issueMoreSettingBottomViewAddMetadataBlock;

@end

NS_ASSUME_NONNULL_END
