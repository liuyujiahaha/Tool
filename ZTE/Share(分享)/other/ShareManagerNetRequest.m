//
//  ShareManagerNetRequest.m
//  小移云店
//
//  Created by vivian on 2017/5/27.
//  Copyright © 2017年 vivian. All rights reserved.
//

#import "ShareManagerNetRequest.h"
#import "NewNetworkTool.h"

@implementation ShareManagerNetRequest

-(void)shareShopPage:(NSDictionary*)dict baseVC:(BaseVC *)base andSuccess:(dictionaryBlock)dataDictionary andFailure:(failureBlock)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@",STAT_SHARE];
    [[NewNetworkTool defaultNetwork] BaseNetworkPostWithURL:url params:dict isShowHud:NO currentVC:base success:^(id json) {
        int isPass = [[json objectForKey:@"returnCode"] intValue];
        if (isPass != 1000) {
            AlertWithMessage([json objectForKey:@"message"] );
            return ;
        }
        if (isPass == 1000) {
            if ([json isKindOfClass:[NSDictionary class]]){
                dataDictionary(json);
            }
        }else{
            [SGInfoAlert showInfo:validateString([json objectForKey:@"message"])];
        }
        
    } failure:^(NSError *error) {
    }];
}

-(void)createShortLink:(NSDictionary*)dict baseVC:(BaseVC *)base andSuccess:(dictionaryBlock)dataDictionary andFailure:(failureBlock)failure{
    NSString *url = [NSString stringWithFormat:@"%@",@"/moses/share/shortLink/generateShortLink"];
    [[NewNetworkTool defaultNetwork] BaseNetworkPostWithURL:url params:dict isShowHud:YES currentVC:base success:^(id json) {
        int isPass = [[json objectForKey:@"returnCode"] intValue];
        if (isPass != 1000) {
            AlertWithMessage([json objectForKey:@"message"] );
            return ;
        }
        if (isPass == 1000) {
            if ([json isKindOfClass:[NSDictionary class]]){
                dataDictionary(json);
            }
        }else{
            [SGInfoAlert showInfo:validateString([json objectForKey:@"message"])];
        }
        
    } failure:^(NSError *error) {
    }];
}

//-(void)quaryShortLink:(NSDictionary*)dict baseVC:(BaseVC *)base andSuccess:(dictionaryBlock)dataDictionary andFailure:(failureBlock)failure{
//    NSString *url = [NSString stringWithFormat:@"%@",QUARY_LINK];
//    [[NewNetworkTool defaultNetwork] BaseNetworkPostWithURL:url params:dict isShowHud:NO currentVC:base success:^(id json) {
//        int isPass = [[json objectForKey:@"returnCode"] intValue];
//        if (isPass != 1000) {
//            AlertWithMessage([json objectForKey:@"message"] );
//            return ;
//        }
//        if (isPass == 1000) {
//            if ([json isKindOfClass:[NSDictionary class]]){
//                dataDictionary(json);
//            }
//        }else{
//            [SGInfoAlert showInfo:validateString([json objectForKey:@"message"])];
//        }
//        
//    } failure:^(NSError *error) {
//    }];
//}
@end
