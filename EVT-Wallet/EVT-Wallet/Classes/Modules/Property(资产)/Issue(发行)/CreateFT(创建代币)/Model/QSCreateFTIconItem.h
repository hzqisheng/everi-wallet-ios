//
//  QSCreateFTIconItem.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/11.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSCreateFTIconItemSelectedImageBlock)(UIImage *image);

@interface QSCreateFTIconItem : QSBaseCellItem

//title
@property (nonatomic, copy) NSString *title;

//icon
@property (nonatomic, strong) UIImage *selectIcon;

@property (nonatomic, copy) QSCreateFTIconItemSelectedImageBlock createFTIconItemSelectedImageBlock;

@end

NS_ASSUME_NONNULL_END
