//
//  QSCreateFTItem.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/11.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCellItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSCreateFTItemTextBlock)(NSString *text);

@interface QSCreateFTItem : QSBaseCellItem

//placeholde
@property (nonatomic, copy) NSString *placeholde;

//content
@property (nonatomic, copy) NSString *defaultContent;

//title
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) QSCreateFTItemTextBlock createFTItemTextBlock;

@property (nonatomic, assign) UIKeyboardType KeyboardType;

@end

NS_ASSUME_NONNULL_END
