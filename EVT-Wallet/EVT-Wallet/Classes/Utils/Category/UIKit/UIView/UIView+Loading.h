//
//  UIView+Loading.h
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/3/26.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSCategoryLoadingView;

@interface UIView (Loading)

@property (nonatomic,strong) QSCategoryLoadingView *loadingView;

- (void)showLoadingView:(BOOL)isLoading;

@end


@interface QSCategoryLoadingView : UIView

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
