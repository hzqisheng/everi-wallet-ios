//
//  QSBaseTableViewCell.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QSBaseTableViewCellProtocol <NSObject>

@optional
- (void)configureSubViews;

@end

@interface QSBaseTableViewCell : UITableViewCell<QSBaseTableViewCellProtocol>

@end

NS_ASSUME_NONNULL_END
