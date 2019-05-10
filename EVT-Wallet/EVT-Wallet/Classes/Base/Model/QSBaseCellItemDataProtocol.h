//
//  QSBaseCellItemDataProtocol.h
//  EVT-Wallet
//
//  Created by SJ on 2019/5/7.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QSBaseCellItemDataProtocol <NSObject>

@required

/** cellIdentifier -> cellClassName */
@property (nonatomic, copy) NSString *cellIdentifier;

/** cellTag */
@property (nonatomic, assign) NSInteger cellTag;

/** itemHeight default:52 */
@property (nonatomic, assign) CGFloat cellHeight;

/** itemWidth default:screenW-30 */
@property (nonatomic, assign) CGFloat cellWidth;

/** seaprator inset default is UIEdgeInsetsMake(0, 0, 0, 0) */
@property (nonatomic, assign) UIEdgeInsets cellSeapratorInset;

@end

NS_ASSUME_NONNULL_END
