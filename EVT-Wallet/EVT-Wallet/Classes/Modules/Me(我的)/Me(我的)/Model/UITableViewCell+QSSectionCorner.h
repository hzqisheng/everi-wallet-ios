//
//  UITableViewCell+QSSectionCorner.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/27.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (QSSectionCorner)

- (void)addSectionCornerWithTableView:(UITableView *)tableView
                           indexPath:(NSIndexPath *)indexPath
                     cornerViewframe:(CGRect)frame
                        cornerRadius:(CGFloat)cornerRadius;

@property (nonatomic, strong) UIView *cornerV;
@property (nonatomic, strong) CAShapeLayer *cornerLay;
@property (nonatomic, strong) CAShapeLayer *topLay;
@property (nonatomic, strong) CAShapeLayer *bottomLay;

@end

NS_ASSUME_NONNULL_END
