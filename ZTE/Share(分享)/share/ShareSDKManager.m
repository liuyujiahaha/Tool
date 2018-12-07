
#import "ShareSDKManager.h"
#import "SynthesisView.h"

#import "YXApi.h"

#import "ShareManagerNetRequest.h"
#import "EditStoreNetRequest.h"
#import "NewNetworkTool.h"
#import "ShopNetRequest.h"
#import "MyStoreModel.h"
#import "ShareModel.h"
#import "NetApiDefine.h"

#import "StoreQrCodeVC.h"
#import "PosterVC.h"

@interface ShareSDKManager()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *shareView;
@property (nonatomic, strong) UIView *blackMaskView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong)  WPButton *cancelBtn;

@property (nonatomic, strong) NSMutableArray *subControlDatamutArr;
@property (nonatomic, strong) NSMutableArray *subPosterDatamutArr;
@property (nonatomic, assign) BOOL shareViewHide;
@property (nonatomic, strong)  UILabel *tipLab;

@property (nonatomic, strong) UIView *sharePosterView;//海报
@property (nonatomic, assign) BOOL sharePosterHide;


//店铺首页导航栏点击更多下拉页面
@property (nonatomic, strong) UIView *bgView;//背景图片
@property (nonatomic, strong) UIImageView *homeMoreView;//更多下拉页面

@end

@implementation ShareSDKManager

+(instancetype)shareInstanceShareSDKManager
{
    static ShareSDKManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ShareSDKManager alloc] init];
    });
    return instance;
}


#pragma 分享的相关配置
-(void)connectShareSDK
{
    [ShareSDK registerApp:@""];
    //微信Connection
    NSString *appId = @"wxff6a80ff8c8ab7a7";
    [ShareSDK connectWeChatSessionWithAppId:appId wechatCls:[WXApi class]];
    [ShareSDK connectWeChatTimelineWithAppId:appId wechatCls:[WXApi class]];
    
    //QQ空间
    [ShareSDK connectQZoneWithAppKey:@"1104288821"
                           appSecret:@"KSIH8hPxsMryOmmr"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    
    [ShareSDK connectQQWithQZoneAppKey:@"1104288821"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    //新浪微博
    [ShareSDK connectSinaWeiboWithAppKey:@"4081947064"
                               appSecret:@"5dfe9962ea9bbc31ac85d285333cc21e"
                             redirectUri:@"https://api.weibo.com/oauth2/default.html"
                             weiboSDKCls:[WeiboSDK class]];

   
    [ShareSDK connectSMS];
 
    [ShareSDK connectDoubanWithAppKey:@"0053c9bae2d2529800fb5d30a876f7c8"
                            appSecret:@"956423b7230d0fb5"
                          redirectUri:@"http://vpclub.octech.com.cn/"];
    
    [ShareSDK connectYiXinWithAppId:@"yx2e0c281434ae463688bba58a7016e313"
                           yixinCls:[YXApi class]];

    [self initRefrence];
}

#pragma mark -- 去分享
- (void)shareWithShareType :(ShareType)shareType{
    SSPublishContentMediaType mediaType = SSPublishContentMediaTypeNews;

    if (self.shareModel.shareImage) {
        mediaType = SSPublishContentMediaTypeImage;
        if (shareType == ShareTypeQQSpace) {
            [SGInfoAlert showInfo:@"QQ空间暂不支持海报分享"];
            return;
        }
    }
    
    UIImage *img = self.shareModel.shareImage ? self.shareModel.shareImage:[UIImage imageNamed:@"180"];
    if (self.shareModel.image300300.length == 0) {
        self.shareModel.image300300 = nil;
    }
    
    id<ISSContent> publishContent = [ShareSDK content:self.shareModel.shareContent
                                       defaultContent:self.shareModel.shareContent
                                                image:self.shareModel.image300300 ? [ShareSDK imageWithUrl:self.shareModel.image300300] : [ShareSDK pngImageWithImage:img]
                                                title:self.shareModel.shareTitle
                                                  url:self.shareModel.shareUrl
                                          description:@"分享"
                                            mediaType:mediaType];
    @VPWeakObj(self);
    [ShareSDK shareContent:publishContent
                      type:shareType
               authOptions:nil
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        @VPStrongObj(self);
                        if (state == SSPublishContentStateSuccess)
                        {
                            if (shareType == ShareTypeWeixiSession || shareType == ShareTypeWeixiTimeline || shareType == ShareTypeQQSpace || shareType == ShareTypeQQ) {
                                [self shareSuccessRequest];
                            }
                            [SGInfoAlert showInfo:@"分享成功"];

                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            [SGInfoAlert showInfo:@"分享失败"];
                            
                        }else if(state == SSResponseStateCancel)
                        {
                        }
                    }];
}

#pragma 方法区

- (void)initRefrence
{
    self.shareViewHide = YES;
    self.sharePosterHide = YES;
    //普通分享
    UIWindow *window = [AppDelegate globalDelegate].window;
    [window addSubview:self.backView];
    self.backView.hidden = YES;
    //海报分享
    [window addSubview:self.sharePosterView];
    self.sharePosterView.hidden = YES;
    
    [self.backView addSubview:self.blackMaskView];
    [self.backView addSubview:self.shareView];
    [self.shareView addSubview:self.cancelBtn];
    [self.shareView addSubview:self.line2];
    
    [self addConstrains];
    [self initData];
    //普通分享
    [self creatSubControlForShareView];
    
    //海报分享
    [self creatSubControlForSharePoster];
    
}


-(void)hiddenShareView:(UITapGestureRecognizer *)sender
{
    [self hideOrShowShareView];
}

//显示或隐藏分享视图
- (void)hideOrShowShareView
{
    self.shareViewHide = !self.shareViewHide;
    if (!self.shareViewHide) {
        self.backView.hidden =  self.shareViewHide;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        if (self.shareViewHide) {
            [_shareView updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.backView.bottom);
            }];
        }else
        {
            [_shareView updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.backView.bottom).offset(-114*layoutBy6() - 43*layoutBy6());
            }];
            
            [_cancelBtn updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.shareView);
                make.top.mas_equalTo(_shareView.bottom);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(43*layoutBy6());
            }];
        }
        [_shareView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.shareViewHide) {
            self.backView.hidden =  self.shareViewHide;
        }
    }];
}

