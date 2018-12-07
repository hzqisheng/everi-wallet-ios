//
//  QSScanerViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSScannerViewController.h"
#import "QSScannerView.h"
#import "QSScannerBackgroundView.h"
#import <AVFoundation/AVFoundation.h>

#define     SCREEN_SIZE                 [UIScreen mainScreen].bounds.size
#define     SCREEN_WIDTH                SCREEN_SIZE.width
#define     SCREEN_HEIGHT               SCREEN_SIZE.height

@interface QSScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) UILabel *introudctionLabel;
@property (nonatomic, strong) QSScannerView *scannerView;
@property (nonatomic, strong) QSScannerBackgroundView *scannerBGView;

@property (nonatomic, strong) AVCaptureSession *scannerSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation QSScannerViewController

+ (void)scannerQRCodeFromImage:(UIImage *)image ans:(void (^)(NSString *ansStr))ans
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imageData = (UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 1));
        CIImage *ciImage = [CIImage imageWithData:imageData];
        NSString  *ansStr = nil;
        if (ciImage) {
            CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:[CIContext contextWithOptions:nil] options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
            NSArray *features = [detector featuresInImage:ciImage];
            if (features.count) {
                for (CIFeature *feature in features) {
                    if ([feature isKindOfClass:[CIQRCodeFeature class]]) {
                        ansStr = ((CIQRCodeFeature *)feature).messageString;
                        break;
                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ans(ansStr);
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.scannerBGView];
    [self.view addSubview:self.introudctionLabel];
    [self.view addSubview:self.scannerView];
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];
    
    [self p_addMasonry];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.scannerSession) {
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewControllerInitSuccess:)]) {
            [_delegate scannerViewControllerInitSuccess:self];
        }
    }
    else {
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewController:initFailed:)]) {
            [_delegate scannerViewController:self initFailed:@"相机初始化失败"];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.scannerSession isRunning]) {
        [self stopCodeReading];
    }
}

#pragma mark - Public Methods -
- (void)setScannerType:(QSScannerType)scannerType
{
    if (_scannerType == scannerType) {
        return;
    }
    _scannerType = scannerType;
    
    CGFloat width = 0;
    CGFloat height = 0;
    if (scannerType == QSScannerTypeQR) {
        [self.introudctionLabel setText:QSLocalizedString(@"qs_scan_help_btn_title")];
//        [self.introudctionLabel setText:@"将二维码/条码放入框内，即可自动扫描"];
        width = height = SCREEN_WIDTH * 0.7;
    }
    else if (scannerType == QSScannerTypeCover) {
        [self.introudctionLabel setText:@"将书、CD、电影海报放入框内，即可自动扫描"];
        width = height = SCREEN_WIDTH * 0.85;
    }
    else if (scannerType == QSScannerTypeStreet) {
        [self.introudctionLabel setText:@"扫一下周围环境，寻找附近街景"];
        width = height = SCREEN_WIDTH * 0.85;
    }
    else if (scannerType == QSScannerTypeTranslate) {
        width = SCREEN_WIDTH * 0.7;
        height = 55;
        [self.introudctionLabel setText:@"将英文单词放入框内"];
    }
    [self.scannerView setHiddenScannerIndicator:scannerType == QSScannerTypeTranslate];
    [UIView animateWithDuration:0.3 animations:^{
        [self.scannerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        [self.view layoutIfNeeded];
    }];
    
    // rect值范围0-1，基准点在右上角
    CGRect rect = CGRectMake(self.scannerView.y / SCREEN_HEIGHT, self.scannerView.x / SCREEN_WIDTH, self.scannerView.height / SCREEN_HEIGHT, self.scannerView.width / SCREEN_WIDTH);
    [self.scannerSession.outputs[0] setRectOfInterest:rect];
    if (!self.isRunning) {
        [self startCodeReading];
    }
}

- (void)startCodeReading
{
    [self.scannerView startScanner];
    [self.scannerSession startRunning];
}

- (void)stopCodeReading
{
    [self.scannerView stopScanner];
    [self.scannerSession stopRunning];
}

- (BOOL)isRunning
{
    return [self.scannerSession isRunning];
}

#pragma mark - Events -
- (void)introudctionLabelTapped {
    if (_delegate && [_delegate respondsToSelector:@selector(scannerViewControllerClickedGetHelp:)]) {
        [_delegate scannerViewControllerClickedGetHelp:self];
    }
}

#pragma mark - Delegate -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [self stopCodeReading];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewController:scanAnswer:)]) {
            [_delegate scannerViewController:self scanAnswer:obj.stringValue];
        }
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.scannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(-55);
        make.width.and.height.mas_equalTo(0);
    }];
    
    [self.scannerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [_scannerBGView addMasonryWithContainView:self.scannerView];
    
    [self.introudctionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scannerView.mas_bottom).mas_offset(20);
    }];
}

#pragma mark - Getter -
- (AVCaptureSession *)scannerSession
{
    if (_scannerSession == nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {    // 没有摄像头
            return nil;
        }
        
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        if ([session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
            [session setSessionPreset:AVCaptureSessionPreset1920x1080];
        }
        else if ([session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
            [session setSessionPreset:AVCaptureSessionPreset1280x720];
        }
        else {
            [session setSessionPreset:AVCaptureSessionPresetPhoto];
        }
        
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
        
        _scannerSession = session;
    }
    return _scannerSession;
}

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer
{
    if (_videoPreviewLayer == nil) {
        _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.scannerSession];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [_videoPreviewLayer setFrame:self.view.layer.bounds];
    }
    return _videoPreviewLayer;
}

- (UILabel *)introudctionLabel
{
    if (_introudctionLabel == nil) {
        _introudctionLabel = [[UILabel alloc] init];
        [_introudctionLabel setBackgroundColor:[UIColor clearColor]];
        [_introudctionLabel setTextAlignment:NSTextAlignmentCenter];
        [_introudctionLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_introudctionLabel setTextColor:[UIColor whiteColor]];
        _introudctionLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(introudctionLabelTapped)];
        [_introudctionLabel addGestureRecognizer:tap];
    }
    return _introudctionLabel;
}

- (QSScannerView *)scannerView
{
    if (_scannerView == nil) {
        _scannerView = [[QSScannerView alloc] init];
    }
    return _scannerView;
}

- (QSScannerBackgroundView *)scannerBGView
{
    if (_scannerBGView == nil) {
        _scannerBGView = [[QSScannerBackgroundView alloc] init];
    }
    return _scannerBGView;
}

@end
