//
//  QSCreateGroupViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "MYTreeTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^GroupDidCreateSuccessBlock)(void);

@interface QSCreateGroupViewController : MYTreeTableViewController

/** 创建组成功的回调 */
@property (nonatomic, copy) GroupDidCreateSuccessBlock groupDidCreateSuccessBlock;

/** 初始化方法 */
- (instancetype)initWithGroupName:(NSString * _Nullable)groupName
                        threshold:(NSString * _Nullable)threshold
                        treeItems:(NSSet<MYTreeItem *> * _Nullable)treeItems;
@end

NS_ASSUME_NONNULL_END
