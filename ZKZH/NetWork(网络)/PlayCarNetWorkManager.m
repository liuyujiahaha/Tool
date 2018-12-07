//
//  PlayCarNetWorkManager.m
//  PlayCarParadise
//
//  Created by lius on 2017/11/7.
//  Copyright © 2017年 CarFun. All rights reserved.
//

#import "PlayCarNetWorkManager.h"
#import <CommonCrypto/CommonCrypto.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import "CommonConstants.h"
#import "NetworkingMacros.h"
#import "RedGuideView.h"
#import "CountriesAndRegionsTool.h"
#import "LanguageTool.h"

#import "PPNetworkHelper.h"

#define Timeout 30

@interface PlayCarNetWorkManager ()
/**
 系统时间差值
 */
@property (assign, nonatomic) long timestampAdjust;
@property (copy, nonatomic) dispatch_block_t block;
@end
@implementation PlayCarNetWorkManager
static PlayCarNetWorkManager *manager;
+ (instancetype)shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      manager = [[self alloc] init];
      manager.requestSerializer =  [AFHTTPRequestSerializer serializer];
      manager.requestSerializer.timeoutInterval = Timeout;//请求超时
      manager.timestampAdjust = LONG_MAX;
//      manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy; //缓存策略
      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];//支持类型
      
  });
    return manager;
}
#pragma mark - Public

+ (void)requestGET:(NSString *)URLString parameters:(id)parameters success:(SuccesslBlock)success failure:(FailureBlock)failure
{
    AFHTTPSessionManager *manager = [PlayCarNetWorkManager shared];
    __block NSDictionary *signparams = [PlayCarNetWorkManager signWithParameters:parameters];
    dispatch_block_t request = ^{
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                BaseModel *model = [BaseModel modelWithDict:responseObject];
                if ([model.code isEqualToString:@"40004"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NeedLoginNotification object:nil];
                    [UserLoginModel deleteModel];
                    return ;
                }
                success(task, model);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:iStoreLocalizedString(@"网络连接失败")];
            if (failure) {
                failure(task, error);
            }
        }];
    };
    if (!signparams) {
        [PlayCarNetWorkManager requestTimeStamp:^{
            signparams = [PlayCarNetWorkManager signWithParameters:parameters];
            request();
        } failure:^{
            
            if (failure) {
                failure(nil, nil);
            }
        }];
    }else {
        request();
    }
}

+(void)requestJavaShopGET:(NSString *)URLString parameters:(id)parameters success:(JavaShopSuccesslBlock)success failure:(FailureBlock)failure{
    AFHTTPSessionManager *manager = [PlayCarNetWorkManager shared];
    dispatch_block_t request = ^{
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                BaseModel *model = [BaseModel modelWithDict:responseObject];
                if ([model.code isEqualToString:@"40004"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NeedLoginNotification object:nil];
                    [UserLoginModel deleteModel];
                    return ;
                }
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:iStoreLocalizedString(@"网络连接失败")];
            if (failure) {
                failure(task, error);
            }
        }];
    };
    request();
}


