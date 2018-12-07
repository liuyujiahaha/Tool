//
//  VerticalButtonPro.m
//  PlayCarParadise
//
//  Created by liuyujia on 2018/4/16.
//  Copyright © 2018年 CarFun. All rights reserved.
//

#import "VerticalButtonPro.h"
#define SPACE (self.frame.size.height - self.imageView.frame.size.height - self.titleLabel.frame.size.height - 5*layoutBy6()) / 2;        // imageView与顶部的距离 titleLabel与底部之间的距离

@implementation VerticalButtonPro

-(void)layoutSubviews {
    [super layoutSubviews];
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2+SPACE;
    self.imageView.center = center;

    // Center text
    CGRect newFrame = self.titleLabel.frame;
    newFrame.origin.x = 0;
    newFrame.origin.y =  self.imageView.frame.size.height + 7*layoutBy6() + SPACE;
    newFrame.size.width = self.frame.size.width;
    self.titleLabel.frame = newFrame;
    
    // title的样式
//    self.titleLabel.font = [UIFont systemFontOfSize:11*layoutBy6()];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = hexStringToColor(@"212121");
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
