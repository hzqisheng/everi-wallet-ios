//
//  QSSettingItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/27.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

typedef NS_ENUM(NSUInteger, QSSettingItemType) {
    //↓↓↓↓↓ style ↓↓↓↓↓
    ///image text      >
    QSSettingItemTypeDefault,
    ///text            >
    QSSettingItemTypeAccessnory,
    ///text        text
    QSSettingItemTypeLeftRightTitle,
    ///image text  text>
    QSSettingItemTypeImageAndLeftRightTitle,
    ///image text  text>
    QSSettingItemTypeLeftRightTitleAccessnory
    
    /**
     If you want to custom style,
     inheriting QSSettingCell to custom controls style
     inheriting QSSettingItem to custom layout style
     */
};

NS_ASSUME_NONNULL_BEGIN
/**
 Attention!
 most Item inherit from this file, please try not to delete or change default value(you can add values).
 try to change the subclass
 */
@interface QSSettingItem : QSBaseCellItem

/** itemType */
@property (nonatomic, assign) QSSettingItemType cellType;

//=================== left views config =================//
/** most left subview margin default is 20 */
@property (nonatomic, assign) CGFloat leftSubviewMargin;
/** left Image */
@property (nonatomic, strong) UIImage *leftImage;
/** left Image Size default:22*22 */
@property (nonatomic, assign) CGSize leftImageSize;
/** left Title */
@property (nonatomic, copy) NSString *leftTitle;
/** left Title Color default:#333333 */
@property (nonatomic, strong) UIColor *leftTitleColor;
/** left Title Font default:14*/
@property (nonatomic, strong) UIFont *leftTitleFont;
/** leftImageAndTitleSpace default:18 */
@property (nonatomic, assign) CGFloat leftImageAndTitleSpace;
/** leftTitleLabelSize default:max180*/
@property (nonatomic, assign) CGSize leftTitleLabelSize;

// ================= right views config ================ //
/** right arrow size */
@property (nonatomic, assign) CGSize arrowImageViewSize;
/** most right subview margin default is 13 */
@property (nonatomic, assign) CGFloat rightSubviewMargin;
/** rightTitle */
@property (nonatomic, copy) NSString *rightTitle;
/** right number of lines default is 1*/
@property (nonatomic, assign) NSInteger rightNumberOfLines;
/** rightTitleColor default:#BBBBBB */
@property (nonatomic, strong) UIColor *rightTitleColor;
/** rightTitleFont default:14 */
@property (nonatomic, strong) UIFont *rightTitleFont;
/** rightTitleLabelSize */
@property (nonatomic, assign) CGSize rightTitleLabelSize;
/** leftImageAndTitleSpace default:8 */
@property (nonatomic, assign) CGFloat rightArrowAndTitleSpace;

@end

NS_ASSUME_NONNULL_END
