//
//  VerticalButton.m
//  AJFSport
//
//  Created by gujie on 17/2/9.
//  Copyright © 2017年 aojun. All rights reserved.
//

#import "VerticalButton.h"
//#import <objc/runtime.h>

//const NSInteger spacing = 10;

@implementation VerticalButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setVertical];
    // 查看所有属性
//    id tfClass = objc_getClass("VerticalButton");
//    unsigned int outCount, i;
//    objc_property_t *properties = class_copyPropertyList(tfClass, &outCount);
//    for (i = 0; i < outCount; i++) {
//        objc_property_t property = properties[i];
//        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
//    }
    // 取消高亮置灰
    [self setAdjustsImageWhenHighlighted:NO];
}

- (void)setVertical
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + self.spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

@end
