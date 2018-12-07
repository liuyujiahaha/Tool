//
//  ZTListCommonInfoCellModel.h
//  ZTStaff
//
//  Created by yujia liu on 2018/11/21.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTListCommonInfoCellModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
