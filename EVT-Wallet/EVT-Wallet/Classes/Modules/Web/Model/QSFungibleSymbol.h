//
//  QSFungibleSymbol.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"
#import "QSFungibleIssue.h"
#import "QSFungibleManage.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSFungibleSymbol : QSBaseModel

@property (nonatomic, copy) NSString *sym;
@property (nonatomic, copy) NSString *sym_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, strong) QSFungibleIssue *issue;
@property (nonatomic, strong) QSFungibleManage *manage;
@property (nonatomic, copy) NSString *total_supply;
@property (nonatomic, copy) NSString *current_supply;
@property (nonatomic, strong) NSArray *metas;

/*
 {
 "sym": "5, S#1",
 "sym_name": "EVT",
 "name": "EVT",
 "creator": "EVT8MGU4aKiVzqMtWi9zLpu8KuTHZWjQQrX475ycSxEkLd6aBpraX",
 "create_time": "2018-06-28T05:31:09",
 "issue": {
 "name": "issue",
 "threshold": 1,
 "authorizers": [{
 "ref": "[A] EVT8MGU4aKiVzqMtWi9zLpu8KuTHZWjQQrX475ycSxEkLd6aBpraX",
 "weight": 1
 }
 ]
 },
 "manage": {
 "name": "manage",
 "threshold": 1,
 "authorizers": [{
 "ref": "[A] EVT8MGU4aKiVzqMtWi9zLpu8KuTHZWjQQrX475ycSxEkLd6aBpraX",
 "weight": 1
 }
 ]
 },
 "total_supply": "100000.00000 S#1",
 "current_supply": "0.00000 S#1",
 "metas": []
 }
 */

@end

NS_ASSUME_NONNULL_END
