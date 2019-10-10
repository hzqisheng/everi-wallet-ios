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
#import "QSScanUnrecognizedResultViewController.h"

#import "QSScanAddress.h"
#import <TZImagePickerController.h>
@interface QSScanningViewController ()<QSScannerDelegate,UINavigationControllerDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, strong) QSScannerViewController *scanVC;
//@property (nonatomic, strong) UIButton *helpButton;


@end

@implementation QSScanningViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self setupNavgationBarTitle:QSLocalizedString(@"qs_scan_nav_title")];
    UIBarButtonItem *albumItem = [[UIBarButtonItem alloc]initWithTitle:QSLocalizedString(@"qs_scan_album") style:UIBarButtonItemStyleDone target:self action:@selector(openAlbum:)];
    self.navigationItem.rightBarButtonItem = albumItem;
    [self.view addSubview:self.scanVC.view];
    [self addChildViewController:self.scanVC];
}

#pragma mark - Event Response -
- (void)helpButtonClickedDown {
    
}

#pragma mark - 打开相册
- (void)openAlbum:(UIBarButtonItem *)sender{
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePicker.allowPickingVideo = NO;
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - Private Methods -
- (void)p_analysisQRAnswer:(NSString *)ansStr {
    NSLog(@"address:%@",ansStr);
    WeakSelf(weakSelf);
    if (self.parseEvtLinkAndPopBlock) {
        //需要读取publickey的扫码
        [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag, NSArray * _Nonnull publicKeys) {
            
            if (statusCode != kResponseSuccessCode) {
                [weakSelf p_handleUnrecognizedResult:ansStr];
                return;
            }
            
            if (publicKeys.count) {
                if (weakSelf.parseEvtLinkAndPopBlock) {
                    weakSelf.parseEvtLinkAndPopBlock(publicKeys[0]);
                }
                [self.navigationController popViewControllerAnimated:YES];
            } else if (modelList.count && flag != 3) {
                for (QSScanAddress *scanModel in modelList) {
                    if (scanModel.typeKey == 95) {
                        if (weakSelf.parseEvtLinkAndPopBlock) {
                            weakSelf.parseEvtLinkAndPopBlock(scanModel.value);
                        }
                        [self.navigationController popViewControllerAnimated:YES];
                        break;
                    }
                }
            } else {
                [weakSelf.scanVC startCodeReading];
            }
        }];
    } else {
        //正常扫码操作
        [[QSEveriApiWebViewController sharedWebView] parseEvtLinkWithAddress:ansStr AndCompeleteBlock:^(NSInteger statusCode, NSArray * _Nonnull modelList, NSInteger flag, NSArray * _Nonnull publicKeys) {
            
            if (statusCode != kResponseSuccessCode) {
                [weakSelf p_handleUnrecognizedResult:ansStr];
                return;
            }
            
            /*
             v2.1.3 扫码收款和扫码付款不做扫码限制
            //扫码收款需要扫描付款码
            if (weakSelf.scanningType == QSScanningTypeCollect
                && flag != 5) {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_scan_scan_collect_failed_title")];
                [weakSelf.scanVC startCodeReading];
                return;
            }
            
            //扫码付款需要扫描收款码
            if (weakSelf.scanningType == QSScanningTypePay
                && flag != 17) {
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_scan_scan_everiPay_failed_title")];
                [weakSelf.scanVC startCodeReading];
                return;
            }
            */
            
            if (flag == 5) {
                //everiPay的二维码
                if (modelList.count > 0) {
                    QSEveriPayCollectAmountViewController *shoukuanVC = [[QSEveriPayCollectAmountViewController alloc] init];
                    shoukuanVC.link = ansStr;
                    for (QSScanAddress *scanModel in modelList) {
                        if (scanModel.typeKey == 43) {
                            shoukuanVC.maxMoney = scanModel.value;
                        }
                        if (scanModel.typeKey == 44) {
                            shoukuanVC.sybId = scanModel.value;
                        }
                    }
                    shoukuanVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf pushRemoveSelfToViewController:shoukuanVC animated:YES];
                }
            } else if (flag == 17) {
                //payees QR Code
                //modelList 没有fungibleID的话1个，有fungibleID没有amount2个，都有3个
                if (modelList.count) {
                    //type key 45:fungibleID
                    //95:publicKey
                    NSString *publicKey;
                    NSString *fungibleID;
                    NSString *amount;
                    
                    for (QSScanAddress *scanAddress in modelList) {
                        if (scanAddress.typeKey == 45) {
                            fungibleID = scanAddress.value;
                        } else if (scanAddress.typeKey == 95) {
                            publicKey = scanAddress.value;
                        } else if (scanAddress.typeKey == 96) {
                            amount = scanAddress.value;
                        }
                    }
                    
                    QSPayAmountViewController *payAmount = [[QSPayAmountViewController alloc] init];
                    payAmount.address = publicKey;
                    payAmount.fungibleID = fungibleID;
                    payAmount.amount = amount;
                    payAmount.hidesBottomBarWhenPushed = YES;
                    [weakSelf pushRemoveSelfToViewController:payAmount animated:YES];
                }
            } else if (flag == 3) {
                //everiPass
                [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_everipass_scan_success")];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            } else {
                [weakSelf.scanVC startCodeReading];
            }
        }];
    }
}

- (void)p_handleUnrecognizedResult:(NSString *)ansStr {
    QSScanUnrecognizedResultViewController *unrecognizedResult = [[QSScanUnrecognizedResultViewController alloc] init];
    unrecognizedResult.analysisQRString = ansStr;
    [self pushRemoveSelfToViewController:unrecognizedResult animated:YES];
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
    [UIViewController showAlertViewWithTitle:QSLocalizedString(@"qs_scan_scan_init_failed_title") message:nil confirmTitle:QSLocalizedString(@"qs_scan_scan_failed_confirm_title")];
}

- (void)scannerViewController:(QSScannerViewController *)scannerVC scanAnswer:(NSString *)ansStr {
    [self p_analysisQRAnswer:ansStr];
}

- (void)scannerViewControllerClickedGetHelp:(QSScannerViewController *)scannerVC {
    DLog(@"help");
}

#pragma mark - TZImagePickerDelegete

-(void)imagePickerController:(TZImagePickerController *)picker
      didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                sourceAssets:(NSArray *)assets
       isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    UIImage *selectImage = photos.firstObject;
    [self p_analysisImage:selectImage];
}


#pragma mark - **************** setter
- (QSScannerViewController *)scanVC {
    if (_scanVC == nil) {
        _scanVC = [[QSScannerViewController alloc] init];
        [_scanVC setDelegate:self];
    }
    return _scanVC;
}

@end
