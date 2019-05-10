//
//  QSGroupDetailGroupNameView.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/10.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSGroupDetailGroupNameView : UIView

- (void)configureViewByGroupName:(NSString *)groupName
                       threshold:(NSString *)threshold;

@end

NS_ASSUME_NONNULL_END
