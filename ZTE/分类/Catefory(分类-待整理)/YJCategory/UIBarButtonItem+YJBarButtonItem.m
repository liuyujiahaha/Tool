//
//  UIBarButtonItem+YJBarButtonItem.m
//  TestDemo
//
//  Created by 刘英杰 on 2017/9/22.
//  Copyright © 2017年 刘英杰. All rights reserved.
//

#import "UIBarButtonItem+YJBarButtonItem.h"

@implementation UIBarButtonItem (YJBarButtonItem)

+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:HighlightedImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc]initWithFrame:btn.frame];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc]initWithCustomView:contentView];
}

+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:SelectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc]initWithFrame:btn.frame];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc]initWithCustomView:contentView];
}


+(UIBarButtonItem *)backItemWithImage:(UIImage *)image WithHighlightedImage:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn sizeToFit];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:HighlightedImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, -20);
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}


@end
