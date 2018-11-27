//
//  UtilsMacro.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/23.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

//-------------------打印日志-------------------------//
#ifdef DEBUG
//API的log
#define APILOG(format, ...) NSLog(format,##__VA_ARGS__)
//打印日志
#define DLog(format, ...) NSLog(format,##__VA_ARGS__)
//打印日志,输出当前行并弹出一个警告
#define ALog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
//打印日志,输出当前行
#define DMLog(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//打印日志和当前行数
//#define NSLog(format, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);

#else

#define DLog(format, ...)
#define ALog(...)
#define DMLog(...)
#define APILOG(...)

#endif

//获取系统对象
#define QSApplication                    [UIApplication sharedApplication]
#define QSAppWindow                      [UIApplication sharedApplication].delegate.window
#define QSAppKeyWindow                   [UIApplication sharedApplication].keyWindow
#define QSAppDelegate                    [AppDelegate shareAppDelegate]
#define QSRootViewController             [UIApplication sharedApplication].delegate.window.rootViewController
#define QSUserDefaults                   [NSUserDefaults standardUserDefaults]
#define QSNotificationCenter             [NSNotificationCenter defaultCenter]

//获取屏幕相关属性
#define kTabBarHeight                   (kDevice_Is_iPhoneX ? 83 : 49)
#define kStatusBarHeight                ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define kNavgationBarHeight             (44 + kStatusBarHeight)
#define kScreenWidth                    ([[UIScreen mainScreen]bounds].size.width)
#define kScreenHeight                   ([[UIScreen mainScreen]bounds].size.height)
#define kScreenBounds                   [UIScreen mainScreen].bounds
#define Iphone6ScaleWidth               kScreenWidth/375.0
#define Iphone6ScaleHeight              kScreenHeight/667.0

//1PX的边框
#define   BORDER_WIDTH_1PX              ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)
//iPhone X底部留出的距离
#define kiPhoneXSafeAreaBottomMagin    (kDevice_Is_iPhoneX ? 43 : 0)
//iPhone X tabbar多的距离
#define kiPhoneXTabBarExtraHeight      (kDevice_Is_iPhoneX ? 34.0 : 0)
//是否是iPhoneX系列
#define kDevice_Is_iPhoneX  \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
//根据ip6的屏幕来拉伸
#define kRealValue(with)                ((with)*(kScreenWidth/375.0f))


//强弱引用
#define WeakSelf(weakSelf)                __weak __typeof(&*self) weakSelf = self
#define StrongSelf(strongSelf)           __strong __typeof(&*self) strongSelf = weakSelf

//颜色 字体
#define RGBColor(Hex)                   [UIColor colorWithHexString:(Hex)]
#define SystemFont(float)               [UIFont systemFontOfSize:(float)]
#define SystemFontBold(float)           [UIFont boldSystemFontOfSize:(float)]

//UUID
#define kDeviceUUIDString               [UIDevice currentDevice].identifierForVendor.UUIDString

///IOS版本判断
#define IOSAVAILABLEVERSION(version)    ([[UIDevice currentDevice]availableVersion:version]< 0)
#define kCurrentBuildVersion            [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]
#define kCurrentVersion                 [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

//当前系统版本
#define CurrentSystemVersion            [[UIDevice currentDevice].systemVersion doubleValue]

//只有一个确定的提示框
#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

//方法交换
#define QSExchangeMethod(oldSEL, newSEL) {\
Method oldMethod = class_getInstanceMethod(self, oldSEL);\
Method newMethod = class_getInstanceMethod(self, newSEL);\
method_exchangeImplementations(oldMethod, newMethod);\
}\

//安全String
#define QSNoNilString(s) (s.length ? s : @"")

//打开URL
#define QSOpenURL(urlString) {\
if (@available(iOS 10.0, *)) {\
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:(urlString)] options:@{} completionHandler:nil];\
} else {\
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:(urlString)]];\
}\
}\


#endif /* UtilsMacro_h */
