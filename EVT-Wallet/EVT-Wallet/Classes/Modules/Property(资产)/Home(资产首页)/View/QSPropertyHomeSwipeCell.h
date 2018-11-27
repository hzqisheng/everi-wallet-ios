//
//  QSPropertyHomeSwipeCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSPropertyHomeSwipeCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^SwipeCellClickedBlock)(QSPropertyHomeSwipeCell *cell);

@interface QSPropertyHomeSwipeCell : UITableViewCell

@property (nonatomic, strong) UIImageView *cardImageView;

@property (nonatomic, copy) SwipeCellClickedBlock swipeCellClickedBlock;

@end

NS_ASSUME_NONNULL_END