+ (void)debugRequestPOST:(NSString *)URLString parameters:(id)parameters success:(SuccesslBlock)success failure:(FailureBlock)failure {
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [mdic setObject:@"1" forKey:@"debug"];
    [PlayCarNetWorkManager requestPOST:URLString parameters:mdic success:success failure:failure];
}
+ (void)requestPOST:(NSString *)URLString parameters:(id)parameters success:(SuccesslBlock)success failure:(FailureBlock)failure
{
    __block  NSDictionary *signparams = [PlayCarNetWorkManager signWithParameters:parameters];
    dispatch_block_t request = ^{
        //[liuyujia]2018年05月31日 基于AFN和YYCache优化的缓存机制 无网络情况下取缓存中的数据
        [PPNetworkHelper POST:URLString parameters:signparams responseCache:^(id responseCache) {
            //是否读取缓存
            if([PPNetworkHelper isNetwork]==NO){
                BaseModel *model = [BaseModel modelWithDict:responseCache];
                success(nil, model);
            }
        } success:^(id responseObject) {
            //请求成功
            BaseModel *model = [BaseModel modelWithDict:responseObject];
            [SVProgressHUD dismiss];
            
            if ([model.code isEqualToString:@"40004"]) {
                if ([URLString containsString:@"wallet/withdraw/withdraw-verify"]) {
                    /// 只有在这个接口返回40004的时候不是掉线通知,这里不作处理就行了
                } else {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NeedLoginNotification object:nil];
                    [UserLoginModel deleteModel];
                    for (UIViewController *viewController in [ToolsObject appDelegate].window.rootViewController.childViewControllers) {
                        if ([UIDevice currentDevice].systemVersion.doubleValue >= 10) {
                            [viewController.childViewControllers firstObject].tabBarItem.badgeColor = [UIColor clearColor];
                        }
                        
                        [viewController.childViewControllers firstObject].tabBarItem.badgeValue = @"";
                    }
                    failure(nil, nil);
                    return ;
                }
            }
            
            //余额提现的时候如果为40008要隐藏这个提示
            if ([model.code isEqualToString:@"40008"]) {
                success(nil,model);
                return;
            }
            
            ///START[liuyujia]2018年6月11日 因为在退款申请提交重复的时候返回的为40002，导致友好的提示不能显示出来，所以先注释
            /// 这里40004和上面的冲突了,后台又不能改,只能自己处理了
//            if ((model.code.integerValue <= 40008 && model.code.integerValue >= 40001) || model.code.integerValue == 40019 ) {
//                /// 支付密码错误等等这些是不需要弹提示框的
//                success(nil, model);
//                return;
//            }
            ///END[liuyujia]2018年6月11日 因为在退款申请提交重复的时候返回的为40002，导致友好的提示不能显示出来，所以先注释
            /* [chenyb 20180717]40038与40039手机注册相关的提示提醒,40033是微信未绑定专用的code
            
            //  [liuyujia]2018年7月7日 bug:2272 看了下代码，此处因为一些登录的时候有相关的特殊处理，所以这些需要提示的地方没有提示；

            if ([model.code isEqualToString:@"40033"] || [model.code isEqualToString:@"40039"] || [model.code isEqualToString:@"40038"]) {
                
                success(nil, model);
                return ;
            }
             */
            if ([model.code isEqualToString:@"40033"]) {
                success(nil, model);
                return ;
            }
            //为避免与下面黑色提示框冲突，页面出现两个提示框，绑定银行卡页面增加这两个专门的code
            if ([model.code isEqualToString:@"50000"] || [model.code isEqualToString:@"50001"] || [model.code isEqualToString:@"50002"]) {
                success(nil, model);
                return ;
            }
            // 支付密码错误、密码错误次数过多 在聊天室不需要弹框
            if ([model.code isEqualToString:@"42001"] || [model.code isEqualToString:@"42002"]) {
                success(nil, model);
                return ;
            }
            if ([model.code isEqualToString:@"200"]) {
                if (success) {
                    success(nil, model);
                }
                
                if ([model.data[@"red"] count] > 0) {//有红包数据返回时弹出领取红包界面
                    RedBagHistoryDataModel *redModel = [RedBagHistoryDataModel mj_objectWithKeyValues:model.data[@"red"]];
                    RedView *redView = [RedView creatRedView];
                    redView.model = redModel;
                    
                    //暂时先隐藏，等后续提供了相应的iOS引导图片再打开  判断是否首次显示红包 若为首次显示红包则显示导引
                    /*BOOL isFIrst = [UDTakeData(kIsFirstRed) boolValue];
                     if (!isFIrst) {
                     RedGuideView *guideView = [[RedGuideView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                     [guideView show];
                     UDSaveData(@"1", kIsFirstRed);
                     }*/
                }
            } else {
                [SVProgressHUD showInfoWithStatus:model.message];
                success(nil, model);
            }
        } failure:^(NSError *error) {
            //请求失败
            NSLog(@"%@",error.userInfo);
            [SVProgressHUD showErrorWithStatus:iStoreLocalizedString(@"网络连接失败")];
            if (failure) {
                failure(nil, error);
            }
        }];
        
    };
    
    if(PPNetworkHelper.isNetwork == NO){
        request();
    }else{
        if (!signparams) {
            [PlayCarNetWorkManager requestTimeStamp:^{
                signparams = [PlayCarNetWorkManager signWithParameters:parameters];
                request();
            } failure:^{
                if (failure) {
                    [SVProgressHUD showErrorWithStatus:iStoreLocalizedString(@"网络连接失败")];
                    failure(nil, nil);
                }
            }];
        }else {
            request();
        }
    }
}
+ (void)requestTimeStamp:(dispatch_block_t)success failure:(dispatch_block_t)failure
{
    AFHTTPSessionManager *manager = [PlayCarNetWorkManager shared];
    manager.requestSerializer.timeoutInterval = Timeout;
    [manager POST:LS_TimeStamp parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BaseModel *model = [BaseModel modelWithDict:responseObject];
        if ([model.code isEqualToString:@"200"]) {
            // 计算本地时间与系统时间之间的时间差
            long networking = [model.data longValue];
            NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
            long local = (long)(time * 1000);
            long adjust = networking - local;
            PlayCarNetWorkManager *mgr = [PlayCarNetWorkManager shared];
            mgr.timestampAdjust = adjust;
            if (success) {
                success();
            }
        }else {
            if (failure) {
                failure();
            }
            [PlayCarNetWorkManager requestTimeStampErrorHandle];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.userInfo[@"NSLocalizedDescription"]);
        [SVProgressHUD showErrorWithStatus:iStoreLocalizedString(@"无法连接服务器")];
        if (failure) {
            failure();
        }
        [PlayCarNetWorkManager requestTimeStampErrorHandle];
    }];
}
+ (void)uploadImage:(NSString *)URLString imageData:(NSData *)imageData parameters:(id)parameters
            success:(SuccesslBlock)success
            failure:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [PlayCarNetWorkManager shared];
    __block  NSDictionary *signparams = [PlayCarNetWorkManager signWithParameters:parameters];
    dispatch_block_t request = ^{
        NSString *url = [NSString stringWithFormat:@"%@?sign=%@&timestamp=%@&userId=%@&file=""",URLString,signparams[@"sign"],signparams[@"timestamp"],signparams[@"userId"]];
        [manager POST:url parameters:signparams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //使用日期生成图片名称
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            if ([signparams[@"file"] isEqualToString:@"gif"]) {
                NSString *fileName = [NSString stringWithFormat:@"%@.gif",[formatter stringFromDate:[NSDate date]]];
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/gif"];
            }else{
                NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",[formatter stringFromDate:[NSDate date]]];
                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //打印上传进度
            CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            BaseModel *model = [BaseModel modelWithDict:responseObject];
            if ([model.code isEqualToString:@"40004"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NeedLoginNotification object:nil];
                [UserLoginModel deleteModel];
                return ;
            }
            if ([model.code isEqualToString:@"200"]) {
                if (success) {
                    success(task, model);
                }
            }else {
                success(task, model);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.userInfo);
            [SVProgressHUD showErrorWithStatus:iStoreLocalizedString(@"网络连接失败")];
            if (failure) {
                failure(task, error);
            }
        }];
    };
    if (!signparams) {
        [PlayCarNetWorkManager requestTimeStamp:^{
            signparams = [PlayCarNetWorkManager signWithParameters:parameters];
            request();
        } failure:^{
            if (failure) {
                failure(nil, nil);
            }
        }];
    }else {
        request();
    }
}

