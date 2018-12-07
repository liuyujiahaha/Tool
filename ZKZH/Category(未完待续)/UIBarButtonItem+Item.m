//
//  UIControl+Extension.m
//  高仿映客
//
//  Created by JIAAIR on 16/7/3.
//  Copyright © 2016年 JIAAIR. All rights reserved.
//

#import "UIBarButtonItem+Item.h"
// 把按钮包装成UIBarButtonItem,系统会把点击范围扩大

@implementation UIBarButtonItem (Item)
+ (instancetype)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:containView];
}

+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:containView];
}

//只有文字的item；
+(instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];//选错了点按的模式；
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    UIView *containView = [[UIView alloc] initWithFrame:btn.bounds];
    [containView addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containView];
    return item;
    
}
@end
