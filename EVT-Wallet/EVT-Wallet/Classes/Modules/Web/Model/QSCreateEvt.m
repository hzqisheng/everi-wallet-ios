//
//  QSCreateEvt.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSCreateEvt.h"

@implementation QSCreateEvt

- (NSString *)evtShowName {
    if (self.evtName.length) {
        return self.evtName;
    }
    return @"everiToken-wallet";
}

@end
