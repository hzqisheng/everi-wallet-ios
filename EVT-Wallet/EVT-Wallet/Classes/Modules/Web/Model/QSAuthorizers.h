//
//  QSAuthorizers.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSAuthorizers : QSBaseModel

@property (nonatomic, copy) NSString *ref;
@property (nonatomic, assign) NSInteger weight;

@end

NS_ASSUME_NONNULL_END
