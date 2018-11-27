//
//  UIViewController+Root.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UIViewController+Root.h"

@implementation UIViewController (Root)

+ (UIViewController *)sj_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self sj_topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self sj_topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIViewController *)currentViewController {
    
    UIViewController *resultVC;
    resultVC = [self sj_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self sj_topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

@end
