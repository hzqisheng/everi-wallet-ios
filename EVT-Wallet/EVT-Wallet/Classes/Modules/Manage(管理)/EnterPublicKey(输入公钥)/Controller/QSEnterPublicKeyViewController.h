//
//  QSEnterPublicKeyViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^EnterPublicKeyViewControllerSaveBlock)(NSString *text);

@interface QSEnterPublicKeyViewController : QSBaseViewController

@property (nonatomic, copy) EnterPublicKeyViewControllerSaveBlock enterPublicKeyViewControllerSaveBlock;

@end

NS_ASSUME_NONNULL_END
