//
//  QSNavigationController.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/2/27.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSNavigationController.h"


@interface QSNavigationController ()

@end

@implementation QSNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage imageWithFrame:CGRectMake(0, 0, kScreenWidth, kNavgationBarHeight) color:[UIColor qs_colorBlack313745]] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = [UIImage new];
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor] ,NSFontAttributeName : [UIFont qs_fontOfSize18]}];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor whiteColor]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    FPSLabel *fps = [[FPSLabel alloc] initWithFrame:CGRectMake(10, 0, 50, 20)];
//    [self.navigationBar addSubview:fps];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        //设置白色返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_qianbao_nav_back"] target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}

@end
