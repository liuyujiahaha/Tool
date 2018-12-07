//
//  ShareManagerNetRequest.h
//  小移云店
//
//  Created by vivian on 2017/5/27.
//  Copyright © 2017年 vivian. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^failureBlock)(NSString *failureMessage);
typedef void(^dictionaryBlock)(NSDictionary *dataDictionary);

@interface ShareManagerNetRequest : NSObject
/*
 分享统计
 */
-(void)shareShopPage:(NSDictionary*)dict baseVC:(BaseVC *)base andSuccess:(dictionaryBlock)dataDictionary andFailure:(failureBlock)failure;

//生成短链
-(void)createShortLink:(NSDictionary*)dict baseVC:(BaseVC *)base andSuccess:(dictionaryBlock)dataDictionary andFailure:(failureBlock)failure;

//查询短链
//-(void)quaryShortLink:(NSDictionary*)dict baseVC:(BaseVC *)base andSuccess:(dictionaryBlock)dataDictionary andFailure:(failureBlock)failure;
@end
