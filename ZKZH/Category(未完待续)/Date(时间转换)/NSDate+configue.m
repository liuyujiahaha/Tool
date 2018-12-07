//
//  NSDate+configue.m
//  DateChange
//
//  Created by mac_111 on 16/2/22.
//  Copyright © 2016年 mac_111. All rights reserved.
//

#import "NSDate+configue.h"

@implementation NSDate (configue)


+(NSString*)configueDate:(NSString*)timeStamp
{
    NSString  *dateStr = nil;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSString *dateSMS = [dateFormatter stringFromDate:confromTimesp];
    if([self isToday:timeStamp]){
        dateStr=[NSString stringWithFormat:@"%@",[dateSMS substringWithRange:NSMakeRange(11, 5)]];
        return dateStr;
        
    }else if([self isYesterDay:timeStamp]){
        dateStr=[NSString stringWithFormat:@"%@%@",iStoreLocalizedString(@"昨天"),[dateSMS substringWithRange:NSMakeRange(11, 5)]];
        return dateStr;
        
    }
    if ([self isWeekDay:timeStamp]) {
        NSString *timestr=[dateSMS substringWithRange:NSMakeRange(11, 5)];
        NSString *weekDay =[self countWeekDay:timeStamp];
        dateStr =[NSString stringWithFormat:@"%@%@",weekDay,timestr];
        return dateStr;
    }else{
        
        dateStr=[NSString stringWithFormat:@"%@",[dateSMS substringWithRange:NSMakeRange(5, 11)]];
        return dateStr;
    }
    
    return nil;
    
}

// 判断是否为今天
+ (BOOL)isToday:(NSString *)timeStamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    NSString *dateSMS = [dateFormatter stringFromDate:confromTimesp];
    NSDate *now = [NSDate date];
    NSString *dateNow = [dateFormatter stringFromDate:now];
    if ([dateSMS isEqualToString:dateNow]){
        
        return YES;
    }
    else {
        return NO;
    }
}
//判断是否为昨天
+ (BOOL)isYesterDay:(NSString*)timeStamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateSMS = [dateFormatter stringFromDate:confromTimesp];
    
    NSDate *now = [NSDate date];
    
    NSDate *yesterday = [now dateByAddingTimeInterval:(-24*60*60)];
    NSString *dateYesterDay = [dateFormatter stringFromDate:yesterday];
    
    if ([dateSMS isEqualToString:dateYesterDay]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)isWeekDay:(NSString*)timeStamp
{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
//    NSLog(@"  %@",confromTimesp);
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDate *start;
    NSTimeInterval  extends;
    NSDate *NowDate =[NSDate date];
    
    NSInteger interval2 =[zone secondsFromGMTForDate:NowDate];
    NSDate * locatDate2 = [NowDate dateByAddingTimeInterval:interval2];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    BOOL success = [cal rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&start interval:&extends forDate:locatDate2];
    
    if (!success) {
        return NO;
    }
    NSTimeInterval dateInSecs = [confromTimesp timeIntervalSinceReferenceDate];
    NSTimeInterval dayStartInSecs= [start timeIntervalSinceReferenceDate]+24*60*60;
    
    if(dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs+extends)){
        return YES;
        
    }
    else {
        return NO;
    }
}



// 计算周几
+ (NSString*)countWeekDay:(NSString*)timeStamp
{
    //    NSDate  *date =[NSDate date];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    DebugLog(@"1456122864  = %@",date);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    DebugLog(@"%ld",(long)components.weekday);
    NSArray *weekday = [NSArray arrayWithObjects:iStoreLocalizedString(@"周日"), iStoreLocalizedString(@"周一"), iStoreLocalizedString(@"周二"), iStoreLocalizedString(@"周三"), iStoreLocalizedString(@"周四"), iStoreLocalizedString(@"周五"), iStoreLocalizedString(@"周六"), nil];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday-1];
    return weekStr;
}



