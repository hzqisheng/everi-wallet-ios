//
//  QSBottomButtonCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ButtonClickedBlock)(void);

@interface QSBottomButtonView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                 clickedBlock:(ButtonClickedBlock)block;

@end

NS_ASSUME_NONNULL_END
