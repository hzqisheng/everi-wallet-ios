//
//  QSIssueFTNFTHelpAlertView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/2/20.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSIssueFTNFTHelpModel.h"

extern NSString * const QSIssueFTNFTHelpAlertRemindKey;

NS_ASSUME_NONNULL_BEGIN

@interface QSIssueFTNFTHelpAlertView : UIView

+ (instancetype)showWithDataArray:(NSArray<QSIssueFTNFTHelpModel *> *)dataArray;

+ (BOOL)isNeedRemind;

@end

NS_ASSUME_NONNULL_END