- (void)cancelBtnClicked
{
    [self hideOrShowShareView];
}


#pragma mark - 显示更多下拉页面
/**
 1.二维码
 2.分享
 3.海报
 4.编辑
 */
-(void)showHomeMoreView:(NSString *)isShopInfo{
    [self gainShareContentRequest:isShopInfo];
    [[AppSingleton shareSingleton].window addSubview:self.bgView];
    [self.bgView addSubview:self.homeMoreView];
}

#pragma mark - 隐藏更多下拉页面
-(void)hideHomeMoreViewAction{
    [self.bgView removeFromSuperview];
}


#pragma mark -- 调起分享界面
/*
 功能：调起分享界面
 参数：
 1.model = nil，去请求接口获取分享data，一般是店铺的分享,shareType = 2，分享成功调分享统计的接口；
 2.moddel != nil，并且shareType = 2，是h5的分享，分享成功调分享统计的接口
 
 //1专区，2店铺，3业务
 */
-(void)showShareInWindowByModel:(ShareModel *)model
{
    if (model == nil) {
        //店铺分享
        [self gainShareContentRequest:@""];
    }else  { // || [model.shareType integerValue] == 3){
        //h5分享
        if (model.shareTitle.length == 0) {
            model.shareTitle = @"好东西不忍独享，推荐给大家！";
        }
        if (model.shareContent.length == 0) {
            model.shareContent = @"这个简直太赞了！";
        }
        
        self.shareModel = model;
        self.shareModel.shareUrl = [[AppSingleton shareSingleton] convertLinkWithParameter:self.shareModel.shareUrl];
        
        self.backView.hidden = NO;
        UIWindow *window = [AppDelegate globalDelegate].window;
        [window bringSubviewToFront:self.backView];
        [self hideOrShowShareView];
    }
}

