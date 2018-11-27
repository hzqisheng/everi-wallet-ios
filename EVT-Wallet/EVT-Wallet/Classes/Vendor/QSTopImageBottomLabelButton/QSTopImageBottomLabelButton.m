//
//  QSTopImageBottomLabelButton.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSTopImageBottomLabelButton.h"

@implementation QSTopImageBottomLabelButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    
    imageF.origin.x = CGRectGetWidth(self.frame)/2 - imageF.size.width/2;
    imageF.origin.y = CGRectGetHeight(self.frame)/2 - imageF.size.height + 6;
    self.imageView.frame = imageF;
    
    titleF.origin.x = CGRectGetWidth(self.frame)/2 - titleF.size.width/2;
    titleF.origin.y = CGRectGetMaxY(self.imageView.frame) + 6;
    self.titleLabel.frame = titleF;
}

@end
