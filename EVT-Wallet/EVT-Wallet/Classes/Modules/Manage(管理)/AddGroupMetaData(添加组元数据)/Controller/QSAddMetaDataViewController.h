//
//  QSAddGroupMetaDataViewController.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/10.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddMetaDataComfirmBlock)(NSString *key, NSString *value);

@interface QSAddMetaDataViewController : QSBaseViewController

@property (nonatomic, copy) AddMetaDataComfirmBlock addMetaDataBlock;

@end

NS_ASSUME_NONNULL_END
