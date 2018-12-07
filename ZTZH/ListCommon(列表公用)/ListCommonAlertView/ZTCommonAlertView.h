//
//  ZTCommonAlertView.h
//  ZTStaff
//
//  Created by yujia liu on 2018/11/21.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ZTCommonAlertViewBlock)(void);
@interface ZTCommonAlertView : UIView

/**
 显示弹出框

 @param title 标题
 @param message 内容
 @param leftButton 左侧按钮文字
 @param rightButton 右侧按钮文字
 @param leftBlock 左侧事件
 @param rightBlock 右侧事件
 @return 弹出框
 */
-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message leftButton:(NSString *)leftButton rightButton:(NSString *)rightButton leftBlock:(nullable ZTCommonAlertViewBlock)leftBlock rightBlock:(ZTCommonAlertViewBlock)rightBlock;


/**
 显示
 */
-(void)show;

/**
 隐藏
 */
-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
