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
    if (!address) {
        return;
    }
    NSArray *localAddressList = [self getAddress];
    for (QSAddress *localAddress in localAddressList) {
        if ([localAddress.publicKey isEqualToString:address.publicKey]) {
            [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_manage_address_exist_toast")];
            return;
        }
    }
    
    NSMutableArray *addressArray = [NSMutableArray arrayWithArray:localAddressList];
    [addressArray addObject:address];
    [self saveAddressList:[addressArray copy]];
}

- (void)deleteAddress:(NSString *)publicKey {
    NSArray *localAddress = [self getAddress];
    NSMutableArray *muLocalAddress = [NSMutableArray arrayWithArray:localAddress];
    for (QSAddress *address in localAddress) {
        if ([address.publicKey isEqualToString:publicKey]) {
            [muLocalAddress removeObject:address];
        }
    }
    
    [self saveAddressList:[muLocalAddress copy]];
}

- (void)saveAddressList:(NSArray *)addressList {
    NSData *addressData = [NSKeyedArchiver archivedDataWithRootObject:addressList];
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
