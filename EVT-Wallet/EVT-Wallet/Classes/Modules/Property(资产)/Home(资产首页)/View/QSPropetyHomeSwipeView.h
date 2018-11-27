//
//  QSPropetyHomeSwipeView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSPropetyHomeSwipeView;

NS_ASSUME_NONNULL_BEGIN

@protocol QSSwipeDelegate <NSObject>

@required
//获取显示数据内容
- (UITableViewCell *)swipeView:(QSPropetyHomeSwipeView *)swipeView CellAtIndex:(NSInteger)index;
//获取数据源总量
- (NSInteger)numberOfCellInSwipeView:(QSPropetyHomeSwipeView *)swipeView;
//获取每个swipecell的大小
- (CGSize)sizeForPerCellInSwipeView:(QSPropetyHomeSwipeView *)swipeView;

@optional
//滑动到第几页
- (void)swipeView:(QSPropetyHomeSwipeView*)swipeView didSwipeToIndex:(NSInteger)index;

@end

@interface QSPropetyHomeSwipeView : UIView

/** delegate */
@property(nonatomic, weak) id<QSSwipeDelegate> delegate;

/** nowIndex */
@property(nonatomic, assign, readonly) NSInteger nowIndex;

/** isStack default NO */
@property(nonatomic,assign)BOOL isStackCard;

/** reloadData */
- (void)reloadData;

/** 根据id获取缓存的cell */
- (UITableViewCell *)dequeueReusableUIViewWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
