//
//  QSScanningViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSScanningViewController.h"
#import "QSScannerViewController.h"

@interface QSScanningViewController ()<QSScannerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) QSScannerViewController *scanVC;
//@property (nonatomic, strong) UIButton *helpButton;

@end

@implementation QSScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_scan_nav_title")];
    [self.view addSubview:self.scanVC.view];
    [self addChildViewController:self.scanVC];
}

#pragma mark - Event Response -
- (void)helpButtonClickedDown {
    
}

#pragma mark - Private Methods -
- (void)p_analysisQRAnswer:(NSString *)ansStr {
    DLog(@"扫描结果:%@",ansStr);
}

- (void)p_analysisImage:(UIImage *)image {
    [QSAppKeyWindow showIndeterminateHudWithText:QSLocalizedString(@"qs_scan_scaning_title")];
    [QSScannerViewController scannerQRCodeFromImage:image ans:^(NSString *ansStr) {
        [QSAppKeyWindow hideHud];
        if (ansStr == nil) {
            [UIViewController showAlertViewWithTitle:QSLocalizedString(@"qs_scan_scan_failed_title") message:QSLocalizedString(@"qs_scan_scan_failed_tips_title") confirmTitle:QSLocalizedString(@"qs_scan_scan_failed_confirm_title") confirmAction:^{
                [self.scanVC startCodeReading];
            }];
        }
        else {
            [self p_analysisQRAnswer:ansStr];
        }
    }];
}

#pragma mark - QsScannerDelegate -
- (void)scannerViewControllerInitSuccess:(QSScannerViewController *)scannerVC {
    if (![self.scanVC isRunning]) {
        [self.scanVC startCodeReading];
    }
    [self.scanVC setScannerType:QSScannerTypeQR];
}

- (void)scannerViewController:(QSScannerViewController *)scannerVC initFailed:(NSString *)errorString {
    kTipAlert(QSLocalizedString(@"qs_scan_scan_init_failed_title"));
}

- (void)scannerViewController:(QSScannerViewController *)scannerVC scanAnswer:(NSString *)ansStr {
    [self p_analysisQRAnswer:ansStr];
}

- (void)scannerViewControllerClickedGetHelp:(QSScannerViewController *)scannerVC {
    DLog(@"help");
}

#pragma mark - **************** setter
- (QSScannerViewController *)scanVC
{
    if (_scanVC == nil) {
        _scanVC = [[QSScannerViewController alloc] init];
        [_scanVC setDelegate:self];
    }
    return _scanVC;
}

@end
