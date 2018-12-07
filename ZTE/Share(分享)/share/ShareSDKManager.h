
#import <Foundation/Foundation.h>
#import "ShareModel.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>


@interface ShareSDKManager : NSObject

+(instancetype)shareInstanceShareSDKManager;

@property(nonatomic,strong) BaseVC *baseVc;
@property (nonatomic, strong) ShareModel *shareModel;

/**
 *  初始化shareSDK的分享账号
 */
-(void)connectShareSDK;


/**
 *  展示分享视图
 *  @param model 分享的内容
 */
-(void)showShareInWindowByModel:(ShareModel *)model;

//海报分享
-(void)showSharePosterByModel:(ShareModel *)model;


-(void)createShortLink:(BOOL)flag andShareType:(ShareType)shareType url:(NSString *)url ;

-(void)hideOrShowPosterView;

//打开店铺首页更多的下拉列表
-(void)showHomeMoreView:(NSString *)isShopInfo;//NO为店铺信息  其他为店铺首页

@end
