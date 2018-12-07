//
//  PlayCarNetWorkManager.h
//  PlayCarParadise
//
//  Created by lius on 2017/11/7.
//  Copyright © 2017年 CarFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "BaseModel.h"
typedef void (^SuccesslBlock)(NSURLSessionDataTask *task, BaseModel *responeObj);
typedef void (^FailureBlock)(NSURLSessionDataTask *task, NSError* error);
typedef void (^JavaShopSuccesslBlock)(id data);
@interface PlayCarNetWorkManager :AFHTTPSessionManager
+ (instancetype)shared;//实例化网络请求工具类
/**
 GET请求
 
 @param URLString 请求地址
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestGET:(NSString *)URLString
        parameters:(id)parameters
           success:(SuccesslBlock)success
           failure:(FailureBlock)failure;

/**
 JavaShop GET请求
 
 @param URLString 请求地址（直接把请求参数拼接在地址后面）
 @param parameters 请求参数(直接把请求参数拼接在地址后面)
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestJavaShopGET:(NSString *)URLString
        parameters:(id)parameters
           success:(JavaShopSuccesslBlock)success
           failure:(FailureBlock)failure;


/**
 POST请求
 
 @param URLString 请求地址
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestPOST:(NSString *)URLString
         parameters:(id)parameters
            success:(SuccesslBlock)success
            failure:(FailureBlock)failure;
/**
 debugRequestPOST请求
 
 @param URLString 请求地址
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)debugRequestPOST:(NSString *)URLString
         parameters:(id)parameters
            success:(SuccesslBlock)success
            failure:(FailureBlock)failure;

/**
 请求系统时间戳
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestTimeStamp:(dispatch_block_t)success
                 failure:(dispatch_block_t)failure;

/**
 @param URLString 请求地址
 @param imageData 上次图片数据
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)uploadImage:(NSString *)URLString imageData:(NSData *)imageData parameters:(id)parameters
                    success:(SuccesslBlock)success
                    failure:(FailureBlock)failure;

/**

 @param URLString 请求地址
 @param videoData 上传视频数据
 @param parameters 请求参数
 @param progress 上传进度
 */
+ (void)uploadVideo:(NSString *)URLString videoData:(NSData *)videoData parameters:(id)parameters progress:(nullable void (^)(NSProgress * _Nonnull))progress
            success:(SuccesslBlock _Nullable )success
            failure:(FailureBlock _Nullable )failure;

+ (NSMutableDictionary *)signWithParameters:(id)parameters;

@end
