//
//  QSCreateFTHelpPopupView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSIssueFTNFTHelpModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSIssueFTNFTHelpPopupView : UIView

+ (instancetype)showInView:(UIView *)view
         dataArray:(NSArray<QSIssueFTNFTHelpModel *> *)dataArray;

- (void)dissmiss;

@end

NS_ASSUME_NONNULL_END
