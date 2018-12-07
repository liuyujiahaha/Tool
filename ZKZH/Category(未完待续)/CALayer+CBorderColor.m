//
//  CALayer+CBorderColor.m
//  PlayCarParadise
//
//  Created by chen on 2018/1/12.
//  Copyright © 2018年 CarFun. All rights reserved.
//

#import "CALayer+CBorderColor.h"

@implementation CALayer (CBorderColor)

-(void)setBorderUIColor:(UIColor*)color

{
    
    self.borderColor = color.CGColor;
    
}

-(UIColor*)borderUIColor

{
    
    return [UIColor colorWithCGColor:self.borderColor];
    
}


- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
