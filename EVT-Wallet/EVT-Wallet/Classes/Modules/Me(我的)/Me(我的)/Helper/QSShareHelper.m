//
//  QSShareHelper.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/30.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSShareHelper.h"

@implementation QSShareHelper

+ (instancetype)sharedHelper {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)shareURL:(NSString *)urlString {
    if (!urlString.length) {
        return;
    }
    NSString *textToShare = kShareTitle;
    UIImage *imageToShare = [UIImage imageNamed:kShareLogo];
    NSURL *urlToShare = [NSURL URLWithString:kShareUrlString];
    NSArray *activityItems = @[urlToShare,textToShare,imageToShare];
    
    UIActivityViewController * activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.modalInPopover = YES;
    
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // ios8.0 later
        UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            NSLog(@"activityType == %@",activityType);
            if (completed == YES) {
                NSLog(@"completed");
            }else{
                NSLog(@"cancel");
            }
        };
        activityVC.completionWithItemsHandler = itemsBlock;
//    } else {
//        // ios8.0 before
//        UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
//            NSLog(@"activityType == %@",activityType);
//            if (completed == YES) {
//                NSLog(@"completed");
//            }else{
//                NSLog(@"cancel");
//            }
//        };
//        activityVC.completionHandler = handlerBlock;
//    }
    
    [QSAppKeyWindow.rootViewController presentViewController:activityVC animated:YES completion:nil];
}

@end
