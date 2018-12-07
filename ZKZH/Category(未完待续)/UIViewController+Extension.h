//
//  UIViewController+Extension.h
//  PabeiProject
//
//  Created by siping ruan on 16/11/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/**
 获取当前正在显示的控制器
 */
+ (UIViewController *)currentVC;
/**
 获取当前presented出的控制器
 */
+ (UIViewController *)presentedVC;

@end
