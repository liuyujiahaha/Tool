//
//  UIControl+UMengAnalytics.m
//  PlayCarParadise
//
//  Created by liuyujia on 2018/9/13.
//  Copyright © 2018年 CarFun. All rights reserved.
//

#import "UIControl+UMengAnalytics.h"
#import <objc/runtime.h>

@implementation UIControl (UMengAnalytics)

+(void)load{
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);

    Method myMethod = class_getInstanceMethod(self, @selector(mySendAction:to:forEvent:));
    SEL mySEL = @selector(mySendAction:to:forEvent:);

    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));

    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
    }
}

-(void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (event.allTouches.count) {
        NSArray *arr = event.allTouches.allObjects;
        UITouch *touch = arr.firstObject;
        if ([touch.view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)touch.view;
            NSString *title = btn.titleLabel.text;
            if (title.length) {
                [MobClick event:title];
            }
        }
    }

    [self mySendAction:action to:target forEvent:event];
}


@end
