//
//  QSEnterJsonViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^EnterJsonViewControllerSubmitJsonBlock)(NSString *text);

@interface QSEnterJsonViewController : QSBaseViewController

@property (nonatomic, copy) EnterJsonViewControllerSubmitJsonBlock enterJsonViewControllerSubmitJsonBlock;

@end

NS_ASSUME_NONNULL_END
