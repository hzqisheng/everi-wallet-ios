//
//  QSQRImageCodeCell.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/5.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSQRImageCodeCell.h"
#import "QSQRCodeScanItem.h"


@interface QSQRImageCodeCell ()

@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UIButton *pastButton;

@end

@implementation QSQRImageCodeCell

- (void)configureSubViews {
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.qrCodeImageView];
    [self.contentView addSubview:self.pastButton];
    
    [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRealValue(28));
        make.centerX.equalTo(self.contentView);
        make.width.and.height.equalTo(@kRealValue(225));
    }];
    
    [self.pastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeImageView.mas_bottom).offset(kRealValue(7));
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(@kRealValue(20));
        make.width.lessThanOrEqualTo(@kRealValue(250));
    }];
}

- (void)configureCellWithItem:(QSBaseCellItem *)item {
    self.item = item;
    QSQRCodeScanItem *scanItem = (QSQRCodeScanItem *)item;
    if (scanItem.qrcodeImageString.length) {
        //1. 实例化二维码滤镜
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        // 2. 恢复滤镜的默认属性
        [filter setDefaults];
        // 3. 将字符串转换成NSData
        NSString *urlStr = scanItem.qrcodeImageString;
        NSData *data = [urlStr dataUsingEncoding:NSUTF8StringEncoding];
        // 4. 通过KVO设置滤镜inputMessage数据
        [filter setValue:data forKey:@"inputMessage"];
        // 5. 获得滤镜输出的图像
        CIImage *outputImage = [filter outputImage];
        // 6. 将CIImage转换成UIImage，并显示于imageView上 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
        self.qrCodeImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:kRealValue(225)];//重绘二维码,使其显示清晰
        return;
    }
    if (scanItem.codeImage) {
        self.qrCodeImageView.image = scanItem.codeImage;
    }
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - **************** Event Response
- (void)pastButtonClicked {
    QSQRCodeScanItem *scanItem = (QSQRCodeScanItem *)self.item;
    if (scanItem.address.length) {
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:scanItem.address];
        [QSAppKeyWindow showAutoHideHudWithText:QSLocalizedString(@"qs_collect_btn_copy_success_title")];
    }
}

#pragma mark - **************** Setter Getter
- (UIImageView *)qrCodeImageView {
    if (!_qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc] init];
        _qrCodeImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pastButtonClicked)];
        [_qrCodeImageView addGestureRecognizer:tap];
    }
    return _qrCodeImageView;
}

- (UIButton *)pastButton {
    if (!_pastButton) {
        _pastButton = [UIButton buttonWithTitle:QSLocalizedString(@"qs_collect_btn_copy_address_title") titleColor:[UIColor qs_colorGrayBBBBBB] font:[UIFont qs_fontOfSize14] taget:self action:@selector(pastButtonClicked)];
    }
    return _pastButton;
}


@end
