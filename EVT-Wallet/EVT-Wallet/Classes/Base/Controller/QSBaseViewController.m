//
//  QSBaseViewController.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/2/27.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSBaseViewController.h"

@interface QSBaseViewController ()

@end

@implementation QSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qs_colorWhiteF5F7FB];
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
    self.rt_disableInteractivePop = NO;
    
    DLog(@"%@",[self class]);
    self.navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)setupNavgationBarTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_qianbao_nav_back"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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

- (UIButton *)createBottomButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kRealValue(30), kBottomButtonWidth, kBottomButtonHeight)];
    [bottomButton setTitleColor:[UIColor qs_colorYellowE4B84F] forState:UIControlStateNormal];
    [bottomButton setTitle:title forState:UIControlStateNormal];
    bottomButton.backgroundColor = [UIColor qs_colorBlack313745];
    bottomButton.titleLabel.font = [UIFont qs_fontOfSize15];
    [bottomButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    bottomButton.layer.cornerRadius = 3;
    return bottomButton;
}

- (void)checkVersionIsShowLatestToast:(BOOL)isShowToast {
    [[QSEveriApiWebViewController sharedWebView] getAPPVersionAndCompeleteBlock:^(NSInteger statusCode, QSAppVersion * _Nonnull appVersion) {
        if (statusCode != kResponseSuccessCode) {
            return;
        }
        
        if ([appVersion.iOSVersion isEqualToString:kCurrentVersion]) {
            if (isShowToast) {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_lastet_version_toast")];
            }
            return;
        }
        
        NSString *title;
        NSString *confirmTitle;
        NSString *cancelTitle;
        if ([NSBundle isChineseLanguage]) {
            title = appVersion.iOSChUploadMessage;
            confirmTitle = @"前往下载";
            cancelTitle = @"取消";
            
        } else {
            title = appVersion.iOSEnUploadMessage;
            confirmTitle = @"update";
            cancelTitle = @"cancel";
        }
        
        //强制更新
        if (appVersion.isiOSForceUpdate) {
            [UIViewController showAlertViewWithTitle:title message:nil confirmTitle:confirmTitle confirmAction:^{
                if (appVersion.iOSUploadUrl) {
                    QSOpenURL(appVersion.iOSUploadUrl);
                }
            }];
            return;
        }
        
        //非强制更新
        [UIViewController showAlertViewWithTitle:title message:nil confirmTitle:confirmTitle cancelTitle:cancelTitle confirmAction:^{
            if (appVersion.iOSUploadUrl) {
                QSOpenURL(appVersion.iOSUploadUrl);
            }
        } cancelAction:^{}];
    }];
}

- (void)dealloc {
    DLog(@"%@ dealloc",[self class]);
}

@end
