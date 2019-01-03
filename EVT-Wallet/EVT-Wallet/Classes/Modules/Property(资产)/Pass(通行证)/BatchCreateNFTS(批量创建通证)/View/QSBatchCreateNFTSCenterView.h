//
//  QSBatchCreateNFTSCenterView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BatchCreateNFTSCenterViewCreateBtnClickedBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface QSBatchCreateNFTSCenterView : UIView

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIButton *subtractButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *productButton;

@property (nonatomic, copy) BatchCreateNFTSCenterViewCreateBtnClickedBlock batchCreateNFTSCenterViewCreateBtnClickedBlock;

@end

NS_ASSUME_NONNULL_END