-(void)showSharePosterByModel:(ShareModel *)model{
    //海报分享
    self.shareModel = model;
    
//    self.sharePosterView.hidden = NO;
//    UIWindow *window = [AppDelegate globalDelegate].window;
//    [window bringSubviewToFront:self.sharePosterView];
//    [self hideOrShowPosterView];
    self.backView.hidden = NO;
    UIWindow *window = [AppDelegate globalDelegate].window;
    [window bringSubviewToFront:self.backView];
    [self hideOrShowShareView];
}

//海报的分享界面显示和隐藏
-(void)hideOrShowPosterView{
    self.sharePosterHide = !self.sharePosterHide;
    if (!self.sharePosterHide) {
        self.sharePosterView.hidden =  self.sharePosterHide;
    }
     UIWindow *window = [AppDelegate globalDelegate].window;
    [UIView animateWithDuration:0.2 animations:^{
        if (self.sharePosterHide) {
            [_sharePosterView updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(window.bottom);
            }];
        }else
        {
            [_sharePosterView updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(window.bottom).offset(-95*layoutBy6());
            }];
        }
        [_sharePosterView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.sharePosterHide) {
            self.sharePosterView.hidden =  self.sharePosterHide;
        }
    }];
}

#pragma mark -- ##网络请求
/*
 功能：获取分享的内容,共用查询店铺的接口
 参数：isShare，获取分享的时候才需要传的参数，2
*/
-(void)gainShareContentRequest:(NSString *)isShopInfo{
    //店铺id
    NSString *strId = UDTakeData(kDefaultUserId) ?  :@"";
    //[AppSingleton shareSingleton].loginModel.user.shopId?[AppSingleton shareSingleton].loginModel.user.shopId:@"";
    NSDictionary *dict = @{@"id":strId,
                           @"isShare":@"2"};

//    NSString *url = QUARY_STOREINFO; 
    NSString *url = kQueryShopByUserId;
    @VPWeakObj(self);
    [[NewNetworkTool defaultNetwork] BaseNetworkPostWithURL:url params:dict isShowHud:NO currentVC:nil success:^(id json) {
        int isPass = [[json objectForKey:@"returnCode"] intValue];
        if (isPass != 1000) {
            AlertWithMessage([json objectForKey:@"message"] );
            return ;
        }

        if (isPass == 1000) {
            if ([json isKindOfClass:[NSDictionary class]]){
                NSDictionary *dic = [json objectForKey:@"dataInfo"];
                @VPStrongObj(self);
                MyStoreModel *data = [MyStoreModel modelObjectWithDictionary:dic];
                /*1.分享标题； name
                 2.分享内容； description
                 3.分享链接；  shopUrl
                 4.分享图片url： logo*/
                
                ShareModel *model = [[ShareModel alloc] init];
                model.shareTitle =  data.name;
                model.shareImageUrl = data.background;
                model.image300300 = data.logo;
                model.shareContent = data.internalBaseClassDescription;
                
                if ([isShopInfo isEqualToString:@"YES"]) {
                    //店铺信息
                    NSString *shareUrlStr = [NSString stringWithFormat:@"%@%@",APP_URL,STORE_INFO];
                    shareUrlStr = [[AppSingleton shareSingleton]convertLinkWithParameter:shareUrlStr];
                    model.shareUrl = shareUrlStr;
                    
                    
                }else{
                    //店铺首页
                    NSString *shareUrlStr = [NSString stringWithFormat:@"%@%@",APP_URL,STORE_SHARE];
                    shareUrlStr = [[AppSingleton shareSingleton]convertLinkWithParameter:shareUrlStr];
                    model.shareUrl = shareUrlStr;
                    
                }
                
                model.dataID = data.internalBaseClassIdentifier;
                model.shareType = @"2";
                model.sellPrice = @"";
                
                if (model.shareTitle.length == 0) {
                    model.shareTitle = @"小移云店，朋友圈里的移动折扣店！";
                }
                if (model.shareContent.length == 0) {
                    model.shareContent = @"充话费，买流量，挑手机，办业务，戳进来逛逛吧，优惠多多哦~";
                }
                
                NSString *url = [[AppSingleton shareSingleton] convertLinkWithParameter:model.shareUrl];
                //环境( 0: 工作台; 1: 店铺; 2: 分享链接办理; 3: 二维码办理; 4: 海报办理; 5: 其它 )
                NSString *environment = @"2";
                url = [NSString stringWithFormat:@"%@&environment=%@",url,environment];
                model.shareUrl = url;
                self.shareModel = model;
                
                [self createShortLink:YES andShareType:1 url:model.shareUrl];
                
            }
        }else{
            [SGInfoAlert showInfo:[json objectForKey:@"message"]];
        }
        
    } failure:^(NSError *error) {
    }];

}

