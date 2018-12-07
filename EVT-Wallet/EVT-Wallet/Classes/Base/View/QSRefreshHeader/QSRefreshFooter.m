//
//  QSRefreshFooter.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/3/28.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSRefreshFooter.h"

@implementation QSRefreshFooter

- (instancetype)init {
    if (self = [super init]) {
        
        //        [self setImages:@[[UIImage imageNamed:@"load1"], [UIImage imageNamed:@"load2"], [UIImage imageNamed:@"load3"]]  forState:MJRefreshStateRefreshing];
        //        [self setImages:@[[UIImage imageNamed:@"load1"], [UIImage imageNamed:@"load2"], [UIImage imageNamed:@"load3"]]  forState:MJRefreshStatePulling];
        //        [self setImages:@[[UIImage imageNamed:@"load1"], [UIImage imageNamed:@"load2"], [UIImage imageNamed:@"load3"]]  forState:MJRefreshStateIdle];
        
//        [self setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
//        [self setTitle:@"已经拉到底啦~" forState:MJRefreshStateNoMoreData];

        self.stateLabel.textColor = [UIColor blackColor];
        self.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

@end
