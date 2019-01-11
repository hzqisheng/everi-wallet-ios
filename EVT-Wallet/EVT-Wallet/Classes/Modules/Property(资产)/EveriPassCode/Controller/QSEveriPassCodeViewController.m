//
//  QSEveriPassCodeViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/1/11.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSEveriPassCodeViewController.h"

@interface QSEveriPassCodeViewController ()

@property (nonatomic, strong) UIImageView *qrcodeImageView;

@end

@implementation QSEveriPassCodeViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[QSEveriApiWebViewController sharedWebView] stopEVTLinkQrImageReload];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavgationBarTitle:QSLocalizedString(@"qs_everipass_nav_title")];
    [self setupSubViews];
    [self requestData];
}

- (void)setupSubViews {
    UIView *QRCodeView = [[UIView alloc] init];
    QRCodeView.layer.cornerRadius = 8;
    QRCodeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:QRCodeView];
    [QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRealValue(15));
        make.left.equalTo(self.view).offset(kRealValue(15));
        make.right.equalTo(self.view).offset(-kRealValue(15));
        make.height.equalTo(@kRealValue(368));
    }];
    
    NSString *name = [NSString stringWithFormat:@"%@:%@",QSLocalizedString(@"qs_everipass_name_title"),self.everiPassModel.name];
    UILabel *nameLabel = [UILabel labelWithName:name font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [QRCodeView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QRCodeView).offset(kRealValue(22));
        make.left.equalTo(QRCodeView).offset(kRealValue(22));
        make.right.mas_equalTo(QRCodeView.mas_centerX);
    }];
    
    NSString *domainName = [NSString stringWithFormat:@"%@:%@",QSLocalizedString(@"qs_everipass_domain_title"),self.everiPassModel.domain];
    UILabel *domainLabel = [UILabel labelWithName:domainName font:[UIFont qs_fontOfSize15] textColor:[UIColor qs_colorBlack333333] textAlignment:NSTextAlignmentLeft];
    [QRCodeView addSubview:domainLabel];
    [domainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(QRCodeView).offset(kRealValue(22));
        make.right.equalTo(QRCodeView).offset(-kRealValue(22));
        make.left.mas_equalTo(QRCodeView.mas_centerX).offset(kRealValue(5));
    }];
    
    UIView *sepLine = [[UIView alloc] init];
    sepLine.backgroundColor = [UIColor qs_colorGrayCCCCCC];
    [QRCodeView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(kRealValue(22));
        make.left.and.right.equalTo(QRCodeView);
        make.height.equalTo(@BORDER_WIDTH_1PX);
    }];
    
    UIImageView *qrcodeImageView = [[UIImageView alloc] init];
    [QRCodeView addSubview:qrcodeImageView];
    [qrcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sepLine.mas_bottom).offset(kRealValue(18));
        make.centerX.equalTo(QRCodeView);
        make.width.and.height.equalTo(@kRealValue(245));
    }];
    _qrcodeImageView = qrcodeImageView;
    
    UILabel *tipsLabel = [UILabel labelWithName:QSLocalizedString(@"qs_everipass_refesh_tips_title") font:[UIFont qs_fontOfSize14] textColor:[UIColor qs_colorGray686868] textAlignment:NSTextAlignmentCenter];
    tipsLabel.numberOfLines = 2;
    [QRCodeView addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qrcodeImageView.mas_bottom).offset(kRealValue(3));
        make.right.equalTo(QRCodeView).offset(-kRealValue(22));
        make.left.equalTo(QRCodeView).offset(kRealValue(22));
    }];
}

- (void)requestData {
    [[QSEveriApiWebViewController sharedWebView] getEveriPassQrImageWithDomain:self.everiPassModel.domain name:self.everiPassModel.name andCompeleteBlock:^(NSInteger statusCode, NSString * _Nonnull addressCodeString) {
        if (statusCode == kResponseSuccessCode) {
            NSData * imageData =[[NSData alloc] initWithBase64EncodedString:addressCodeString options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *photo = [UIImage imageWithData:imageData];
            self.qrcodeImageView.image = photo;
        }
    }];
}

@end
