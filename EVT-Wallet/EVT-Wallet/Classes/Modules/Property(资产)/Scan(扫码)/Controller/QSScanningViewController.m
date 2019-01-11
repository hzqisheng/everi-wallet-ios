//
//  QSScanningViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSScanningViewController.h"
#import "QSScannerViewController.h"
#import "QSPayAmountViewController.h"
#import "QSEveriPayCollectAmountViewController.h"
#import "QSScanAddress.h"

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
    [self.scanVC startCodeReading];
    //首页扫码
    if (self.scanningViewControllerHomeScan) {
        [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag) {
            if (flag == 5) {
                QSEveriPayCollectAmountViewController *shoukuanVC = [[QSEveriPayCollectAmountViewController alloc] init];
                shoukuanVC.link = ansStr;
                //Parse it
                WeakSelf(weakSelf);
                [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag) {
                    if (modelList.count > 0) {
                        for (QSScanAddress *scanModel in modelList) {
                            if (scanModel.typeKey == 43) {
                                shoukuanVC.maxMoney = scanModel.value;
                            }
                            if (scanModel.typeKey == 44) {
                                shoukuanVC.sybId = scanModel.value;
                            }
                        }
                        //Parse it and pass it on
                        [weakSelf.navigationController pushViewController:shoukuanVC animated:YES];
                        
                    } else {
                        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_scan_failure")];
                    }
                }];
            } else if (flag == 17) {
                QSPayAmountViewController *payAmount = [[QSPayAmountViewController alloc] init];
                //Parse it
                WeakSelf(weakSelf);
                [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag) {
                    //Parse it and pass it on
                    if (modelList.count > 0) {
                        QSScanAddress *addressModel = modelList[0];
                        payAmount.address = addressModel.value;
                        [weakSelf.navigationController pushViewController:payAmount animated:YES];
                    }
                }];
            } else if (flag == 3) {
                //everiPay
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_everipass_scan_success")];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
    if (self.scanningViewControllerSweepBlock) {
        WeakSelf(weakSelf);
        [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag) {
            if (statusCode == kResponseSuccessCode) {
                //Parse it and pass it on
                if (modelList.count > 0) {
                    QSScanAddress *addressModel = modelList[0];
                    weakSelf.scanningViewControllerSweepBlock(addressModel.value);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_scanAddress_failure")];
                }
            }
        }];
    }
    if (self.scanningViewControllerPayBySweepBlock) {
        QSPayAmountViewController *payAmount = [[QSPayAmountViewController alloc] init];
        //Parse it
        WeakSelf(weakSelf);
        [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag) {
            //Parse it and pass it on
            if (modelList.count > 0) {
                QSScanAddress *addressModel = modelList[0];
                payAmount.address = addressModel.value;
                [weakSelf.navigationController pushViewController:payAmount animated:YES];
            }
        }];
    }
    if (self.scanningViewControllerScanAddressBlock) {
        WeakSelf(weakSelf);
        [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag) {
            if (modelList.count > 0) {
                QSScanAddress *addressModel = modelList[0];
                [weakSelf popToEveriPayVCWithAddress:addressModel.value];
            }
        }];
    }
    if (self.scanningViewControllerScanFukuanBlock) {
        QSEveriPayCollectAmountViewController *shoukuanVC = [[QSEveriPayCollectAmountViewController alloc] init];
        shoukuanVC.link = ansStr;
        //Parse it
        WeakSelf(weakSelf);
        [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag) {
            if (modelList.count > 0) {
                for (QSScanAddress *scanModel in modelList) {
                    if (scanModel.typeKey == 43) {
                        shoukuanVC.maxMoney = scanModel.value;
                    }
                    if (scanModel.typeKey == 44) {
                        shoukuanVC.sybId = scanModel.value;
                    }
                }
                //Parse it and pass it on
                [weakSelf.navigationController pushViewController:shoukuanVC animated:YES];
                
            } else {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_alert_scan_failure")];
            }
        }];
    }
}

- (void)popToEveriPayVCWithAddress:(NSString *)address {
    self.scanningViewControllerScanAddressBlock(address);
    [self.navigationController popViewControllerAnimated:YES];
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
