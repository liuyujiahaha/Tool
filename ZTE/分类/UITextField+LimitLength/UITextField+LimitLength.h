//
//  UITextField+LimitLength.h
//  Tool
//
//  Created by liuyujia on 17/4/20.
//  Copyright © 2017年 liuyujia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)

/**
 使用时只要调用此方法，加上一个长度(int)，就可以实现了字数限制,配合tools中的方法  可以支持汉字。汉字占2个长度

 @param length 长度
 */
- (void)limitTextLength:(int)length;
/**
 *  uitextField 抖动效果
 */
- (void)shake;
@end
