//
//  QSIssueFTNFTHelpModel.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSIssueFTNFTHelpModel : QSBaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
