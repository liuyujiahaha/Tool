//
//  ZTListCommonComfirmBottomView.h
//  ZTStaff
//
//  Created by yujia liu on 2018/11/22.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^comfirmBlock)(void);
@interface ZTListCommonComfirmBottomView : UIView
+(instancetype)initWithTitle:(NSString *)title block:(comfirmBlock)block;
@end

NS_ASSUME_NONNULL_END
