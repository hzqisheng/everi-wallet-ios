//
//  QSScannerView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/7.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QSScannerView : UIView

/**
 *  default is NO
 */
@property (nonatomic, assign) BOOL hiddenScannerIndicator;

- (void)startScanner;

- (void)stopScanner;

@end

NS_ASSUME_NONNULL_END
