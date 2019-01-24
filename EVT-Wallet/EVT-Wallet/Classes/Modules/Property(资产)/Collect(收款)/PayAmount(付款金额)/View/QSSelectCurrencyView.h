//
//  QSSelectCurrencyView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/6.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSFT.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectCurrencyViewSelectFTBlock)(QSFT *FTModel);

@interface QSSelectCurrencyView : UIView

+ (void)showSelectCurrencyView;

@property (nonatomic, copy) SelectCurrencyViewSelectFTBlock selectCurrencyViewSelectFTBlock;

@property (nonatomic, strong) NSArray *dataList;

+ (void)showSelectCurrencyViewWithFTList:(NSArray *)FTList
                          seletedSymName:(NSString *)seletedSymName
                        andSelectFTBlock:(void(^)(QSFT *FTModel))block;

@end

NS_ASSUME_NONNULL_END
