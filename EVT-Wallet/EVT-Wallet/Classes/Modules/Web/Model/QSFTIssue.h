//
//  QSFTIssue.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSFTIssue : QSBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger threshold;
@property (nonatomic, strong) NSArray *authorizers;

@end

NS_ASSUME_NONNULL_END
