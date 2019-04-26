//
//  QSFT.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/16.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSFT.h"

@interface QSFT ()

@property (nonatomic, copy) NSString *assetIcon;

@end

@implementation QSFT

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"metas": @"QSMetas"
             };
}

- (NSString *)fungibleId {
    if (self.asset.length) {
        //4745.30 S#655320035
        NSArray *assetList = [self.asset componentsSeparatedByString:@"#"];
        if (assetList.count == 2) {
            return assetList[1];
        }
    }
    return nil;
}

- (NSString *)assetIcon {
    if (!_assetIcon) {
        for (QSMetas *metas in self.metas) {
            if ([metas.key isEqualToString:@"symbol-icon"]
                || [metas.key isEqualToString:@"icon"]) {
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
