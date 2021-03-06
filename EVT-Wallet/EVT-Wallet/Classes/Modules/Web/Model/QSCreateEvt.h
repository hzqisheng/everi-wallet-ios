//
//  QSCreateEvt.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSCreateEvt : QSBaseModel
/**
 {
 mnemoinc = "unfold peanut private luggage wrap arena combine actual awkward other color imitate";
 password = 12345678;
 privateKey = 5HvSqMMiM8QWERZEMrEQFak6ecKZEpsGiPmih3GWGtdgmBP8db9;
 publicKey = EVT5tzKJyrhW2eGRKGfow94AA1pVhCAWZeTGrDhHTyUDLTGCdk1rB;
 type = EVT;
 }
 */
@property (nonatomic, copy) NSString *mnemoinc;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *privateKey;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *evtName;

/** 显示名称 */
@property (nonatomic, copy) NSString *evtShowName;
/** 是否开通了指纹/FaceID验证 */
@property (nonatomic, assign) BOOL isOpenFingerprint;

@end

NS_ASSUME_NONNULL_END
