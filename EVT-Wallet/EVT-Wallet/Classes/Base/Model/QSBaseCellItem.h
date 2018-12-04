//
//  QSBaseCellItem.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSBaseCellItem : QSBaseModel

/** cellIdentifierId -> cellClassName */
@property (nonatomic, copy) NSString *cellIdentifier;

/** cellTag*/
@property (nonatomic, assign) NSInteger cellTag;

/** itemHeight default:52 */
@property (nonatomic, assign) CGFloat cellHeight;
/** itemWidth default:screenW-30 */
@property (nonatomic, assign) CGFloat cellWidth;

/** seaprator inset default is UIEdgeInsetsMake(0, 0, 0, 0) */
@property (nonatomic, assign) UIEdgeInsets cellSeapratorInset;


@end

NS_ASSUME_NONNULL_END
