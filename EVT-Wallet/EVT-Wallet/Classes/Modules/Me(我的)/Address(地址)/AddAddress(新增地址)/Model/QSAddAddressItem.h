//
//  QSAddAddressItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSSettingItem.h"
@class QSAddAddressCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^TypeClickedBlock)(QSAddAddressCell *cell);
typedef void(^ScanClickedBlock)(QSAddAddressCell *cell);
typedef void(^TextFieldTextChangedBlock)(QSAddAddressCell *cell);


@interface QSAddAddressItem : QSSettingItem

/** typeButton */
/** default is 83 */
@property (nonatomic, assign) CGFloat typeButtonLeftMargin;
/** default is 8 */
@property (nonatomic, assign) CGFloat typeButtonSpace;
/** default is 50*25 */
@property (nonatomic, assign) CGSize typeButtonSize;
/** default is NO */
@property (nonatomic, assign) BOOL showTypeButton;

/** textFiled */
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *textFieldText;
/** default is 83 */
@property (nonatomic, assign) CGFloat textFieldLeftMargin;
/** default is 26 */
@property (nonatomic, assign) CGFloat textFieldRightMargin;
@property (nonatomic, copy) TextFieldTextChangedBlock textFieldTextChangedBlock;
/** default is NO */
@property (nonatomic, assign) BOOL showTextField;

/** scanButton */
/** default is 22*22 */
@property (nonatomic, assign) CGSize scanButtonSize;
@property (nonatomic, copy) ScanClickedBlock scanClickedBlock;

@property (nonatomic, copy) TypeClickedBlock typeClickedBlock;

/** default is NO */
@property (nonatomic, assign) BOOL showScanButton;

@end

NS_ASSUME_NONNULL_END
