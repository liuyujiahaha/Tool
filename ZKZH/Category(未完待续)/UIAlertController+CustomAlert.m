//
//  UIAlertController+CustomAlert.m
//  PabeiProject
//
//  Created by siping ruan on 16/11/4.
//  Copyright © 2016年 Rasping. All rights reserved.
//

#import "UIAlertController+CustomAlert.h"

@implementation UIAlertController (CustomAlert)

+ (instancetype)renameAlertName:(NSString *)name handler:(void (^)(UIAlertAction *, UITextField *))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:iStoreLocalizedString(@"重置密码") message:nil preferredStyle:UIAlertControllerStyleAlert];
    __block UITextField *field = nil;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = iStoreLocalizedString(@"请输入登录密码");
        textField.secureTextEntry = YES;
        field = textField;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:iStoreLocalizedString(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:iStoreLocalizedString(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        if (![field.text isEqualToString:name]) {
            handler(action, field);
        }
    }];
    [alert addAction:confirm];
    return alert;
}

+ (instancetype)deleteAlertHandler:(void (^)(UIAlertAction *))hanler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你确定要删除该车位锁吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        hanler(action);
    }];
    [alert addAction:delete];
    return alert;
}

+ (instancetype)settingAlertWithTitle:(NSString *)title
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    UIAlertAction *setting = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alert addAction:setting];
    return alert;
}

+ (instancetype)normalAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)(UIAlertAction *))block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(action);
            }
        });
    }];
    [alert addAction:action];
    return alert;
}

+ (instancetype)choiceAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void (^)(UIAlertAction *))confirm cancelHandler:(void (^)(UIAlertAction *))cancel
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:iStoreLocalizedString(@"取消") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cancel) {
                cancel(action);
            }
        });
    }];
    [alert addAction:cancelAction];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:iStoreLocalizedString(@"确认") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (confirm) {
                confirm(action);
            }
        });
    }];
    [alert addAction:confirmAction];
    return alert;
}
+ (instancetype)choiceAlertWithTitle:(NSString *)title message:(NSString *)message confirmName:(NSString *)name confirmHandler:(void (^)(UIAlertAction *))confirm cancelHandler:(void (^)(UIAlertAction *))cancel
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (cancel) {
                cancel(action);
            }
        });
    }];
    [alert addAction:cancelAction];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (confirm) {
                confirm(action);
            }
        });
    }];
    [alert addAction:confirmAction];
    return alert;
}

+ (instancetype)knowAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(dispatch_block_t)block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"iKnow", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    }];
    [alert addAction:action];
    return alert;
}

+ (instancetype)payAlertViewWithTitle:(NSString *)title message:(NSString *)message payHandler:(void (^)(UIAlertAction *))block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    UIAlertAction *pay = [UIAlertAction actionWithTitle:NSLocalizedString(@"payNextNo", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(action);
        }
    }];
    [alert addAction:pay];
    return alert;
}
+ (instancetype)addAlertWithTitle:(NSString *)title message:(NSString *)message confirmName:(NSString *)confirmName cancelName:(NSString *)cancelName confirmHandler:(void (^)(UIAlertAction *))confirm cancelHandler:(void (^)(UIAlertAction *))cancel{
     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelName style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cancel(action);
            });
        }
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            dispatch_async(dispatch_get_main_queue(), ^{
                confirm(action);
            });
        }
    }];
     [alertController addAction:cancelAction];
     [alertController addAction:okAction];
     return alertController;
}
@end
