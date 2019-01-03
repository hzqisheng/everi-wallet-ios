//
//  QSMyPassCell.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSNFT.h"
@class QSMyPassCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSMyPassCellClickMoreButtonBlock)(QSMyPassCell *passCell);

@interface QSMyPassCell : UITableViewCell

@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *blockchainLabel;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) QSNFT *NFTModel;

@property (nonatomic, copy) QSMyPassCellClickMoreButtonBlock myPassCellClickMoreButtonBlock;

@end

NS_ASSUME_NONNULL_END
