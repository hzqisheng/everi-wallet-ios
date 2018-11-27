//
//  QSRefreshHeader.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/3/1.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSRefreshHeader.h"

@implementation QSRefreshHeader

-(instancetype)init
{
    if (self = [super init]) {
        
        //        [self setImages:@[[UIImage imageNamed:@"load1"], [UIImage imageNamed:@"load2"], [UIImage imageNamed:@"load3"]]  forState:MJRefreshStateRefreshing];
        //        [self setImages:@[[UIImage imageNamed:@"load1"], [UIImage imageNamed:@"load2"], [UIImage imageNamed:@"load3"]]  forState:MJRefreshStatePulling];
        //        [self setImages:@[[UIImage imageNamed:@"load1"], [UIImage imageNamed:@"load2"], [UIImage imageNamed:@"load3"]]  forState:MJRefreshStateIdle];
        
        [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"释放更新" forState:MJRefreshStatePulling];
        [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        
        self.stateLabel.textColor = [UIColor blackColor];
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

@end