//分享成功之后调取接口
/*功能：分享统计
 itemType:专区，1
          店铺，2
          业务包，3
 
 itemId：专区id，店铺id，业务包id
 orgId :机构id
 destination:QQ：qq 微信：wechat
 sysType：系统类型，1:IOS版本 2:Android版本
 */
-(void)shareSuccessRequest
{
    NSString *itemType = self.shareModel.shareType?self.shareModel.shareType:@"";
    NSString *itemId = self.shareModel.dataID?self.shareModel.dataID:@"";
    NSString *shareTitle = self.shareModel.shareTitle?self.shareModel.shareTitle:@"";
    NSString *shareContent = self.shareModel.shareContent?self.shareModel.shareContent:@"";
    NSString *orgId = [AppSingleton shareSingleton].loginData.orgId ? [AppSingleton shareSingleton].loginData.orgId :@"";
    NSString *destination = self.shareModel.shareToPlat?self.shareModel.shareToPlat:@"";
    
    NSDictionary *dict = @{@"itemType":itemType,
                           @"itemId":itemId,
                           @"shareTitle":shareTitle,
                           @"shareContent":shareContent,
                           @"orgId":orgId,
                           @"destination":destination,
                           @"sysType":@"1"};
    NSLog(@"分享统计：%@",dict);
    ShareManagerNetRequest *request = [[ShareManagerNetRequest alloc]init];
    [request shareShopPage:dict baseVC:nil andSuccess:^(NSDictionary *dataDictionary) {
    } andFailure:^(NSString *failureMessage) {
    }];
}

/*生成短链*/
//flag为yes的话去分享,qq生成短链分享
/*2017-09-09
 问题：由于h5链接分享到qq好友，会被qq强制添加appinstall=0的参数，而且位置不定，导致h5链接无法打开；
 解决：qq分享时通过将链接生成短链再分享出去
 */
-(void)createShortLink:(BOOL)flag andShareType:(ShareType)shareType url:(NSString *)url  {
//    NSString *strId = [AppSingleton shareSingleton].loginData.internalBaseClassIdentifier?[AppSingleton shareSingleton].loginData.internalBaseClassIdentifier:@"";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", APP_URL, @"/moses/share/"];
    
    NSDictionary *dict = @{@"link":url,
                           @"createdBy": UDTakeData(kDefaultUserId),
                           @"host": urlStr
                           
                           };
    
    @VPWeakObj(self);
    ShareManagerNetRequest *request = [[ShareManagerNetRequest alloc]init];
    [request createShortLink:dict baseVC:nil andSuccess:^(NSDictionary *dataDictionary) {
        @VPStrongObj(self);
        if ([dataDictionary isKindOfClass:[NSDictionary class]]) {
            NSString *link = validateString([dataDictionary objectForKey:@"dataInfo"]);
            
            self.shareModel.shareUrl = link;
            
            
//            if (flag) {
//                self.shareModel.shareUrl = link;
//                 [self shareWithShareType:shareType];
//            }else{
//                [SGInfoAlert showInfo:@"短链复制到剪切板了"];
//            }
            
            
        }
    } andFailure:^(NSString *failureMessage) {
    }];
}

