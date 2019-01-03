//
//  QSMarketViewController.m
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#import "QSMarketViewController.h"

@interface QSMarketViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation QSMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavgationBarTitle:@"市场"];
    [self.view addSubview:self.imageView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavgationBarHeight - kTabBarHeight)];
        if (kDevice_Is_iPhoneX) {
            [_imageView setImage:[UIImage imageNamed:@"5991545224647_.pic"]];
        } else {
            [_imageView setImage:[UIImage imageNamed:@"1831545137939.pic"]];
        }
            
    }
    return _imageView;
}
@end
