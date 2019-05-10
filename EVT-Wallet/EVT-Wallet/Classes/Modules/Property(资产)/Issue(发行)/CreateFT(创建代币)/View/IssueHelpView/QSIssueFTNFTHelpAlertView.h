//
//  QSIssueFTNFTHelpAlertView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/2/20.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSIssueFTNFTHelpModel.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const QSIssueFTNFTHelpAlertRemindKey;

@interface QSIssueFTNFTHelpAlertView : UIView

+ (instancetype)showWithDataArray:(NSArray<QSIssueFTNFTHelpModel *> *)dataArray;

+ (BOOL)isNeedRemind;

@end

NS_ASSUME_NONNULL_END
