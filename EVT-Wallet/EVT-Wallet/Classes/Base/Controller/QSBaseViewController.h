//
//  QSBaseViewController.h
//  QSSmarkPark-iOS
//
//  Created by 孙俊 on 2018/2/27.
//  Copyright © 2018年 QiSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSBaseViewController : UIViewController

/** setNavigationBar title */
- (void)setupNavgationBarTitle:(NSString *)title;

/** push remove self */
- (void)pushRemoveSelfToViewController:(UIViewController *)viewController
                              animated:(BOOL)animated;

@end
