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

        [self setTitle:QSLocalizedString(@"qs_refreshHeaderIdleText") forState:MJRefreshStateIdle];
        [self setTitle:QSLocalizedString(@"qs_refreshHeaderPullingText") forState:MJRefreshStatePulling];
        [self setTitle:QSLocalizedString(@"qs_refreshHeaderRefreshingText") forState:MJRefreshStateRefreshing];
        
        self.stateLabel.textColor = [UIColor blackColor];
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

@end
