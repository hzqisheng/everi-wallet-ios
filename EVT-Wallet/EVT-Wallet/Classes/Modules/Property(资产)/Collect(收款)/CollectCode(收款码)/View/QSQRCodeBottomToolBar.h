//
//  QSQRCodeBottomToolBar.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickedItemBlock)(NSInteger index);

@interface QSQRCodeBottomToolBar : UIView

@property (nonatomic, copy) ClickedItemBlock clickedItemBlock;

@property (nonatomic, copy) NSString *codeTitle;
@property (nonatomic, copy) NSString *scanTitle;


+ (CGFloat)toolBarHeight;

@end

NS_ASSUME_NONNULL_END
