

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject

@property (nonatomic, strong)NSString *shareType;  // 分享类型专区，1；店铺，2；业务包，3
@property (nonatomic, strong) NSString *shareUrl;   //分享链接
@property (nonatomic, strong) NSString *shareImageUrl;    //图片地址
@property (nonatomic, strong) UIImage *shareImage; //分享图片uiimage类型
@property (nonatomic, strong) NSString *shareContent;     //描述
@property (nonatomic, strong) NSString *shareTitle;       //标题
@property (nonatomic, strong) NSString *dataID;    //专题id，业务id
@property (nonatomic, strong) NSString *shareToPlat;//分享至什么平台 1微信；2qq；

@property (nonatomic, strong) NSString *sellPrice;    //商品售价
@property (nonatomic, strong) NSString *image300300;    //商品小图标



@end
