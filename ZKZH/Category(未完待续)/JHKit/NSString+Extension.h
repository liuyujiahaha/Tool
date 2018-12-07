//
//  NSString+Extension.h
//  WeChat
//
//  Created by zhengwenming on 2017/9/21.
//  Copyright © 2017年 zhengwenming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 * 计算文字高度，可以处理计算带行间距的等属性
 */
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font;
/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
/**
 * 计算最大行数文字高度，可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;

- (NSString *)handleBankNum;

/**
 银行名称+后四位

 @param string 完整银行卡号
 @return 银行名称+后四位
 */
- (NSString *)cy_stringByAppendingString:(NSString *)string;

//校验银行卡是否合法
//Luhn算法
- (BOOL)isValidCardNumber;

//获取当前时间戳  (以毫秒为单位)
+(NSString *)getNowTimeTimestamp;

//修正浮点型精度丢失
+(NSString *)reviseString:(NSString *)str;
    
@end
