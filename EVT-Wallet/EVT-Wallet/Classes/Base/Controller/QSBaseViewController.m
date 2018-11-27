//
//  QSBaseViewController.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/2/27.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSBaseViewController.h"
#import <RTRootNavigationController/RTRootNavigationController.h>

@interface QSBaseViewController ()

@end

@implementation QSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UICollectionView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //setup NavigationBar
//    UINavigationBar *bar = [UINavigationBar appearance];
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:[UIImage imageWithFrame:CGRectMake(0, 0, kScreenWidth, kNavgationBarHeight) color:[UIColor qs_colorBlack313745]] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = [UIImage new];
//    bar.barTintColor = [UIColor colorNavigationBar];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor] ,NSFontAttributeName : [UIFont qs_fontOfSize18]}];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTintColor:[UIColor whiteColor]];
    self.rt_navigationController.rt_disableInteractivePop = NO;
}

- (void)setupNavgationBarTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"left"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target
            action:action
  forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)pushRemoveSelfToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.rt_navigationController pushViewController:viewController
                                            animated:YES
                                            complete:^(BOOL finished) {
                                                [self.rt_navigationController removeViewController:self];
                                            }];
}

- (void)dealloc {
    DLog(@"%@ dealloc",[self class]);
}

@end
