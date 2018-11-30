//
//  QSHelpCenterItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/29.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSHelpCenterOverViewItem : QSSettingItem

@property (nonatomic, assign) CGFloat leftTitleTopMargin;

@property (nonatomic, copy) NSString *functionOverView;
/** default is 14 */
@property (nonatomic, strong) UIFont *functionOverViewFont;
/** default is #686868 */
@property (nonatomic, strong) UIColor *functionOverViewTextColor;
@property (nonatomic, assign) CGSize functionOverViewSize;
/** default is 15 */
@property (nonatomic, assign) CGFloat functionOverViewTopMargin;
/** cell Expand Height*/
@property (nonatomic, assign) CGFloat cellExpandHeight;
/** cell Expand Height*/
@property (nonatomic, assign) CGFloat cellNoExpandHeight;
/** is Expand */
@property (nonatomic, assign, getter=isExpand) BOOL expand;


@end

NS_ASSUME_NONNULL_END
