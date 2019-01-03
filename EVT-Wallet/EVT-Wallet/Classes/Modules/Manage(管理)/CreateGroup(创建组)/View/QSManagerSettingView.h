//
//  QSManagerSettingView.h
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/13.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ManagerSettingViewEditBlock)(void);
typedef void(^ManagerSettingViewSelectAddressBlock)(void);
typedef void(^ManagerSettingViewEnterKeyBlock)(void);

@interface QSManagerSettingView : UIView

+ (void)showManagerSettingViewWithTag:(NSInteger)btnTag
                         andEditBlock:(void(^)(void))block
                         andSelectBlock:(void(^)(void))selectBlock
                       andEnterKeyBlock:(void(^)(void))enterKeyBlock;

@property (nonatomic, copy) ManagerSettingViewEditBlock managerSettingViewEditBlock;
@property (nonatomic, copy) ManagerSettingViewSelectAddressBlock managerSettingViewSelectAddressBlock;
@property (nonatomic, copy) ManagerSettingViewEnterKeyBlock managerSettingViewEnterKeyBlock;

@end

NS_ASSUME_NONNULL_END
