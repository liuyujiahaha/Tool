//
//  FunctionDefine.h
//  LoveU
//
//  Created by maz on 15/11/10.
//  Copyright © 2015年 mzh. All rights reserved.
//  一些inline函数的定义类

#ifndef FunctionDefine_h
#define FunctionDefine_h

#pragma mark - 设置特殊字体(适配iOS9以下系统无法设置特殊字体)
CG_INLINE UIFont* customFont(NSString*fontName,CGFloat fontSize) {
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_9_0) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}

//将分转化为元
CG_INLINE CGFloat transferPenyToYuan(NSString *peny){
    return [peny floatValue]/100.0;
}

CG_INLINE CGFloat computeHeightForString(NSString* content,CGFloat width ,UIFont* font){
    return ceil([content boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height);
}


CG_INLINE NSString *  changeTimestampBystring(NSString *time,NSString *timeFomet)
{
    NSString * subTime = [time substringWithRange:NSMakeRange(0, time.length)];
    double timeint = subTime.doubleValue;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:timeFomet]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeint];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
}

//富文本
//改变字体大小
CG_INLINE NSMutableAttributedString* attributedWithFont(CGFloat font, NSString *str, NSRange range) {
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:font]
                          range:range];
    return AttributedStr;
}
//改变字体颜色
CG_INLINE NSMutableAttributedString* attributedWithColor(UIColor *color, NSString *str, NSRange range){
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:range];
    
    return AttributedStr;
}
//改变字体和颜色
CG_INLINE NSMutableAttributedString* attributedWithString(NSString *str, CGFloat font, UIColor *color, NSRange range) {
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:font]
                          range:range];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:range];
    
    return AttributedStr;
}

//判断数组是否越界
//YES：可用；NO：不可用
CG_INLINE BOOL arrayIsAvailable(NSArray *array,int index) {
    BOOL isAvailable = NO;
    if (array!=nil&&array.count>0&&index>=0&&array.count-1>=index) {
        isAvailable=YES;
    }
    return isAvailable;
}


//计算文本width
CG_INLINE CGFloat textWidth(NSString *textStr ,UIFont *font){
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect textRect = [textStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1500) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    CGSize textSize = textRect.size;
    return textSize.width;
}

