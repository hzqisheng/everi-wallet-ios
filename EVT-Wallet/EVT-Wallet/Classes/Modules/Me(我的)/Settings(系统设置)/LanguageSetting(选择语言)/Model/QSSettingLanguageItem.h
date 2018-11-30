//
//  QSSettingLanguageItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSSettingLanguageItem : QSSettingItem

/** default is 17*17 */
@property (nonatomic, assign) CGSize rightCheckImageSize;
/** isChecked */
@property (nonatomic, assign, getter=isChecked) BOOL checked;

@end

NS_ASSUME_NONNULL_END
