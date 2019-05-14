//
//  AppConfig.h
//  EVT-Wallet
//
//  Created by 孙俊 on 2018/11/26.
//  Copyright © 2018 HANGZHOU QISHENG TECHNOLOGY CO.LTD. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

//================ social address============//
#define kShareUrlString  @"https://dibaqu.com/B3ma"
#define kShareLogo       @"share_logo"
#define kShareTitle      @"EveriWallet"

#define kFacebookAddress    @"https://www.facebook.com/everiToken"
#define kTwitterAddress     @"https://twitter.com/everiToken"
#define kTelegramAddress    @"https://t.me/everiToken"
#define kTelegramCNAddress  @"https://t.me/everiTokenCNofficial"
#define kTelegramRUSAddress @"https://t.me/everitokenru"
#define kWechatAddress      @"@everiToken"

//================ Third ===========//
static NSString * const kBuglyAppID = @"b20db2c454";

//================ localizedString ===========//
#define QSLocalizedString(key)   (NSLocalizedStringFromTable(key, @"CustomLocalizable", nil).length ? NSLocalizedStringFromTable(key, @"CustomLocalizable", nil) : @"")

//================ home ui ===================//
#define kHomeSwipeViewW           kScreenWidth
#define kHomeSwipeViewH           (kRealValue(240) + kiPhoneXTabBarExtraHeight)

#define kHomeSegmentViewTopMargin kRealValue(20)
#define kHomeSegmentViewW         kScreenWidth
#define kHomeSegmentViewH         kRealValue(50)

#define kHomeShortcutViewW        kRealValue(345)
#define kHomeShortcutViewH        kRealValue(95)

#define kHomeHeaderViewHeight     (kHomeSwipeViewH + kHomeShortcutViewH/2 + kHomeSegmentViewTopMargin + kHomeSegmentViewH)

//================= bottom button ==============//
#define kBottomButtonWidth   kRealValue(345)
#define kBottomButtonHeight  kRealValue(40)


#define QSPrivateKey [QSWalletHelper sharedHelper].currentEvt.privateKey
#define QSPublicKey [QSWalletHelper sharedHelper].currentEvt.publicKey

#endif /* AppConfig_h */
