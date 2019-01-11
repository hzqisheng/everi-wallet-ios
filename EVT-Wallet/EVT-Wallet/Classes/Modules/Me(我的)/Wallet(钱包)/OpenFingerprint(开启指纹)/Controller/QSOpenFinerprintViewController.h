//
//  QSOpenFinerprintViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/9.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OpenFinerprintSuccessBlock)(void);

@interface QSOpenFinerprintViewController : QSBaseViewController

@property (nonatomic, copy) OpenFinerprintSuccessBlock openFinerprintSuccessBlock;

@end

NS_ASSUME_NONNULL_END
