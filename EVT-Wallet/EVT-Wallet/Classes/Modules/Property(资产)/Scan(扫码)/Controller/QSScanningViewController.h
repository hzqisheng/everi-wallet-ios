//
//  QSScanningViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"

typedef NS_ENUM(NSUInteger, QSScanningType) {
    //普通扫码
    QSScanningTypeNomal,
    //扫码收款
    QSScanningTypeCollect,
    //扫码付款
    QSScanningTypePay,
};

NS_ASSUME_NONNULL_BEGIN

typedef void(^ParseEvtLinkPublicKeyAndPopBlock)(NSString *publicKey);

@interface QSScanningViewController : QSBaseViewController

/** 返回publickey pop扫码页面 */
@property (nonatomic, copy) ParseEvtLinkPublicKeyAndPopBlock parseEvtLinkAndPopBlock;

/** 扫码类型 默认是普通扫码*/
@property (nonatomic, assign) QSScanningType scanningType;

@end

NS_ASSUME_NONNULL_END
