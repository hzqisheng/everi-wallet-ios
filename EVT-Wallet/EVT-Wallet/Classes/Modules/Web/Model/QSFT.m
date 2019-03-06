//
//  QSFT.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSFT.h"

@implementation QSFT

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"metas": @"QSMetas"
             };
}

- (NSString *)fungibleId {
    if (self.asset.length) {
        //4745.30 S#655320035
        NSArray *assetList = [self.asset componentsSeparatedByString:@"#"];
        if (assetList.count == 2) {
            return assetList[1];
        }
    }
    return nil;
}

@end
