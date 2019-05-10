//
//  QSCreateNFTSEditViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^QSCreateNFTSEditViewControllerSaveBlock)(NSString *text);

@interface QSCreateNFTSEditViewController : QSBaseViewController

@property (nonatomic, copy) QSCreateNFTSEditViewControllerSaveBlock createNFTSEditViewControllerSaveBlock;

@end

NS_ASSUME_NONNULL_END
