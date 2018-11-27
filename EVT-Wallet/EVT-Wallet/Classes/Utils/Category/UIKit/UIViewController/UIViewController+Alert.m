//
//  UIViewController+Alert.m
//  QSkindergarten
//
//  Created by SJ on 2018/5/15.
//  Copyright © 2018年 HANGZHOU QISHENG. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle {
    
    [self showAlertViewWithTitle:title message:message confirmTitle:confirmTitle confirmAction:nil];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmAction:(void(^)(void))confirmAction {
    
    [self showAlertViewWithTitle:title message:message confirmTitle:confirmTitle cancelTitle:nil confirmAction:confirmAction cancelAction:NULL];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirmAction:(void(^)(void))confirmAction cancelAction:(void(^)(void))cancelAction {
//
    UIViewController *vc = [UIViewController currentViewController];
    if ([vc isKindOfClass:[UIAlertController class]]) {
        [vc dismissViewControllerAnimated:NO completion:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            
            /*
             //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
             if (title.length) {
             NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:title];
             [AttributedStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, [[AttributedStr string] length])];
             [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[AttributedStr string] length])];
             [alertController setValue:AttributedStr forKey:@"attributedTitle"];
             }
             
             if (message.length) {
             //修改message
             NSMutableAttributedString *AttributedStrMsg = [[NSMutableAttributedString alloc] initWithString:message];
             //        [AttributedStrMsg addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, [[AttributedStrMsg string] length])];
             [AttributedStrMsg addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[AttributedStrMsg string] length])];
             [AttributedStrMsg addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[AttributedStrMsg string] length])];
             [alertController setValue:AttributedStrMsg forKey:@"attributedMessage"];
             }
             */
            /// 左边按钮
            if(cancelTitle.length > 0){
                UIAlertAction *cancel= [UIAlertAction actionWithTitle:cancelTitle?cancelTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !cancelAction?:cancelAction(); }];
                //[cancel setValue:[UIColor blackColor] forKey:@"titleTextColor"];
                [alertController addAction:cancel];
            }
            
            if (confirmTitle.length > 0) {
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !confirmAction?:confirmAction();}];
                //[confirm setValue:[UIColor blackColor] forKey:@"titleTextColor"];
                [alertController addAction:confirm];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:NULL];
            });
        }];
        return;
    }

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    /*
     //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
     if (title.length) {
     NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:title];
     [AttributedStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, [[AttributedStr string] length])];
     [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[AttributedStr string] length])];
     [alertController setValue:AttributedStr forKey:@"attributedTitle"];
     }
     
     if (message.length) {
     //修改message
     NSMutableAttributedString *AttributedStrMsg = [[NSMutableAttributedString alloc] initWithString:message];
     //        [AttributedStrMsg addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, [[AttributedStrMsg string] length])];
     [AttributedStrMsg addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [[AttributedStrMsg string] length])];
     [AttributedStrMsg addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[AttributedStrMsg string] length])];
     [alertController setValue:AttributedStrMsg forKey:@"attributedMessage"];
     }
     */
    /// 左边按钮
    if(cancelTitle.length > 0){
        UIAlertAction *cancel= [UIAlertAction actionWithTitle:cancelTitle?cancelTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !cancelAction?:cancelAction(); }];
        //[cancel setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertController addAction:cancel];
    }
    
    if (confirmTitle.length > 0) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle?confirmTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { !confirmAction?:confirmAction();}];
        //[confirm setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [alertController addAction:confirm];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIViewController currentViewController] presentViewController:alertController animated:YES completion:NULL];
    });
}

@end
