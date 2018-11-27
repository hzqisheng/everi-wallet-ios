//
//  UIView+HUD.h
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface UIView (HUD)

/**
 * hud
 */
@property (nonatomic,strong) MBProgressHUD *MBHUD;

/**
 * 弹窗 自动消失文字
 */
- (void)showAutoHideHudWithText:(NSString *)text;

/**
 * 弹窗 菊花 不自动消失
 */
- (void)showIndeterminateHudWithText:(NSString *)text;
/**
 * 隐藏
 */
- (void)hideHud;

@end
