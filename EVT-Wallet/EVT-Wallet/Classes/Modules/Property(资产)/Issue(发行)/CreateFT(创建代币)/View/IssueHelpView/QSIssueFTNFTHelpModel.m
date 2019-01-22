//
//  QSIssueFTNFTHelpModel.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/22.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSIssueFTNFTHelpModel.h"

@implementation QSIssueFTNFTHelpModel

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content {
    if (self = [super init]) {
        _title = title;
        _content = content;
    }
    return self;
}

@end
