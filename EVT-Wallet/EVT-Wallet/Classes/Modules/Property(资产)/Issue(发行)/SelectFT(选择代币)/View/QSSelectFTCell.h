//
//  QSSelectFTCell.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/11.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSFT.h"
@class QSSelectFTCell;

NS_ASSUME_NONNULL_BEGIN

typedef void(^QSSelectFTCellDidClickMoreButtonBlock)(QSSelectFTCell *cell);

@interface QSSelectFTCell : UITableViewCell

@property (nonatomic, strong) UIView *cornerView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *blockchainLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) QSFT *ftModel;

@property (nonatomic, copy) QSSelectFTCellDidClickMoreButtonBlock selectFTCellDidClickMoreButtonBlock;

@end

NS_ASSUME_NONNULL_END
