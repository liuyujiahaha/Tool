//
//  UIAlertController+CustomAlert.h
//  PabeiProject
//
//  Created by siping ruan on 16/11/4.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (CustomAlert)

/**
 重命名弹框

 @param name    初始名
 @param handler 确定按钮点击回调
 */
+ (instancetype)renameAlertName:(NSString *)name handler:(void (^) (UIAlertAction *action, UITextField *textField))handler;

/**
 删除弹框

 @param hanler 删除回调
 */
+ (instancetype)deleteAlertHandler:(void (^) (UIAlertAction *action))hanler;

/**
 设置弹框
 */
+ (instancetype)settingAlertWithTitle:(NSString *)title;
/**
 普通弹框
 */
+ (instancetype)normalAlertWithTitle:(NSString *)title
                             message:(NSString *)message
                             handler:(void (^)(UIAlertAction *action))block;

/**
 选择弹框

 @param confirm 确认回调
 @param cancel 取消回调
 */
+ (instancetype)choiceAlertWithTitle:(NSString *)title
                             message:(NSString *)message
                      confirmHandler:(void(^)(UIAlertAction *action))confirm
                       cancelHandler:(void(^)(UIAlertAction *action))cancel;
/**
 我知道了弹窗
 */
+ (instancetype)knowAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                        confirmHandler:(dispatch_block_t)block;
/**
 购买下一期弹窗
 */
+ (instancetype)payAlertViewWithTitle:(NSString *)title
                              message:(NSString *)message
                           payHandler:(void (^)(UIAlertAction *action))block;

+ (instancetype)choiceAlertWithTitle:(NSString *)title message:(NSString *)message confirmName:(NSString *)name confirmHandler:(void (^)(UIAlertAction *))confirm cancelHandler:(void (^)(UIAlertAction *))cancel;

/**
   自定义确定与取消按钮
 */
+ (instancetype)addAlertWithTitle:(NSString *)title message:(NSString *)message confirmName:(NSString *)confirmName cancelName:(NSString *)cancelName confirmHandler:(void (^)(UIAlertAction *))confirm cancelHandler:(void (^)(UIAlertAction *))cancel;
@end
