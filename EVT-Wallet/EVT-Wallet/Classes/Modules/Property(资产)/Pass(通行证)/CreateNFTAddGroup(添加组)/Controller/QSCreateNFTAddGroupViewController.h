//
//  QSCreateNFTAddGroupViewController.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CreateNFTAddGroupConfirmBlock)(NSString *groupName, NSString *weight);

@interface QSCreateNFTAddGroupViewController : QSBaseViewController

@property (nonatomic, copy) CreateNFTAddGroupConfirmBlock createNFTAddGroupConfirmBlock;

@end

NS_ASSUME_NONNULL_END