+ (void)uploadVideo:(NSString *)URLString videoData:(NSData *)videoData parameters:(id)parameters progress:(nullable void (^)(NSProgress * _Nonnull))progress
            success:(SuccesslBlock)success
            failure:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [PlayCarNetWorkManager shared];
    __block  NSDictionary *signparams = [PlayCarNetWorkManager signWithParameters:parameters];
    dispatch_block_t request = ^{
        NSString *url = [NSString stringWithFormat:@"%@?sign=%@&timestamp=%@&userId=%@&file=""",URLString,signparams[@"sign"],signparams[@"timestamp"],signparams[@"userId"]];
        [manager POST:url parameters:signparams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //使用日期生成视频名称
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *fileName = [NSString stringWithFormat:@"%@.mp4",[formatter stringFromDate:[NSDate date]]];
            [formData appendPartWithFileData:videoData name:@"file" fileName:fileName mimeType:@"video/mp4"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //打印上传进度
            //CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            BaseModel *model = [BaseModel modelWithDict:responseObject];
            if ([model.code isEqualToString:@"40004"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NeedLoginNotification object:nil];
                [UserLoginModel deleteModel];
                return ;
            }
            if ([model.code isEqualToString:@"200"]) {
                if (success) {
                    success(task, model);
                }
            }else {
                success(task, model);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error.userInfo[@"NSLocalizedDescription"]);
            [SVProgressHUD showErrorWithStatus:iStoreLocalizedString(@"网络连接失败")];
            if (failure) {
                failure(task, error);
            }
        }];
    };
    if (!signparams) {
        [PlayCarNetWorkManager requestTimeStamp:^{
            signparams = [PlayCarNetWorkManager signWithParameters:parameters];
            request();
        } failure:^{
            if (failure) {
                failure(nil, nil);
            }
        }];
    }else {
        request();
    }
}

