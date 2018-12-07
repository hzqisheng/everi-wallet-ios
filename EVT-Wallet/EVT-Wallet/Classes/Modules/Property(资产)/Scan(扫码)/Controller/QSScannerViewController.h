//
//  QSScanerViewController.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseViewController.h"
@class QSScannerViewController;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QSScannerType) {
    QSScannerTypeQR = 1,
    QSScannerTypeCover,
    QSScannerTypeStreet,
    QSScannerTypeTranslate,
};


@protocol QSScannerDelegate <NSObject>
@optional
- (void)scannerViewControllerInitSuccess:(QSScannerViewController *)scannerVC;

- (void)scannerViewController:(QSScannerViewController *)scannerVC
                   initFailed:(NSString *)errorString;


- (void)scannerViewController:(QSScannerViewController *)scannerVC
                   scanAnswer:(NSString *)ansStr;

- (void)scannerViewControllerClickedGetHelp:(QSScannerViewController *)scannerVC;
@end

@interface QSScannerViewController : QSBaseViewController

@property (nonatomic, assign) QSScannerType scannerType;

@property (nonatomic, assign) id<QSScannerDelegate>delegate;

@property (nonatomic, assign, readonly) BOOL isRunning;

- (void)startCodeReading;

- (void)stopCodeReading;

+ (void)scannerQRCodeFromImage:(UIImage *)image ans:(void (^)(NSString *ansStr))ans;


@end

NS_ASSUME_NONNULL_END
