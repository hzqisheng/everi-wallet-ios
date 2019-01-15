//
//  UIView+HUD.m
//  Category整理
//
//  Created by 孙俊 on 2018/5/10.
//  Copyright © 2018年 Sun. All rights reserved.
//

#import "UIView+HUD.h"
#import <objc/runtime.h>
#import <MBProgressHUD.h>

static char SJ_HUDKey;

@implementation UIView (HUD)

- (void)setMBHUD:(MBProgressHUD *)MBHUD {
    objc_setAssociatedObject(self, &SJ_HUDKey, MBHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)MBHUD {
    return objc_getAssociatedObject(self, &SJ_HUDKey);
}

- (void)showAutoHideHudWithText:(NSString *)text {
    if (self.MBHUD) {
        [self hideHud];
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15];
    hud.opacity = 0.8;
    hud.margin = 12.0;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    self.MBHUD = hud;
}

- (void)showIndeterminateHudWithText:(NSString *)text {
    if (self.MBHUD) {
        [self hideHud];
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15];
    hud.opacity = 0.8;
    hud.margin = 12.0;
    hud.removeFromSuperViewOnHide = YES;
    self.MBHUD = hud;
}

- (void)hideHud {
    [self.MBHUD hide:YES];
    self.MBHUD = nil;
}

@end
