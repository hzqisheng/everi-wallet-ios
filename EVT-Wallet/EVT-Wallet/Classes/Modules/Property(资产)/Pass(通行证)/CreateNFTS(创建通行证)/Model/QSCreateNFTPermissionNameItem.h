//
//  QSCreateNFTPermissionNameItem.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/13.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSBaseCellItemDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSCreateNFTPermissionNameItem : QSBaseModel<QSBaseCellItemDataProtocol>

/** issue/transfer/manage */
@property (nonatomic, copy) NSString *permissionName;

/** 点击新增 */
@property (nonatomic, copy) void(^addPermissionClickedBlock)(QSCreateNFTPermissionNameItem *item);

@end

NS_ASSUME_NONNULL_END