+ (void)handleTimeStampError:(dispatch_block_t)handle
{
    PlayCarNetWorkManager *manager = [PlayCarNetWorkManager shared];
    manager.block = handle;
}

#pragma mar - Private
//参数签名
+ (NSMutableDictionary *)signWithParameters:(id)parameters
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param addEntriesFromDictionary:parameters];
    long proofread = [PlayCarNetWorkManager proofreadLocaTimeStamp];
    
    if(PPNetworkHelper.isNetwork == YES){
        if (proofread == -1) return nil;
    }
    NSString *timeStamp = [NSString stringWithFormat:@"%ld", proofread];
    NSString *langStr = [LanguageTool getLanguageStr];
    NSString *locationStr = [CountriesAndRegionsTool returnNationId];
    NSString *tokenStr = [UserLoginModel userModel].token?[UserLoginModel userModel].token:@"";

    //公共参数
    [param setObject:timeStamp forKey:@"timestamp"];            //时间戳
    [param setObject:langStr forKey:@"lang"];                   //语言
    [param setObject:locationStr forKey:@"nationId"];           //地区
    [param setObject:tokenStr forKey:@"token"];                 //token

    NSArray *keys = [param allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];//[liuyujia] 2018年7月24 由忽略大小写改成大小写敏感
    }];
    NSMutableString *keyValue = [NSMutableString stringWithString:HostAppKey];
    for (NSString *key in sortedKeys) {
        [keyValue appendString:key];
        NSString *value = [NSString stringWithFormat:@"%@", [param objectForKey:key]];
        [keyValue appendString:value];
    }
    NSString *md5Str = [[PlayCarNetWorkManager md5:keyValue] uppercaseString];
    [param setObject:md5Str forKey:@"sign"];
    return param;
}

//MD5加密
+ (NSString *)md5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//校验本地时间(校验失败 返回-1)
+ (long)proofreadLocaTimeStamp
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long localTime = (long)(time * 1000);
    PlayCarNetWorkManager *manager = [PlayCarNetWorkManager shared];
    long proofreadTime;
    if (manager.timestampAdjust != LONG_MAX) {
        proofreadTime = localTime + manager.timestampAdjust;
    }else {
        proofreadTime = -1;
    }
    return proofreadTime;
}
/// 请求系统时间戳失败处理
+ (void)requestTimeStampErrorHandle
{
    PlayCarNetWorkManager *mgr = [PlayCarNetWorkManager shared];
    mgr.timestampAdjust = LONG_MAX;
    [[NSNotificationCenter defaultCenter] postNotificationName:RequestManagerTimeStampErrorNotification object:mgr];
    if (mgr.block) {
        mgr.block();
    }
}
@end
