//
//  BaseNetworkTool.m
//  直销通2.8.0
//
//  Created by mzh on 16/3/14.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "BaseNetworkTool.h"
#import "MyMD5.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"

@implementation BaseNetworkTool

+(instancetype)defaultNetwork{
    static BaseNetworkTool *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[[self class]alloc]init];
    });
    
    return instance;
}
- (void)loginNetworkPostWithURL:(NSString *)url params:(NSDictionary *)params isShowHud:(BOOL)hudShow currentVC:(BaseVC*)currentVC success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    AppDelegate *delegate = [AppDelegate globalDelegate];
    if (currentVC) {
        [delegate checkNetWorkWithCurrentVc:currentVC];
    }
    __block BOOL blokc_hudShow = hudShow;
    if (hudShow) {
        [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_SHOW_NOTI object:nil];
    }
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];    // 2.拼接url

    NSRange range = [url rangeOfString:@"http://"];
    if (range.location == NSNotFound) {
        url = [NSString stringWithFormat:@"%@%@",APP_URL,url];
    }
    
    NSMutableDictionary *dicts = [NSMutableDictionary dictionaryWithDictionary:params];
    //拼接基础参数
    
    //加密签名
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    NSString *str = @"";
    if ([[AppSingleton shareSingleton].loginNumber isEqualToString:TESTNUMBER]) {
        str = [NSString stringWithFormat:@"%@%@",currentTime,APP_SECRET_KEY_SHENHE];
    }else{
        str = [NSString stringWithFormat:@"%@%@",currentTime,APP_SECRET_KEY];
    }
    [dicts setObject:[MyMD5 md5:str] forKey:@"digest"];
    
    
    NSString *appkey ;
    if ([[AppSingleton shareSingleton].loginNumber isEqualToString:TESTNUMBER]) {
        appkey = @"100000035";
    }else{
        appkey = APP_ID;
    }
    //appkey
    [dicts setObject:appkey forKey:@"appkey"];
    
    //时间戳
    [dicts setObject:currentTime forKey:@"timestamp"];
    
    //版本
    [dicts setObject:@"ios" forKey:@"origin"];
    
    //用户token
    NSString *Webtoken = UDTakeData(@"token_UD");;
    
    
    NSString *token = nil;
    if (Webtoken == nil||[Webtoken isEqualToString:@""]) {
        token = @"";
    }else{
        token = Webtoken;
    }
    //对token码进行AES的CBC模式加密
//    NSString *tokenEncryptDate = [SecurityUtil encryptAESData:token];
    [dicts setObject:token forKey:@"token"];
    
    //版本号
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    appVersion=[appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    [dicts setObject:appVersion forKey:@"v"];
    
    //超时处理
    [self performSelector:@selector(Timeouthandling) withObject:[NSNumber numberWithBool:YES] afterDelay:30];
    
    // 3.发送请求
    [mgr POST:url parameters:dicts progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(Timeouthandling) object:[NSNumber numberWithBool:YES]];//取消超时处理。
        
        if (blokc_hudShow) {
            [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
        }
        //解析的网络数据
        //          NSString *jsonStr = classToJson(responseObject);
        NSDictionary *jsonDict = (NSDictionary *)responseObject;
        success(jsonDict);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(Timeouthandling) object:[NSNumber numberWithBool:YES]];//取消超时处理。
        if (failure) {
            if (blokc_hudShow) {
                [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
            }
            failure(error);
        }
    }];
}

- (void)BaseNetworkPostWithURL:(NSString *)url params:(NSDictionary *)params isShowHud:(BOOL)hudShow currentVC:(BaseVC*)currentVC success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    AppDelegate *delegate = [AppDelegate globalDelegate];
    if (currentVC) {
        [delegate checkNetWorkWithCurrentVc:currentVC];
    }
    __block BOOL blokc_hudShow = hudShow;
    if (hudShow) {
        [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_SHOW_NOTI object:nil];
    }
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 2.拼接url

    NSRange range = [url rangeOfString:@"http://"];
    if (range.location == NSNotFound) {
        url = [NSString stringWithFormat:@"%@%@",APP_URL,url];
    }
    
    if (params == nil) {
        params = [NSDictionary dictionary];
    }
    NSMutableDictionary *dicts = [NSMutableDictionary dictionaryWithDictionary:params];
    //拼接基础参数
    
    //加密签名
     NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"yyyyMMddHHmmss"];
     NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSString *str = @"";
    if ([[AppSingleton shareSingleton].loginNumber isEqualToString:TESTNUMBER]) {
        str = [NSString stringWithFormat:@"%@%@",currentTime,APP_SECRET_KEY_SHENHE];
    }else{
        str = [NSString stringWithFormat:@"%@%@",currentTime,APP_SECRET_KEY];
    }
    [dicts setObject:[MyMD5 md5:str] forKey:@"digest"];
    
    
    NSString *appkey ;
    if ([[AppSingleton shareSingleton].loginNumber isEqualToString:TESTNUMBER]) {
        appkey = @"100000035";
    }else{
        appkey = APP_ID;
    }
    //appkey
    [dicts setObject:appkey forKey:@"appkey"];
    
    //时间戳
    [dicts setObject:currentTime forKey:@"timestamp"];
   
    //版本
    [dicts setObject:@"ios" forKey:@"origin"];
    
    //用户token
    NSString *Webtoken = UDTakeData(@"token_UD");

    
    NSString *token = nil;
    if (Webtoken == nil||[Webtoken isEqualToString:@""]) {
        token = @"";
    }else{
        token = Webtoken;
    }
    //对token进行AES的CBC模式加密
