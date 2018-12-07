//
//  UIViewController+Extension.m
//  PabeiProject
//
//  Created by siping ruan on 16/11/9.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

+ (UIViewController *)currentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = nextResponder;
        UIViewController *vc = tab.childViewControllers[tab.selectedIndex];
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)vc;
            result = nav.topViewController ? nav.topViewController : nav;
        }else {
            result = vc;
        }
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = nextResponder;
        result = nav.topViewController ? nav.topViewController : nav;
    } else if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

+ (UIViewController *)presentedVC
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
