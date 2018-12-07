//
//  UITableView+Match.m
//  ZTEWeStore
//
//  Created by vivian on 2017/9/28.
//  Copyright © 2017年 vpclub.com. All rights reserved.
//

#import "UITableView+Match.h"

@implementation UITableView (Match)
+(void)load
{
    SEL select1 = @selector(initWithFrame:style:);
    SEL select2 = @selector(initUtilsWithFrame:style:);
    method_exchangeImplementations(class_getInstanceMethod(self, select1), class_getInstanceMethod(self, select2));
}

-(instancetype)initUtilsWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [self initUtilsWithFrame:frame style:style];
    
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedRowHeight = 0;
    
    return self;
}
@end
