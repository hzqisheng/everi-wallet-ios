//
//  QSPayInfoHeaderView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSFT.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSPayInfoHeaderView : UIView

@property (nonatomic, strong) QSFT *FTModel;
@property (nonatomic, copy) NSString *transferAmount;

@end

NS_ASSUME_NONNULL_END
