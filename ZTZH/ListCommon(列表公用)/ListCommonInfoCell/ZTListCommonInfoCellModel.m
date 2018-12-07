//
//  ZTListCommonInfoCellModel.m
//  ZTStaff
//
//  Created by yujia liu on 2018/11/21.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import "ZTListCommonInfoCellModel.h"

@implementation ZTListCommonInfoCellModel
-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    self.title = title ? title : @"";
    self.content = content ? content : @"";
    return self;
}
@end
