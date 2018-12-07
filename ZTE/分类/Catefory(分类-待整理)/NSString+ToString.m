//
//  NSString+ToString.m
//  ZTEWeiJin
//
//  Created by jajeo on 15/7/8.
//  Copyright (c) 2015年 jajeo. All rights reserved.
//

#import "NSString+ToString.h"

@implementation NSString (ToString)


+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}
+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }else if([object isKindOfClass:[NSNumber class]]){
        value = [NSString stringWithFormat:@"\"%@\"",object];
    }
    return value;
}

-(CGFloat)getHeightOfFont:(UIFont *)textFont widht:(CGFloat)textWidth withParagraphStyle:(NSParagraphStyle*)paragraphStyle
{
    CGSize requiredSize;
    
        CGSize boundingSize = CGSizeMake(textWidth, CGFLOAT_MAX);
        requiredSize = [self sizeWithFont:textFont
                        constrainedToSize:boundingSize
                            lineBreakMode:NSLineBreakByWordWrapping];
    return ceilf(requiredSize.height);
}

-(CGFloat)getWidthOfFont:(UIFont *)textFont height:(CGFloat)textHeight
{
    CGSize requiredSize;
    
        CGSize boundingSize = CGSizeMake(CGFLOAT_MAX, textHeight);
        requiredSize = [self sizeWithFont:textFont
                        constrainedToSize:boundingSize
                            lineBreakMode:NSLineBreakByWordWrapping];
        

    
    return ceilf(requiredSize.width);
}


@end
