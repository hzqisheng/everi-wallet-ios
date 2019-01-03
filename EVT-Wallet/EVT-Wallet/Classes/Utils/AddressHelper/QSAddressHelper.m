//
//  QSAddressHelper.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/15.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSAddressHelper.h"

static NSString * const kAddressKey = @"kAddressKey";

@implementation QSAddressHelper

- (void)addAddress:(QSAddress *)address {
    NSData *addressData = [QSUserDefaults objectForKey:kAddressKey];
    NSMutableArray *addressArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:addressData]];
    [addressArray addObject:address];
    addressData = [NSKeyedArchiver archivedDataWithRootObject:addressArray];
    [QSUserDefaults setObject:addressData forKey:kAddressKey];
    [QSUserDefaults synchronize];
}

- (NSMutableArray *)getAddress {
    NSData *addressData = [QSUserDefaults objectForKey:kAddressKey];
    NSMutableArray *addressArray = [NSKeyedUnarchiver unarchiveObjectWithData:addressData];
    return addressArray;
}

+ (instancetype)sharedHelper {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

@end
