//
//  QSMainViewController.m
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/2/27.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import "QSMainViewController.h"
#import "QSCreateIdentityHomeViewController.h"
#import "QSTabBar.h"
#import "QSMyWalletViewController.h"
#import "QSManageAddressViewController.h"

@interface QSMainViewController ()<UITabBarControllerDelegate,QSTabBarDelegate>

@end

@implementation QSMainViewController

+ (void)initialize {
    UITabBarItem *appearance = [UITabBarItem appearance];

    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateNormal];

    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#E4B84F"];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [appearance setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QSTabBar * tabbar = [[QSTabBar alloc] init];
    tabbar.qsDelegate = self;
    self.delegate = self;
    [tabbar setBackgroundImage:[UIImage imageWithFrame:CGRectMake(0, 0, kScreenWidth, kTabBarHeight) color:[UIColor qs_colorBlack313745]]];
    //注意：因为是系统的tabBar是readonly的，所以用KVC方法替换
    [self setValue:tabbar forKey:@"tabBar"];

    [self setupChildViewControllers];
}

- (void)setupChildViewControllers {
    [self addChileVcWithTitle:QSLocalizedString(@"qs_tabbar_property") vc:[NSClassFromString(@"QSHomePropertyViewController") new] imageName:@"icon_home_tabbar_zichan_unselected" selImageName:@"icon_home_tabbar_zichan_selected"];
    
    [self addChileVcWithTitle:QSLocalizedString(@"qs_btn_home_address") vc:[NSClassFromString(@"QSManageAddressViewController") new] imageName:@"icon_home_tabbar_shichang_unselected" selImageName:@"icon_home_tabbar_shichang_selected"];
    
    [self addChileVcWithTitle:QSLocalizedString(@"qs_tabbar_manage") vc:[NSClassFromString(@"QSManageViewController") new] imageName:@"icon_home_tabbar_guanli_unselected" selImageName:@"icon_home_tabbar_guanli_selected"];

    [self addChileVcWithTitle:QSLocalizedString(@"qs_tabbar_me") vc:[NSClassFromString(@"QSMineViewController") new] imageName:@"icon_home_tabbar_wode_unselected" selImageName:@"icon_home_tabbar_wode_selected"];
}

- (void)addChileVcWithTitle:(NSString *)title vc:(UIViewController *)vc imageName:(NSString *)imageName selImageName:(NSString *)selImageName {
    [vc.tabBarItem setTitle:title];
    if (imageName && selImageName) {
        [vc.tabBarItem setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    [self addChildViewController:[[RTRootNavigationController alloc] initWithRootViewController:vc]];
}

#pragma mark - **************** QSTabBarDelegate
- (void)qsTabbarDidClickedCenterButton:(QSTabBar *)tabBar {
    QSMyWalletViewController *vc = [[QSMyWalletViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [[UIViewController currentViewController].navigationController pushViewController:vc animated:YES];
}

@end
