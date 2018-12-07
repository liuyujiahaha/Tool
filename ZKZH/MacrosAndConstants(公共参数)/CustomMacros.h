//
//  CustomMacros.h
//  PlayCarParadise
//
//  Created by lius on 2017/10/10.
//  Copyright © 2017年 CarFun. All rights reserved.
//

#ifndef CustomMacros_h
#define CustomMacros_h

//尺寸
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
//状态栏高度
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define C_NavBarHeight 44.0
//整个导航栏高度
#define TopHeight (StatusBarHeight + C_NavBarHeight)

#define kGAP 10
#define kThemeColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]
#define kAvatar_Size 40

//颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ColorA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define UUIDSTRING  [[UIDevice currentDevice].identifierForVendor UUIDString]

#define  MAXWIDTH       [UIScreen mainScreen].bounds.size.width
#define  MAXHEIGHT      [UIScreen mainScreen].bounds.size.height
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define ScreenRect      [UIScreen mainScreen].bounds
//多语言
#define iStoreLocalizedString(key) NSLocalizedString((key),nil)
//空字符串
#define iStoreNilString(key) [key isEqualToString:@""] 

//键盘上面的工具条
#define kChatToolBarHeight              49

#define FunctionViewHeight 200.0f
///比例系数
#define PXSCALE  MAXWIDTH/375
#define PXSCALE_CATEGORYAD  0.4
#define ScreenScale ScreenW/ScreenH

#define tableViewBGColor [UIColor colorwithHExString:@"#EEEEEE" alpha:1]

#define navBarbackgroundColor [UIColor whiteColor]

#define PXSCALEH  MAXHEIGHT/667
#define imageName(name) [UIImage imageNamed:name]
#define Font(size)    [UIFont systemFontOfSize:size*PXSCALE]
#define Point(X,Y)  CGPointMake(X, Y)


//适配手机型号
#define IS_IPHONE_4 (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )480 )== 0)
#define IS_IPHONE_5 (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )568 )== 0)
#define IS_IPHONE_6 (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )667 )== 0) //6、7、8
#define IS_IPHONE_6P (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )736 )== 0)//6p、7p、8p
#define IS_IPHONE_X (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )812 )== 0)//X
#define IS_IPHONE_X_SERIES (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )812 )== 0)||(fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )896 )== 0)//X Xs XsMax XR

//适配iphoneX
#define kStatusBarHeight ((IS_IPHONE_X_SERIES)?44:20)
#define IPHONEX_TOP_SPACE ((IS_IPHONE_X_SERIES)?24:0)
#define IPHONEX_BOTTOM_SPACE ((IS_IPHONE_X_SERIES)?10:0)
#define IPhoneX_Bottom (((IS_IPHONE_X_SERIES)?34:0))
#define TabBarHeight (49+IPhoneX_Bottom)
#define NavBarHeight (64+IPHONEX_TOP_SPACE)

#define SoundNofi @"soundNofi"//声音推送开关
#define ShakeNofi @"shakeNofi"//震动开关

/**
 * RGB 配置颜色
 */
#define	UIColorFromRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//导航title字体大小
#define navTitleFont 17

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];

//image
#define imageName(name) [UIImage imageNamed:name]

/**
 * 16进制配置颜色
 */
#define UIColorHexFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 十六进制颜色设置
#define SetColor(color,a) [UIColor colorwithHExString:[NSString stringWithFormat:@"%@",color] alpha:a]

#define  TextMainBodyColor  SetColor(@"#666666",1.0)

//呼出登录界面
//#define PopLoginCtrl  [[NSNotificationCenter defaultCenter] postNotificationName:@"needLogin" object:nil];

//粗分割线的颜色
#define widthLineColor SetColor(@"#e6e8eb",1.0)

//边框颜色
#define BorderColor Color(230, 232, 235)

//主题颜色
#define SubjectColor Color(240, 40, 31)

//屏比宽高
#define ScaleHeight(H)  [[UIScreen mainScreen] bounds].size.height/667*(H)
#define ScaleWith(W)    [[UIScreen mainScreen] bounds].size.width/375*(W)
#define BUTW (MAXWIDTH-100*PXSCALE)/6

#define MainColor Color(43, 145, 55)//主色
#define AssistColor Color(255, 204, 0)//辅色
//cell选中颜色
#define SelectedColor Color(225, 225, 225)

//导航栏主题色
#define navBgColor Color(84,150,255)

//标准字体颜色
#define FontColor Color(64, 64, 64)

#define BgColor Color(218,218,218)

//灰化字体颜色
#define gayFontColor Color(153, 153, 153)

//日志
#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p:%@>:第%d行  %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

//判断系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     (［[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IOS9 ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)
#pragma mark - 第三方引用
//MARK:---------- 主要 Key
#define key_APPID   @"1330136767"
#define key_APPStoree @"https://itunes.apple.com/app/id"+key_APPID

#define cp_UMengAppKey   @"5a45e4f5f29d9839f300008f"
#define cp_JPushKey      @"b388733ef153807506fb4381"
#define cp_WXappID       @"wx490200ab8be08428"
#define cp_WXappSecret   @"23bd34464ac65e5f9b59bcabdf6eb19d"
#define cp_QQappID       @"1106566527"
#define cp_QQappSecret   @"d21vOtfp3Fszgtan"
#define cp_SinaappID       @"1097061282"
#define cp_SinaappSecret   @"ead407d3528f952451a4b1486eb84c43"
#define cp_AMapKey       @"999cc58741f2656e425a7dc15b5af922"

//Userdefault的key
#define kIsFirstRed @"IsFirstRed"                                                       //第一次弹出红包
//多语言
#define kChangeLanguage     @"myLanguage"                                               //更改的语言
#define kLanguageChinese    @"zh-Hans"                                                  //语言中文
#define kLanguageEnglish    @"en"                                                       //语言英文
#define iStoreIsEnglish     [LanguageTool isEnglish]//[UDTakeData(kChangeLanguage) containsString:@"en"]              //当前保存的语言是否为英语 为了适配多语言下的特殊需求
#define iStoreLocalUS [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]              //设置当前日期格式地区为美国 为了处理切换语言之后日期格式还是中文的问题


//Paypal支付环境 以后改成正式环境的地址  调试阶段改成sandbox环境
#define iStorePayPalEnvironment PayPalEnvironmentProduction

//地区
#define kNationNetwork      @"kNationNetwork"                                           //网络请求到的地区   2马来西亚  1中国
#define kNationNoLogin      @"kNationNoLogin"                                           //未登录的时候设置的地区
#define kNationLogin        @"kNationLogin"                                             //已登录的时候设置的地区 用这个后面加上一个account来创建一个key
#define ISTORECHANGELOCATION     @"ChangeLocation"                                           //更改的地区
#define kLocationMalaysia   @"2"                                                       //地区马来西亚
#define kLocationChina      @"1"                                                       //地区中国
#define iStoreIsMalaysia    [[CountriesAndRegionsTool returnNationId] isEqualToString:kLocationMalaysia]        //当前地区是马来西亚

//中间九宫格视图尺寸
#define MidDepolyW  ScreenW - 75
#define MidDepolyItemInteriorSpace 4
#define MidDepolyNineSquareW (MidDepolyW - 2 * MidDepolyItemInteriorSpace) / 3
//用户信息归档路径
#define ArchivePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"AishiduoUserInfo.data"]
//广告信息归档路径
#define ActivityPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ActivityInfo.data"]

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;
//列表加载数目
#define PageSize 10

#endif /* CustomMacros_h */
