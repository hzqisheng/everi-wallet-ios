//
//  UITabBar+Badge.h
//  投融社
//
//  Created by 孙俊 on 2018/2/1.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

- (void)showBadgeOnItemIndex:(int)index badgeNumber:(NSInteger)number;

@end