//

#pragma mark -- 点击分享项
-(void)creatSubControlForShareView
{
    SynthesisView *synthesisView = nil;
    NSMutableArray *synthesisViewMutArr = [NSMutableArray array];
    for (int i =0 ;i<self.subControlDatamutArr.count;i++) {
        
        NSDictionary *dataDic = [self.subControlDatamutArr objectAtIndex:i];
        NSString *iconName = [dataDic objectForKey:@"icon"];
        NSString *tipStr = [dataDic objectForKey:@"tipStr"];
        
        synthesisView = [[SynthesisView alloc]initWitIconName:iconName tipStr:tipStr fixWidth:SCREEN_WIDTH/4 fontSize:12*layoutBy6() tipStrColor:hexStringToColor(@"#333333")];
        @VPWeakObj(self);
        synthesisView.tapSelfBlock=^(NSInteger tapType){
            @VPStrongObj(self);
            if (tapType == 6) {
                //二维码
                self.shareModel.shareUrl = [self shareLinkWithEnvironment:@"3"];//二维码办理
                StoreQrCodeVC *vc = [[StoreQrCodeVC alloc]init];
                vc.url = self.shareModel.shareUrl;
                vc.imgUrl = self.shareModel.image300300;
                vc.titleStr = self.shareModel.shareTitle;
                [self.baseVc push:vc animation:YES andNotHiddenTabbar:YES];
                
            }else if (tapType == 7){
                NSLog(@"海报");
                //海报
                self.shareModel.shareUrl = [self shareLinkWithEnvironment:@"4"];
                PosterVC *vc = [[PosterVC alloc]init];
                vc.model = self.shareModel;
                [self.baseVc push:vc animation:YES andNotHiddenTabbar:YES];
            }else if(tapType == 8){
            
                NSLog(@"短链复制");
                self.shareModel.shareUrl = [self shareLinkWithEnvironment:@"5"];
//                [self createShortLink:NO andShareType:0 url:nil];
                
            }else{
                //分享链接办理
                self.shareModel.shareUrl = [self shareLinkWithEnvironment:@"2"];
                ShareType shareType;
                switch (tapType) {
                    case 1:
                    {
                        if (![WXApi isWXAppInstalled]) {
                            [SGInfoAlert showInfo:@"您没有安装客户端"];
                            return;
                        }
                        shareType = ShareTypeWeixiSession;
                        self.shareModel.shareToPlat = @"wechat";
                    }
                        break;
                    case 2:{
                        if (![WXApi isWXAppInstalled]) {
                            [SGInfoAlert showInfo:@"您没有安装客户端"];
                            return;
                        }
                        shareType = ShareTypeWeixiTimeline;
                        self.shareModel.shareToPlat = @"wechat";
                    }
                        break;
                    case 3:{
                        if (![QQApiInterface isQQInstalled]) {
                            [SGInfoAlert showInfo:@"您没有安装客户端"];
                            return;
                        }
                        shareType = ShareTypeQQSpace;
                        self.shareModel.shareToPlat = @"qq";
                    }
                        break;
                    case 4:{
                        if (![QQApiInterface isQQInstalled]) {
                            [SGInfoAlert showInfo:@"您没有安装客户端"];
                            return;
                        }
                        shareType = ShareTypeQQ;
                        self.shareModel.shareToPlat = @"qq";
//                        [self createShortLink:YES andShareType:shareType];
                        return;
                    }
                        break;
                    case 5:
                        shareType = ShareTypeSMS;
                        self.shareModel.shareContent =[NSString stringWithFormat:@"%@%@",self.shareModel.shareContent,self.shareModel.shareUrl];
                        break;
                        
                    default:
                        break;
                }
                [self shareWithShareType:shareType];
            }
            [self hideOrShowShareView];
        };
        synthesisView.tapType = i+1;
        [synthesisViewMutArr addObject:synthesisView];
        [self.shareView addSubview:synthesisView];
    }
    [self addSubControlConstrain:synthesisViewMutArr];
}

