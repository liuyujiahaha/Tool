//
//  SmartTracker.h
//  see https://github.com/idanal/musouKit
//
//  Created by zhongxing on 4/20/16.
//  Copyright © 2016年 GREI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Controller 跟踪
 * 双击状态栏电池图标显示/隐藏控制器层次结构
 * 双击状态栏左侧运营商图标显示/隐藏视图跟踪器. 视图结构将在console里打印
 */
@interface MSSmartTracker : UIWindow
/** Enable the tracker */
@property (nonatomic) BOOL enableGlobalTrack;

/** Singleton */
+ (instancetype)shared;

/** Call when enter */
- (void)enterPage:(UIViewController *)c;

///** Call when exit */
//- (void)exitPage:(UIViewController *)c;

@end
