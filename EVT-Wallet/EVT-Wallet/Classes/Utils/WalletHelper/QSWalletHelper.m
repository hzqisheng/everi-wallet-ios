//
//  QSWalletHelper.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSWalletHelper.h"

static NSString * const kWalletKey = @"kWalletKey";

@implementation QSWalletHelper

+ (instancetype)sharedHelper {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        NSData *userData = [QSUserDefaults objectForKey:kWalletKey];
        if (userData) {
            _currentEvt = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        }
        DLog(@"_evt:%@",_currentEvt);
    }
    return self;
}

- (void)loginWithEvt:(QSCreateEvt *)evt {
    _currentEvt = evt;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:evt];
    [QSUserDefaults setObject:data forKey:kWalletKey];
    [QSUserDefaults synchronize];
}

@end
