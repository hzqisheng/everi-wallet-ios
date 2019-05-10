//
//  QSManageNewNodeViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/14.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNewLeafNodeBlock)(NSString *key, NSString *weight);
typedef void(^AddNewNoLeafNodeBlock)(NSString *threshold, NSString *weight);

@interface QSManageNewNodeViewController : QSBaseViewController

/** 添加叶节点的回调 */
@property (nonatomic, copy) AddNewLeafNodeBlock addNewLeafNodeBlock;

/** 添加非叶节点的回调 */
@property (nonatomic, copy) AddNewNoLeafNodeBlock addNewNoLeafNodeBlock;

/** 是否只能选择叶节点 默认是NO */
@property (nonatomic, assign) BOOL selectLeafOnly;

@end

NS_ASSUME_NONNULL_END