-(NSString*)shareLinkWithEnvironment:(NSString*)environment{
    NSString *url = self.shareModel.shareUrl;
    NSRange range = [url rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        url = [NSString stringWithFormat:@"%@?",url];
    }
    
    NSRange enRange = [url rangeOfString:@"&environment="];
    if (enRange.location != NSNotFound) {
        url = [url stringByReplacingCharactersInRange:NSMakeRange(enRange.location, enRange.length+1) withString:@""];
    }
    
    url = [NSString stringWithFormat:@"%@&environment=%@",url,environment];
    return url;
}

-(void)creatSubControlForSharePoster{
    SynthesisView *synthesisView = nil;
    NSMutableArray *synthesisViewMutArr = [NSMutableArray array];
    for (int i =0 ;i<self.subPosterDatamutArr.count;i++) {
        
        NSDictionary *dataDic = [self.subPosterDatamutArr objectAtIndex:i];
        NSString *iconName = [dataDic objectForKey:@"icon"];
        NSString *tipStr = [dataDic objectForKey:@"tipStr"];
        
        synthesisView = [[SynthesisView alloc]initWitIconName:iconName tipStr:tipStr fixWidth:SCREEN_WIDTH/4 fontSize:11*layoutBy6() tipStrColor:hexStringToColor(@"#6F6F6F")];
        synthesisView.tapSelfBlock=^(NSInteger tapType){
            if (tapType == 4) {
                //本地保存图片
                UIImageWriteToSavedPhotosAlbum(self.shareModel.shareImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            }else{
                ShareType shareType;
                switch (tapType) {
                    case 1:
                        shareType = ShareTypeWeixiSession;
                        self.shareModel.shareToPlat = @"wechat";
                        break;
                    case 2:
                        shareType = ShareTypeWeixiTimeline;
                        self.shareModel.shareToPlat = @"wechat";
                        break;
                    case 3:
                        shareType = ShareTypeQQ;
                        self.shareModel.shareToPlat = @"qq";
//                        [self createShortLink:YES andShareType:shareType];
                        return;
                        break;
                    default:
                        break;
                }
                [self shareWithShareType:shareType];
            }
        };
        synthesisView.tapType = i+1;
        [synthesisViewMutArr addObject:synthesisView];
        [self.sharePosterView addSubview:synthesisView];
    }
    [self addSubPosterConstrain:synthesisViewMutArr];
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"本地保存失败" ;
        [SGInfoAlert showInfo:msg];
    }else{
        msg = @"本地保存成功" ;
        [SGInfoAlert showInfo:msg];
    }
}

#pragma mark -- 初始化UI
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.hidden = YES;
    }
    return _backView;
}

- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]init];
        _shareView.backgroundColor = hexStringToColor(@"f8f8f8");
    }
    return _shareView;
}

- (UIView *)blackMaskView
{
    if (!_blackMaskView) {
        _blackMaskView = [[UIView alloc]init];
        _blackMaskView.backgroundColor = [UIColor blackColor];
        _blackMaskView.alpha = 0.5;
        UITapGestureRecognizer *hiddenView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenShareView:)];
        [_backView addGestureRecognizer:hiddenView];
    }
    return _blackMaskView;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = hexStringToColor(@"#DDDDDD");
    }
    return _line;
}

- (UIView *)line2
{
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = hexStringToColor(@"#DDDDDD");
    }
    return _line2;
}