CG_INLINE NSString*  ShiftThetTimestampByString(NSString *time)
{
    NSString * subTime = [time substringWithRange:NSMakeRange(0, time.length)];
    double timeint = subTime.doubleValue;
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    
    NSDate * nowDate = [NSDate date];
    /////  将需要转换的时间转换成 NSDate 对象
    NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970:timeint];
    /////  取当前时间和转换时间两个日期对象的时间间隔
    /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
    NSTimeInterval Subtime = [nowDate timeIntervalSinceDate:needFormatDate];
    
    //// 再然后，把间隔的秒数折算成天数和小时数：
    
    NSString *dateStr = @"";
    
    if (Subtime<=60) {  //// 1分钟以内的
        dateStr = @"刚刚";
    }else if(Subtime<=60*60){ // 一个小时以内的
        
        int mins = Subtime/60;
        dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
        
    }else if(Subtime<=60*60*24){  //在两天内的
        
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
        NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([need_yMd isEqualToString:now_yMd]) {
            //// 在同一天
            dateStr = [NSString stringWithFormat:@"今天%@",[dateFormatter stringFromDate:needFormatDate]];
        }else{
            ////  昨天
            dateStr = [NSString stringWithFormat:@"昨天%@",[dateFormatter stringFromDate:needFormatDate]];
        }
    }else {
        
        [dateFormatter setDateFormat:@"yyyy"];
        NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            ////  在同一年
            [dateFormatter setDateFormat:@"MM月dd日"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
    }
    
    return dateStr;
}
CG_INLINE UIImage* imageWithColor(UIColor* color)
{
    CGRect rect = CGRectMake(0, 0, 100, 100);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

CG_INLINE float ComputingTextHeight(NSString* text ,float font ,float maxWith , int maxLine)
{
    CGSize maxSize = SIZE_OF_STRING(text, font, maxWith);
    CGSize lineSize = SIZE_OF_STRING(@"肖亮", font, maxWith);
    
    float height = maxSize.height > lineSize.height * maxLine ?  lineSize.height * maxLine :  maxSize.height;
    
    return height;
}

CG_INLINE NSString* validateString(id obj)
{
    NSString *str=@"";
    if ([obj isKindOfClass:[NSNull class]])
    {
        
    }
    
    else if ([obj isKindOfClass:[NSString class]])
    {
        str=(NSString*)obj;
        
        if ([str isEqualToString:@"(null)"]) {
            return @"";
        }
        
        return str;
    }
    else if ([obj isKindOfClass:[NSNumber class]])
    {
        str=[NSString stringWithFormat:@"%@",obj];
        
        return str;
    }
    
    return str;
}

//判断是否是全空的字符串
CG_INLINE  BOOL  isBlankString(NSString *string){
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//判断是否含非法
CG_INLINE  BOOL  IsIllegal(NSString *string){
    //判断是否为整形：
    NSScanner* scan1 = [NSScanner scannerWithString:string];
    int val1;
    BOOL isPureInt  = [scan1 scanInt:&val1] && [scan1 isAtEnd];
    //判断是否为浮点形：
    NSScanner* scan2 = [NSScanner scannerWithString:string];
    float val2;
    BOOL isPureFloat = [scan2 scanFloat:&val2] && [scan2 isAtEnd];

    if (isPureInt || isPureFloat) {
        return NO;
    }
    else
    {
        return YES;
    }
}


/**
 *  消息提示
 *
 *  @param message 提示内容
 */
CG_INLINE void AlertWithMessage(NSString *message)
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage isEqualToString:@"zh-Hans"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//通过6适配函数5,6p
CG_INLINE double layoutBy6()
{
    
    BOOL is_iphone_6p=  (fabs((double)[[ UIScreen mainScreen ] bounds ].size.height - ( double )736 )== 0);
    
    BOOL is_iphone_5low=  (fabs((double)[[ UIScreen mainScreen ] bounds ].size.width - ( double )320 )== 0);
    
    
    double dlayout=1.0;
    
    if (is_iphone_5low) {
        dlayout = (double)320/375;
    }
    
    else if(is_iphone_6p)
    {
        dlayout=(double)414/375;
    }
    else
    {
        
    }
    
    return dlayout;
}

//16进制颜色(html颜色值)字符串转为UIColor
CG_INLINE UIColor * hexStringToColor(NSString *stringToConvert)
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//16进制颜色(html颜色值)字符串转为UIColor
CG_INLINE UIColor * hexStringToColorA(NSString *stringToConvert,CGFloat alpha)
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}


/**
 *  NSUserDefaults 存数据
 *
 *  @param value 存数据的值
 *
 *  @param key 存数据的key
 */
CG_INLINE void UDSaveData(NSString *value ,NSString *key)
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  NSUserDefaults 取数据
 *
 *  @param key 取数据的key
 */
CG_INLINE NSString* UDTakeData(NSString *key)
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

//将传入的数据转换成json
CG_INLINE NSString *classToJson(id data)
{
    if(data==nil)
    {
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = [[NSData alloc]initWithData:[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error]];
    NSString *initStr = [[NSString alloc] initWithData:jsonData  encoding:NSUTF8StringEncoding];
    NSString *str_ = [NSString stringWithFormat:@"%@",initStr];
    return str_;
}

//将json转换成字典
CG_INLINE id jsonToClass(NSString *str)
{
    NSError *error = nil;
    id dic;
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil){
        if ([jsonObject isKindOfClass:[NSDictionary class]]){
            dic = (NSDictionary *)jsonObject;
            return dic;
        } else if ([jsonObject isKindOfClass:[NSArray class]]){
            dic = (NSArray *)jsonObject;
            return dic;
            
        } else {
        }
    }
    return nil;
}

CG_INLINE NSString* JSONString(NSString *aString)
{
    NSMutableString *s = [NSMutableString stringWithString:aString];
    //[s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    //[s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@":null" withString:@":\"\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

//UITableView 多余的cell 隐藏区隔线
CG_INLINE void setExtraCellLineHidden(UITableView *tableView)
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

//----------------------------------------------------------------------/
/*
 * 通知的便捷方法
 */
CG_INLINE void ADD_NOTIFICATION(NSString *name, id target, SEL action, id object)
{
    [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:name object:object];
}

CG_INLINE void REMOVE_NOTIFICATION(NSString *name, id target, id object)
{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:name object:object];
}

CG_INLINE void POST_NOTIFICATION(NSString *name, id object, NSDictionary *userInfo)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

#endif /* FunctionDefine_h */
