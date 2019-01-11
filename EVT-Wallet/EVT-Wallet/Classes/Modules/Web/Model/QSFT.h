//
//  QSFT.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"
#import "QSFTIssue.h"
#import "QSFTManage.h"
#import "QSMetas.h"
#import "QSAuthorizers.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSFT : QSBaseModel

@property (nonatomic, copy) NSString *asset;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *current_supply;
@property (nonatomic, strong) QSFTIssue *issue;
@property (nonatomic, strong) QSFTManage *manage;
@property (nonatomic, strong) NSArray *metas;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sym;
@property (nonatomic, copy) NSString *sym_name;
@property (nonatomic, copy) NSString *total_supply;

@property (nonatomic, copy) NSString *amount;


@end

NS_ASSUME_NONNULL_END
