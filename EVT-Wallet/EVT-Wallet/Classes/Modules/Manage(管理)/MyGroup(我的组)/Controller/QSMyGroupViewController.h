//
//  QSMyGroupViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MyGroupClickedGroupBlock)(NSString *groupName);

@interface QSMyGroupViewController : QSBaseCornerSectionTableViewController

@property (nonatomic, copy, nullable) MyGroupClickedGroupBlock myGroupClickedGroupBlock;

@end

NS_ASSUME_NONNULL_END
