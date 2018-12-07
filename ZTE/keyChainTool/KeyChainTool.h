//
//  KeyChainTool.h
//  小移云店
//
//  Created by panda on 2017/10/18.
//  Copyright © 2017年 vivian. All rights reserved.
//
//  keychain的存取删

#import <Foundation/Foundation.h>



@interface KeyChainTool : NSObject

/**
 存到keychain
 @param service 存的key
 @param data 存储的内容
 */
+ (void)save:(NSString *)service data:(id)data;

/**
 读取keychain

 @param service key
 @return key对应的内容
 */
+ (id)load:(NSString *)service;

/**
 删除keychain内容
 @param service 要删除的key
 */
+ (void)delete:(NSString *)service;
@end
