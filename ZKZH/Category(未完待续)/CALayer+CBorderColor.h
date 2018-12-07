//
//  CALayer+CBorderColor.h
//  PlayCarParadise
//
//  Created by chen on 2018/1/12.
//  Copyright © 2018年 CarFun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CALayer (CBorderColor)
@property(nonatomic, assign) UIColor *borderUIColor;
- (void)setBorderColorFromUIColor:(UIColor *)color;
@end