- (WPButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[WPButton alloc]init];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:hexStringToColor(@"414141") forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15*layoutBy6()];
        _cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UILabel*)tipLab{
    if (!_tipLab) {
        _tipLab = [[UILabel alloc]init];
        _tipLab.textColor = hexStringToColor(@"666666");
        _tipLab.font = [UIFont systemFontOfSize:14*layoutBy6()];
        _tipLab.text = @"分享到";
        _tipLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLab;
}

-(UIView*)sharePosterView{
    if (!_sharePosterView) {
        _sharePosterView = [[UIView alloc]init];
        _sharePosterView.backgroundColor = hexStringToColor(@"FFFFFF");
    }
    return _sharePosterView;
}

#pragma 添加约束
- (void)addConstrains{
    UIWindow *window = [AppDelegate globalDelegate].window;
   [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.mas_equalTo(window);
   }];
    
    [_sharePosterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(window);
        make.top.mas_equalTo(window.bottom);
        make.width.mas_equalTo(window);
        make.height.mas_equalTo(95*layoutBy6());
    }];

    
    [_blackMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.backView);
    }];
    
   [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.backView);
       make.top.mas_equalTo(self.backView.bottom);
       make.width.mas_equalTo(self.backView);
       make.height.mas_equalTo(114*layoutBy6());
   }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shareView);
        make.top.mas_equalTo(_shareView.bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(43*layoutBy6());
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12*layoutBy6());
        make.top.mas_equalTo(_cancelBtn.top).offset(-1*layoutBy6());
        make.width.mas_equalTo(SCREEN_WIDTH - 24*layoutBy6());
        make.height.mas_equalTo(0.5);
    }];
}

- (void)addSubControlConstrain :(NSMutableArray *)synthesisViewMutArr
{
    for (int i =0 ;i<synthesisViewMutArr.count;i++) {
        SynthesisView *synthesisView = [synthesisViewMutArr objectAtIndex:i];
      
        [synthesisView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i<4) {//第一行
                make.left.mas_equalTo(i*SCREEN_WIDTH/4);
                make.top.mas_equalTo(self.shareView).offset(15*layoutBy6());
            }
            else
            {//第二行
                make.left.mas_equalTo((i-4)*SCREEN_WIDTH/4);
                make.top.mas_equalTo(self.shareView).offset(90*layoutBy6());
            }
            make.width.mas_equalTo(SCREEN_WIDTH/4);
            make.height.mas_equalTo(40*layoutBy6());
        }];
    }
}
-(void)addSubPosterConstrain :(NSMutableArray *)synthesisViewMutArr{
    for (int i =0 ;i<synthesisViewMutArr.count;i++) {
        SynthesisView *synthesisView = [synthesisViewMutArr objectAtIndex:i];
        
        [synthesisView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i*SCREEN_WIDTH/4);
            make.top.mas_equalTo(self.sharePosterView).offset(15*layoutBy6());
            make.width.mas_equalTo(SCREEN_WIDTH/4);
            make.height.mas_equalTo(70*layoutBy6());
        }];
    }
}

#pragma mark -- 初始化数据
-(void)initData{
    
    for (int i = 0;i<4;i++) {
        NSString *iconName = @"";
        NSString *tipStr = nil;
        switch (i) {
            case 0:
                iconName = @"share_wx";
                tipStr = @"微信";
                break;
            case 1:
                iconName = @"share_wxpyq";
                tipStr = @"朋友圈";
                break;
            case 2:
                iconName = @"share_qqkongjian";
                tipStr = @"QQ空间";
                break;
            case 3:
                iconName = @"share_qq";
                tipStr = @"QQ好友";
                break;
            case 4:
                iconName = @"share_missage";
                tipStr = @"短信";
                break;
            case 5:
                iconName = @"erweima";
                tipStr = @"二维码";
                break;
            case 6:
                iconName = @"haibao";
                tipStr = @"海报";
                break;
            case 7:
                iconName = @"baocun";
                tipStr = @"本地保存";
                break;
            case 8:
                iconName = @"链接";
                tipStr = @"短链";
                break;
            default:
                break;
        }
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:iconName,@"icon",tipStr,@"tipStr",nil];
        if (i != 7) {
            [self.subControlDatamutArr addObject:dict];
        }
        
        
        if (i == 0 || i == 1 || i == 3 || i == 7) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:iconName,@"icon",tipStr,@"tipStr",nil];
            [self.subPosterDatamutArr addObject:dict];
        }
    }
}

