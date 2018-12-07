//
//  HNAlertView.h
//  BaseProject
//
//  Created by HN on 16/9/22.
//  Copyright © 2016年 HN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    removeRelation,//解除关系,拉黑
    yaoqingSuccess,//邀请成功
    sendGiftFail,//赠送礼物失败//不能使用该功能（这两个界面的弹出框一个类型）
    report,//弹出举报和拉黑的框
    DiaryAlertView,//日记界面弹出框
    shareAlertView,//分享界面的弹出框
    photoType,//选照片界面弹出框
    reportType,//这个是点击举报按钮弹出举报原因的框
    senfGiftSuccuess,//赠送礼物成功
    reportHideBloack//当拉黑之后不显示解除拉黑
} alertType;

typedef void(^alertBlock)(NSInteger index);

@interface HNAlertView : UIView

@property (nonatomic,assign)alertType myType;
@property (nonatomic,copy)alertBlock myBlock;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,copy)void(^selectBlock)(NSInteger index);//当提交订单时用这个block调用出来
//解除恋爱关系时弹出的警告框的类型
-(id)initWithHeadImage:(UIImage *)image withMessges:(NSString *)msg type:(alertType)type withCancelBtnTitle:(NSString *)cancelTitle withSureBtnTitle:(NSString *)sureTitle withTitle:(NSString *)title;
//显示弹出框
-(void)showHNAlertView:(alertBlock)myblock;
//邀请成功时弹出的弹出框

//举报界面初始化
-(id)initReportView:(NSArray *)titlesArray withTitle:(NSString *)title withCancelBtnTitle:(NSString *)cancel;

//提交订单
-(id)initSubmitBtnView;
//赠送礼物成功
-(id)initSendGiftSuccuse:(NSString *)title withImageURl:(NSString *)url withmessger:(NSString *)msg;
//邀请另一半
-(id)initWithHeadImage:(NSString *)imageUrl WithMessges:(NSString *)msg withCancel:(NSString *)cancel withSure:(NSString *)sure;
//分享商品之后的弹出框
-(id)initWithShareProductorTitlte:(NSString *)title withImage:(NSString *)imageUrl withDes:(NSString *)des withPrice:(NSString *)price;

#pragma Mark--- 相册页面初始化
-(id)initRadioChooseView:(NSArray *)titlesArray withTitle:(NSString *)title withCancelBtnTitle:(NSString *)cancel;
@end
