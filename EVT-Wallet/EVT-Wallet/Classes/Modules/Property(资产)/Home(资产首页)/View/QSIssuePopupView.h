//
//  QSIssuePopupView.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/12/10.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, QSIssueType) {
    QSIssueTypeFTS,
    QSIssueTypeNFTS,
};

typedef void(^IssueClickedBlock)(QSIssueType type);

@interface QSIssuePopupView : UIView

+ (void)showIssuePopupViewAndIssueClickedBlock:(IssueClickedBlock)issueClickedBlock;

@end

NS_ASSUME_NONNULL_END
