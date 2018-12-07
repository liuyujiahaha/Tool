//
//  NSDate+configue.h
//  DateChange
//
//  Created by mac_111 on 16/2/22.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (configue)

// 判断是否今天
+ (BOOL)isToday:(NSString*)timeStamp;

//判断是否昨天
+ (BOOL)isYesterDay:(NSString*)timeStamp;

// 判断是否本周
+ (BOOL)isWeekDay:(NSString*)timeStamp;

//最终返回时间
+(NSString*)configueDate:(NSString*)timeStamp;

//计算时间间隔
+ (NSString *)intervalSinceNow: (NSString *) timeStamp;
//获取当天日期字符串
+(NSString *)getToday;

//时间戳转化日期 type:装换成日期的格式
+(NSString *)timeWithTimeIntervalString:(NSString *)time withType:(NSString *)type;

//字符串转日期
+(NSDate *)stringToDate:(NSString *)dateStr;

//日期转化成星期(type表示日期格式)
+ (NSString*)getWeekByDate:(NSString *)dateStr WithType:(NSString *)type;
//距离现在的天数
+ (int)intervalSinceNow1: (NSString *)theDate;

+(NSDate *)stringToDate:(NSString *)date WithType:(NSString *)type;

//现在时间距离将来时间的天数
+(NSString *)currentTimeSincefutureTime:(NSString *)futureTime;

@end
