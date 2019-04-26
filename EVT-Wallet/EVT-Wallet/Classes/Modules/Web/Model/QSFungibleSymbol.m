//
//  QSFungibleSymbol.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/9.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSFungibleSymbol.h"

@interface QSFungibleSymbol ()

@property (nonatomic, copy) NSString *assetIcon;

@end

@implementation QSFungibleSymbol

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"metas": @"QSMetas"
             };
}

- (NSString *)assetIcon {
    if (!_assetIcon) {
        for (QSMetas *metas in self.metas) {
            if ([metas.key isEqualToString:@"symbol-icon"]) {
                _assetIcon = metas.value;
            }
        }
    }
    return _assetIcon;
}

- (UIImage *)assetImage {
    if (!_assetImage) {
        if (self.assetIcon.length) {
            NSArray *base64List = [self.assetIcon componentsSeparatedByString:@"data:image/jpeg;base64,"];
            if (base64List.count < 2) {
                base64List = [self.assetIcon componentsSeparatedByString:@"data:image/png;base64,"];
            }
            if (base64List.count == 2) {
                NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:base64List[1] options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
                // 将NSData转为UIImage
                UIImage *decodedImage = [UIImage imageWithData: decodeData];
                _assetImage = decodedImage;
            }
        }
    }
    return _assetImage;
}

@end
