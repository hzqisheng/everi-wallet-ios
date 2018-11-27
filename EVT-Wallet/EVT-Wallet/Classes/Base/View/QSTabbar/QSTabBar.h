//
//  QSTabBar.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSTabBar;

@protocol QSTabBarDelegate <NSObject>

@optional
- (void)qsTabbarDidClickedCenterButton:(QSTabBar *)tabBar;

@end

@interface QSTabBar : UITabBar

/** center Button */
@property (nonatomic, strong) UIButton *centerButton;

/** qsDelegate */
@property (nonatomic,weak) id<QSTabBarDelegate> qsDelegate;

@end
