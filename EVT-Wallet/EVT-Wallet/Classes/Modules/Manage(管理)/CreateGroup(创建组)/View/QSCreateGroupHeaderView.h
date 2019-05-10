//
//  QSCreateGroupHeaderView.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/7.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddNodeClickBlock)(void);

@interface QSCreateGroupHeaderView : UIView

@property (nonatomic, copy) AddNodeClickBlock addNodeClickBlock;

@property (nonatomic, readonly, copy) NSString *threshold;
@property (nonatomic, readonly, copy) NSString *groupName;

- (void)setupDefalutGroupName:(NSString *)groupName
                    threshold:(NSString *)threshold;

@end

NS_ASSUME_NONNULL_END
