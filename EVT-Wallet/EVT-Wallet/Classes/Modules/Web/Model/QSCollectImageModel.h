//
//  QSCollectImageModel.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2019/3/6.
//  Copyright © 2019 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QSCollectImageModel : QSBaseModel

/*
 dataUrl = "data:image/png;base64,iVBOR";
 intervalId = 52;
 rawText = "https://evt.li/03$5CLY539EWWJV74-K2:W2-UNGY7JAJ8+8E4GHHFKZD53UUNZ7E-7LZWRPM+O0K232QSMEJ$N7A+JHO:LCD";
 timeConsumed = 31;
 }
 */
@property (nonatomic, copy) NSString *dataUrl;
@property (nonatomic, assign) NSInteger intervalId;
@property (nonatomic, copy) NSString *rawText;
@property (nonatomic, assign) NSInteger timeConsumed;

@end

NS_ASSUME_NONNULL_END