-(UIImageView *)homeMoreView{
    if (!_homeMoreView) {
        _homeMoreView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-11*layoutBy6()-120*layoutBy6(), 50*layoutBy6()+IPHONEX_TOP_SPACE, 120*layoutBy6(), 201*layoutBy6())];
        _homeMoreView.image = [UIImage imageNamed:@"Cloud Store_window_img_1"];
        _homeMoreView.userInteractionEnabled = YES;
        
        UIButton *qrCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5*layoutBy6(), 120*layoutBy6(), 48.5*layoutBy6())];
//        qrCodeBtn.backgroundColor = [UIColor blueColor];
        [qrCodeBtn addTarget:self action:@selector(enterQrCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeMoreView addSubview:qrCodeBtn];
        
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(qrCodeBtn.frame), 120*layoutBy6(), 48.5*layoutBy6())];
//        shareBtn.backgroundColor = [UIColor redColor];
        [shareBtn addTarget:self action:@selector(enterShareAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeMoreView addSubview:shareBtn];
        
        UIButton *posterBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shareBtn.frame), 120*layoutBy6(), 48.5*layoutBy6())];
//        posterBtn.backgroundColor = [UIColor blueColor];
        [posterBtn addTarget:self action:@selector(enterPosterAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeMoreView addSubview:posterBtn];
        
        UIButton *shortUrlBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(posterBtn.frame), 120*layoutBy6(), 48.5*layoutBy6())];
//        shortUrlBtn.backgroundColor = [UIColor redColor];
        [shortUrlBtn addTarget:self action:@selector(enterShortUrlAction) forControlEvents:UIControlEventTouchUpInside];
        [_homeMoreView addSubview:shortUrlBtn];
    }
    return _homeMoreView;
}

#pragma mark - 首页更多下拉列表点击事件
-(void)enterQrCodeAction{
    //二维码
//    self.shareModel.shareUrl = [self shareLinkWithEnvironment:@"3"];//二维码办理
    StoreQrCodeVC *vc = [[StoreQrCodeVC alloc]init];
    vc.url = self.shareModel.shareUrl;
    vc.imgUrl = self.shareModel.image300300;
    vc.titleStr = self.shareModel.shareTitle;
    [self.baseVc push:vc animation:YES andNotHiddenTabbar:YES];
    
    [self hideHomeMoreViewAction];
}

-(void)enterShareAction{
    //分享
    self.backView.hidden = NO;
    UIWindow *window = [AppDelegate globalDelegate].window;
    [window bringSubviewToFront:self.backView];

    [self hideOrShowShareView];
    
    [self hideHomeMoreViewAction];
}

-(void)enterPosterAction{
    //海报
//    self.shareModel.shareUrl = [self shareLinkWithEnvironment:@"4"];
//    self.shareModel.image300300 =
    PosterVC *vc = [[PosterVC alloc]init];
    vc.model = self.shareModel;
    [self.baseVc push:vc animation:YES andNotHiddenTabbar:YES];
    
    [self hideHomeMoreViewAction];
}

-(void)enterShortUrlAction{
    // 原代码暂时保存
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.shareModel.shareUrl;
    [SGInfoAlert showInfo:@"短链复制到剪切板了"];
    
    [self hideHomeMoreViewAction];
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideHomeMoreViewAction)];
        [_bgView addGestureRecognizer:tapGesturRecognizer];
    }
    return _bgView;
}

- (NSMutableArray *)subControlDatamutArr
{
    if (!_subControlDatamutArr) {
        _subControlDatamutArr = [NSMutableArray array];
    }
    return _subControlDatamutArr;
}

-(NSMutableArray*)subPosterDatamutArr{
    if (!_subPosterDatamutArr) {
        _subPosterDatamutArr = [NSMutableArray array];
    }
    return _subPosterDatamutArr;
}


@end
