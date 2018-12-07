//
//  UIView+Extension.m
//  Tool
//
//  Created by liuyujia on 2018/12/6.
//  Copyright © 2018 liuyujia. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}

- (void)setViewWidth:(CGFloat)viewWidth{
    CGRect frame = self.frame;
    frame.size.width = viewWidth;
    self.frame = frame;
}
- (CGFloat)viewWidth{
    return self.frame.size.width;
}

- (void)setViewHeight:(CGFloat)viewHeight{
    CGRect frame = self.frame;
    frame.size.height = viewHeight;
    self.frame = frame;
}
- (CGFloat)viewHeight{
    return self.frame.size.height;
}


- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}

@end
