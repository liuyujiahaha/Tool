//
//  UIResponder+NextResponder.m
//  Responder_Test
//
//  Created by lius on 2017/12/28.
//  Copyright © 2017年 CarFun. All rights reserved.
//

#import "UIResponder+NextResponder.h"

@implementation UIResponder (NextResponder)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
    
}
@end
