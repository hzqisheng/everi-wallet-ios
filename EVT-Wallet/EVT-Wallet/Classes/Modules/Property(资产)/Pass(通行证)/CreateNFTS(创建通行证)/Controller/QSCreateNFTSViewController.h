//
//  QSCreateNFTSViewController.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/12.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseCornerSectionTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CreateNFTSSuccessBlock)(void);

@interface QSCreateNFTSViewController : QSBaseCornerSectionTableViewController

- (instancetype)initWithDomain:(QSNFT * _Nullable)domain;

@property (nonatomic, copy) CreateNFTSSuccessBlock createNFTSSuccessBlock;

@end

NS_ASSUME_NONNULL_END
