//
//  QSPropetyHomeSegmentView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSPropetyHomeSegmentView;

NS_ASSUME_NONNULL_BEGIN

@protocol QSPropetyHomeSegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(QSPropetyHomeSegmentView *)segmentView didClickedAtIndex:(NSInteger)index;

@end

@interface QSPropetyHomeSegmentView : UIView

@property (nonatomic,weak) id<QSPropetyHomeSegmentViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
