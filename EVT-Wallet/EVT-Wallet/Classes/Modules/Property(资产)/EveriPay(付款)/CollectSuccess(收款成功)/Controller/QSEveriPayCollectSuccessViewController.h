//
//  QSEveriPayCollectSuccessViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSEveriPayCollectSuccessViewController : QSBaseViewController

@property (nonatomic, copy) NSString *money;
@property (nonatomic, strong) QSFungibleSymbol *Model;

@end

NS_ASSUME_NONNULL_END
