//
//  QSLunchImageViewController.m
//  EVT-Wallet
//
//  Created by jxsoft on 2018/12/21.
//  Copyright © 2018年 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSLunchImageViewController.h"

@interface QSLunchImageViewController ()

@end

@implementation QSLunchImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *lunchImageView = [[UIImageView alloc] initWithFrame:kScreenBounds];
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = @"icon_launch_image_defalut";
    
    NSArray *launchImages =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    lunchImageView.image = [UIImage imageNamed:launchImage];
    [self.view addSubview:lunchImageView];
}

@end
