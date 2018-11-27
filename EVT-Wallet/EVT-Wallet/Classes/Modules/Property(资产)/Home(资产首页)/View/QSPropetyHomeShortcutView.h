//
//  QSPropetyHomeShortcutView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSPropetyHomeShortcutView;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QSShortcutType) {
    /** scan */
    QSShortcutTypeScan,
    /** pay */
    QSShortcutTypeEveriPay,
    /** collect */
    QSShortcutTypeCollect,
    /** issue */
    QSShortcutTypeIssue,
};

@protocol QSPropetyHomeShortcutViewDelegate <NSObject>

@optional
- (void)shortcutView:(QSPropetyHomeShortcutView *)shortcutView didClickedItemByType:(QSShortcutType)type;

@end

@interface QSPropetyHomeShortcutView : UIView

@property (nonatomic,weak) id<QSPropetyHomeShortcutViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
