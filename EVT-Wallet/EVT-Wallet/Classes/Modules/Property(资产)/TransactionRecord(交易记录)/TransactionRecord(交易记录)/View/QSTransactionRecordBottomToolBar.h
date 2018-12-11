//
//  QSTransactionRecordBottomToolBar.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ToolBarClickedBlock)(NSInteger index);

@interface QSTransactionRecordBottomToolBar : UIView

@property (nonatomic, copy) ToolBarClickedBlock toolBarClickedBlock;

+ (CGFloat)toolBarHeight;

@end

NS_ASSUME_NONNULL_END
