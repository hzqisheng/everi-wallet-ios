//
//  QSSelectMenuView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSSelectMenuItem.h"
@class QSSelectMenuView;

NS_ASSUME_NONNULL_BEGIN
@protocol QSSelectMenuViewDelegate <NSObject>

@required
- (NSArray<QSSelectMenuItem *> *)dataSourceInSelectMenuView:(QSSelectMenuView *)selectMenuView;

@optional
- (void)selectMenuView:(QSSelectMenuView *)selectMenuView didSelectedItem:(QSSelectMenuItem *)item;

@end

@interface QSSelectMenuView : UIView

@property (nonatomic, assign) id<QSSelectMenuViewDelegate>delegate;

/**
 *  show selectMenu
 *
 *  @param view parentView
 */
- (void)showInView:(UIView *)view;

/**
 *  isShow
 */
- (BOOL)isShow;

/**
 *  hide
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