//    NSString *tokenEncryptDate = [SecurityUtil encryptAESData:token];
    [dicts setObject:token forKey:@"token"];
    
    //版本号
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    appVersion=[appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    [dicts setObject:appVersion forKey:@"v"];
    
    //超时处理
    [self performSelector:@selector(Timeouthandling) withObject:[NSNumber numberWithBool:YES] afterDelay:30];
    
    if (url.length == 0) {
        url = @"";
    }
    
    // 3.发送请求
    [mgr POST:url parameters:dicts progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(Timeouthandling) object:[NSNumber numberWithBool:YES]];//取消超时处理。
        
        if (blokc_hudShow) {
            [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
        }
        //解析的网络数据
        NSDictionary *jsonDict = (NSDictionary *)responseObject;
        int isPass = [[jsonDict objectForKey:@"ResultCode"] intValue];
        NSString *messageStr = [jsonDict objectForKey:@"Message"];
        
        //1000  正常成功请求数据
        if (isPass == 1000) {
            if (success&&!([success isEqual:[NSNull null]]))
                success(responseObject);
            return ;
        }
        
        if (currentVC) {
            //              [currentVC requestErrUrl:url Data:responseObject];
        }
        //1009  登录失效
        if (isPass == 1009) {
            UDSaveData(@"0", @"isLogin");
            UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"登陆失效" message:@"尊敬的用户，您的本次登陆已经失效，需要您重新登录！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            alet.delegate = self;
            alet.tag = 1009;
            [alet show];
            return;
        }
        //6033  0元支付成功
        else if (isPass == 6033) {
            success(responseObject);
        }
        //1005  账户不存在
        else   if ([messageStr isEqualToString:@"账户不存在"]) {
            UDSaveData(@"0", @"isLogin");
            UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"登陆失效" message:@"尊敬的用户，您的账户不存在，需要您重新登录！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            alet.delegate = self;
            alet.tag = 1009;
            [alet show];
            return;
        }
        else  if (isPass != 1000) {
            //其他网络报错
            NSString *message = [jsonDict objectForKey:@"Message"];
            if ([currentVC isKindOfClass:[BaseVC class]]) {
                [SGInfoAlert showInfo:message inView:currentVC.view vertical:0.4];
                for (UIView * hudView in [AppDelegate globalDelegate].window.subviews) {
                    if ([hudView isKindOfClass:[MBProgressHUD class]]) {
                        [hudView setHidden:YES];
                    }
                }
            }
            if (failure) {
                failure(nil);
            }
            return;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(Timeouthandling) object:[NSNumber numberWithBool:YES]];//取消超时处理。
        if (failure) {
            if (blokc_hudShow) {
                [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
            }
            failure(error);
        }
    }];
}
/**
 *  超时处理
 */
-(void)Timeouthandling{
    [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
}
/**
 *获取当前的时间戳
 *@return Linux 标准时间戳 PS:1447140415
 */
-(NSString *)timeWithNowNSTimeInterval
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    long long int currentIntTime=(long long int)time;
    NSString *tempTime = [NSString stringWithFormat:@"%lld",currentIntTime];
    return tempTime;
}

/**
 *获取当前APP版本号
 *@return v 整形参数 PS:100
 */
-(NSString *)appNowVersion
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSArray *strArr = [appVersion componentsSeparatedByString:@"."];
    NSMutableString *v=[[NSMutableString alloc]init];
    for (int i =0; i<strArr.count; i++) {
        [v appendString:strArr[i]];
    }
    return v;
}
#pragma  mark  - 代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1009:
        {
        [[AppDelegate globalDelegate] goLoginVC];
        }
            break;
            
        default:
            break;
    }

}

@end