// 计算时间差
+ (NSString *)intervalSinceNow:(NSString *) timeStamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue]];
    NSTimeInterval late=[confromTimesp timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@%@", timeString,iStoreLocalizedString(@"分钟前")];
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@%@", timeString,iStoreLocalizedString(@"小时前")];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@%@", timeString,iStoreLocalizedString(@"天前")];
        
    }
    return timeString;
}

//获取当天日期字符串
+(NSString *)getToday{
    NSDate *date = [NSDate date];
  return [self stringFromDate:date];
}
//date转字符串
+(NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:iStoreLocalizedString(@"yyyy年MM月dd日 HH:mm")];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
//时间戳转化日期 type:装换成日期的格式
+(NSString *)timeWithTimeIntervalString:(NSString *)time withType:(NSString *)type{
    NSTimeInterval interval    = [time doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}
//字符串转日期
+(NSDate *)stringToDate:(NSString *)dateStr{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:iStoreLocalizedString(@"yyyy年MM月dd日")];
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    return inputDate;
}
+(NSDate *)stringToDate:(NSString *)date WithType:(NSString *)type{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:type];
    NSDate* inputDate = [inputFormatter dateFromString:date];
    return inputDate;
}
//日期转化成星期(type表示日期格式)
+ (NSString*)getWeekByDate:(NSString *)dateStr WithType:(NSString *)type{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:type];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSArray *weeks = @[[NSNull null],iStoreLocalizedString(@"周日"),iStoreLocalizedString(@"周一"),iStoreLocalizedString(@"周二"),iStoreLocalizedString(@"周三"),iStoreLocalizedString(@"周四"),iStoreLocalizedString(@"周五"),iStoreLocalizedString(@"周六")];
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:calendarUnit fromDate:date];
    
    return [weeks objectAtIndex:components.weekday];
}
//距离现在的天数
+ (int)intervalSinceNow1: (NSString *)theDate{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy.MM.dd"];//设置时间格式//很重要
    NSDate *d=[date dateFromString:theDate];
//    NSTimeInterval late=[d timeIntervalSince1970]*1;
//    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [d timeIntervalSinceNow];
    return  fabs(now/(24*3600));
}
+(NSString *)currentTimeSincefutureTime:(NSString *)futureTime {
    
    NSTimeInterval now=[[NSDate date] timeIntervalSince1970];
    
    long msec = [futureTime longLongValue] /1000;
    msec = msec - now;
    if (msec <= 0)
    {
        return @"";
    }
    NSInteger d = msec/60/60/24;
    NSInteger h = msec/60/60%24;
    NSInteger  m = msec/60%60;
    NSInteger  s = msec%60;
    
    NSString *_tStr = @"";
    NSString *_dStr = @"";
    NSString *_hStr = @"";
    NSString *_mStr = @"";
    NSString *_sStr = @"";
    
    if (d > 0)
    {
        _dStr = [NSString stringWithFormat:@"%ld%@",d,iStoreLocalizedString(@"天")];
    }
    
    if (h > 0)
    {
        NSString *hourStr = @"小时";
        if (iStoreIsEnglish) {
            hourStr = @":";
        }
        _hStr = [NSString stringWithFormat:@"%ld%@",h,hourStr];
    }
    if (m > 0)
    {
        NSString *minuteStr = @"分钟";
        if (iStoreIsEnglish) {
            minuteStr = @":";
        }
        _mStr = [NSString stringWithFormat:@"%ld%@",m,minuteStr];
    }
    if (s > 0)
    {
        NSString *secondStr = @"秒";
        if (iStoreIsEnglish) {
            secondStr = @"";
        }
        _sStr = [NSString stringWithFormat:@"%ld%@",s,secondStr];
    }
    _tStr = [NSString stringWithFormat:@"%@%@%@%@",_dStr,_hStr,_mStr,_sStr];
    return _tStr;
}

@end
