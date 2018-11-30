//
//  QSMyWalletSectionHeaderView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/28.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WalletSectionHeaderClickedBlock)(NSInteger section);

@interface QSMyWalletSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, copy) WalletSectionHeaderClickedBlock walletSectionHeaderClickedBlock;

@end

NS_ASSUME_NONNULL_END
