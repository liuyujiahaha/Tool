//
//  ZTEaseBlankView.h
//  ZTStaff
//
//  Created by zhongxing on 2018/4/26.
//  Copyright © 2018年 智慧正通. All rights reserved.
//
//  SAEaseBlankView
//  1.页面加载数据时显示  2.页面无数据时显示  3.无网络链接状态时显示

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ZTEaseBlankViewType) {
    
    //加载数据时
    ZTEaseBlankViewTypeLoading,
    
    //无数据时
    ZTEaseBlankViewTypeNoData,
    
    //无网络连接
    ZTEaseBlankViewTypeNoNetwork,
    
    //加载页面出错
    ZTEaseBlankViewTypeError,
    
    //无权限
    ZTEaseBlankViewTypeNoPermissions,
    
};


@interface ZTEaseBlankView : UIView


/**
 *  显示
 *  @param  type           SAEaseBlankViewType显示类型
 */
- (void)showWithType:(ZTEaseBlankViewType)type;


/**
 *  显示
 *  @param  type           ZTEaseBlankViewType显示类型
 *  @param  clickAction    页面无数据时 无网络链接状态时 点击按钮触发
 */
- (void)showWithType:(ZTEaseBlankViewType)type clickAction:(void (^ __nullable)(void))clickAction;


/**
 *  移除
 */
- (void)dismiss;

@end
