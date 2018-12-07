//
//  UserDefine.h
//  直销通2.8.0
//
//  Created by mzh on 16/3/14.
//  Copyright © 2016年 jun. All rights reserved.
//

#ifndef UserDefine_h
#define UserDefine_h

#define APP_ID @"100000054"
#define APP_SECRET_KEY @"4FDBD5C90C8E343A"

#define TESTNUMBER @"18816816888"
#define TESTPWD @"816888"
#define APP_SECRET_KEY_SHENHE @"C6D58B296BE90FDF"
#ifndef ZTE_ENVIRONMENT

#define ZTE_ENVIRONMENT  2 // 0:开发环境  1:正式环境 2测试环境

//店长：13266811623，18853180983，店员：15290255911
#if ZTE_ENVIRONMENT == 0
#define APP_URL @"http://devgw.vpclub.cn"

#elif ZTE_ENVIRONMENT == 1
#define APP_URL @"http://stagegw.vpclub.cn"

#elif ZTE_ENVIRONMENT == 2
#define APP_URL @"http://stagegw.vpclub.cn"

#endif
#endif

//适配手机型号
#define IS_IPHONE_4 (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )480 )== 0)
#define IS_IPHONE_5 (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )568 )== 0)
#define IS_IPHONE_6 (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )667 )== 0)
#define IS_IPHONE_6P (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )736 )== 0)

//获取屏幕宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//获取屏幕高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/// 屏幕状态栏高
#define STATUS_BAR_HEIGHT 20
/// 导航栏高
#define NAVIGATION_HEIGHT 64
/// 导航栏减去状态栏高
#define NAV_HEIGHT 44
//TabBar高
#define TABBAR_HEIGHT 44

//文字颜色
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

//设置矩形大小
#define RECT(x,y,w,h) CGRectMake(x,y,w,h)

//计算文字长度宽高
#define SIZE_OF_STRING(string,fontsize,maxWidth) string != nil ?[(string) boundingRectWithSize:CGSizeMake((maxWidth), 20000.0f) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:(fontsize)]}context:nil].size : CGSizeMake(0,0)

//block避免循环引用
#define VPWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define VPStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

/*********通知*********/
//显示HUD
#define L_HUD_SHOW_NOTI @"L_HUD_SHOW_NOTI"
//显示HUD带TEXT
#define L_HUD_SHOW_NOTI_TEXT @"L_HUD_SHOW_NOTI_TEXT"
//隐藏HUD
#define L_HUD_HIDDEN_NOTI @"L_HUD_HIDDEN_NOTI"

/*-------------------文件路径--------------------*/
#define DocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/"]

#define COLOR_BG @"E0DFDF"

#endif /* UserDefine_h */
