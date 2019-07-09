//
//  QSAppVersion.h
//  EVT-Wallet
//
//  Created by SJ on 2019/7/5.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSAppVersion : QSBaseModel

@property (nonatomic, copy) NSString *iOSVersion;
@property (nonatomic, assign) BOOL isiOSForceUpdate;
@property (nonatomic, copy) NSString *iOSUploadUrl;
@property (nonatomic, copy) NSString *iOSEnUploadMessage;
@property (nonatomic, copy) NSString *iOSChUploadMessage;

@end

NS_ASSUME_NONNULL_END
