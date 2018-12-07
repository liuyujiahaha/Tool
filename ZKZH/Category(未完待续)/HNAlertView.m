//
//  HNAlertView.m
//  BaseProject
//
//  Created by HN on 16/9/22.
//  Copyright © 2016年 HN. All rights reserved.
//

#import "HNAlertView.h"
#import "PublicFunction.h"

@implementation HNAlertView

//解除恋爱关系时弹出的警告框的类型
-(id)initWithHeadImage:(UIImage *)image withMessges:(NSString *)msg type:(alertType)type withCancelBtnTitle:(NSString *)cancelTitle withSureBtnTitle:(NSString *)sureTitle withTitle:(NSString *)title{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
   
    if (self)
    {
        self.myType = type;
        switch (type) {
            case removeRelation:
            {
                [self createBgView];
//                创建解除关系的视图
                if ([cancelTitle isEqualToString:iStoreLocalizedString(@"拒绝")] && [sureTitle isEqualToString:iStoreLocalizedString(@"同意")]) {
                    cancelTitle = iStoreLocalizedString(@"拒绝");
                    sureTitle = iStoreLocalizedString(@"同意");
                }
                else
                {
                    cancelTitle = iStoreLocalizedString(@"取消");
                    sureTitle = iStoreLocalizedString(@"确定");
                }
                [self createRemoveTypeView:image withMesg:msg withCancel:cancelTitle withSure:sureTitle];
                break;
            }
            case yaoqingSuccess:
            {
                [self createBgView];
                [self createYaoQingSuccessView];
                break;
            }
            case sendGiftFail:{//送礼物
                [self createBgView];
                [self createSendGiftViewFailwithCancelTitle:cancelTitle withSurceBtnTitle:sureTitle WithMsg:msg withTitle:title];
                break;
            }
            case report:{//举报
                if(sureTitle&&cancelTitle){
                     [self createReprotView:@[sureTitle,cancelTitle,iStoreLocalizedString(@"取消")]];
                }
                else{
                     [self createReprotView:@[iStoreLocalizedString(@"举报"),iStoreLocalizedString(@"拉黑"),iStoreLocalizedString(@"取消")]];
                }
                break;
            }
            case reportHideBloack:{
                
                if (cancelTitle==nil)
                {
                    [self createReprotView:@[sureTitle,iStoreLocalizedString(@"取消")]];
                }
                else if (sureTitle&&cancelTitle){
                    [self createReprotView:@[sureTitle,cancelTitle,iStoreLocalizedString(@"取消")]];
                }
                else{
                    [self createReprotView:@[iStoreLocalizedString(@"举报"),iStoreLocalizedString(@"拉黑"),iStoreLocalizedString(@"取消")]];
                }
                break;
            }
            case DiaryAlertView:
            {
                [self createDiaryAlertView];
                break;
            }
            case shareAlertView://分享
            {
                [self createShareView];
                break;
            }
            case photoType:{
                
                [self createPhoto:@[sureTitle,cancelTitle,iStoreLocalizedString(@"取消")]];
                break;
            }
            case reportType:{//举报具体的内容界面
//                [self createReportViewOnlyView];
                break;
            }
            default:
                break;
        }
        
    }
    return self;
}

#pragma mark-选图片的弹出框

-(void)createPhoto:(NSArray *)titles{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH-320,ScreenW, 180)];
    self.bgView.backgroundColor = [UIColor clearColor];
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:_bgView];
    for (int i = 0; i<titles.count; i++)
    {
        UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(10, i*self.bgView.bounds.size.height/titles.count-4, _bgView.bounds.size.width - 20, 50) title:titles[i] align:@"center" color:SetColor(@"#333333", 1) fontsize:16 tag:i clickAction:@selector(btnClick:)];
        btn.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:btn];
        if (i!=titles.count-1)
        {
            btn.bounds = CGRectMake(0, 0, btn.bounds.size.width, btn.bounds.size.height - 0.5);
            CALayer *line = [[CALayer alloc]init];
            line.frame = CGRectMake(0, btn.bounds.size.height*(i+1), _bgView.bounds.size.width -10 , 1);
            line.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor clearColor]);
            [_bgView.layer addSublayer:line];
            btn.frame = CGRectMake(btn.frame.origin.x, i * 50 + 0.5, btn.frame.size.width, btn.frame.size.height);
            if (i==1)
            {
                line.frame = CGRectMake(10, btn.bounds.size.height*(i+1), _bgView.bounds.size.width - 10, 1);
                UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerBottomLeft cornerRadii:CGSizeMake(15 , 15)];
                CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
                fieldLayer.frame = btn.bounds;
                fieldLayer.path = fieldPath.CGPath;
                btn.layer.mask = fieldLayer;
            }else{
                line.frame = CGRectMake(10, btn.bounds.size.height*(i+1), _bgView.bounds.size.width - 10, 1);
                UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15 , 15)];
                CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
                fieldLayer.frame = btn.bounds;
                fieldLayer.path = fieldPath.CGPath;
                btn.layer.mask = fieldLayer;
            }
        }
        else{
            btn.frame = CGRectMake(10, btn.frame.origin.y, btn.bounds.size.width, btn.bounds.size.height);
            btn.layer.cornerRadius = 15.f;
            btn.layer.masksToBounds = YES;
        }
    }
    
}

#pragma mark - 分享界面的弹出框
-(void)createShareView{
    
    self.backgroundColor = SetColor(@"#000000", 0.5);
    self.bgView  =[[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-200, ScreenW , 200)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    UILabel *titleLabel = [PublicFunction getlabel:CGRectMake(0, 10, _bgView.bounds.size.width, 30) text:iStoreLocalizedString(@"分享至") size:17*PXSCALE align:@"center"];
    titleLabel.textColor = SetColor(@"#999999", 1);
    [_bgView addSubview:titleLabel];
    
    NSArray *imageNames = @[@"sina",@"weixin",@"qq"];
    for (int i=0; i<3; i++)
    {
        UIButton *btn =[PublicFunction getButtonInControl:self frame:CGRectMake(i*_bgView.bounds.size.width/3.0, titleLabel.bounds.size.height, _bgView.bounds.size.width/3.0, _bgView.bounds.size.width/3.0) imageName:imageNames[i] title:nil clickAction:@selector(btnClick:)];
        btn.tag = i;
        [_bgView addSubview:btn];
    }
    UIButton *cancelBtn = [PublicFunction getButtonInControl:self frame:CGRectMake(10, _bgView.bounds.size.height - 55, _bgView.bounds.size.width-20, 45) title:iStoreLocalizedString(@"取消") align:@"center" color:[UIColor whiteColor] fontsize:15*PXSCALE tag:3 clickAction:@selector(btnClick:)];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 20;
    cancelBtn.backgroundColor = SetColor(@"#CACACA", 1);
    [_bgView addSubview:cancelBtn];
}

#pragma mark -日记界面的弹出框的视图

-(void)createDiaryAlertView{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-150, ScreenW, 150)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    NSArray *titles = @[iStoreLocalizedString(@"删除"),iStoreLocalizedString(@"编辑"),iStoreLocalizedString(@"取消")];
    for (int i=0; i<3; i++)
    {
        UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(0, i*_bgView.bounds.size.height/3.0, _bgView.bounds.size.width, _bgView.bounds.size.height/3.0) title:titles[i] align:@"center" color:SetColor(@"#333333", 1) fontsize:15*PXSCALE tag:i clickAction:@selector(btnClick:)];
        [_bgView addSubview:btn];
        if (i!=2)
        {
            CALayer *line = [[CALayer alloc]init];
            line.frame = CGRectMake(0, (i+1)*btn.bounds.size.height, btn.bounds.size.width, 1);
            line.backgroundColor = tableViewBGColor.CGColor;
            [_bgView.layer addSublayer:line];
        }
        else{
            [btn setTitleColor:navBarbackgroundColor forState:UIControlStateNormal];
        }
    }
}
#pragma mark - 举报和拉黑弹出框（注意此处不是只有举报还有拉黑下面定义的有举报单独界面）
//举报的视图
-(void)createReprotView:(NSArray *)titles{
    
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-320,ScreenW, 150)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.masksToBounds = YES;
//    self.bgView.layer.cornerRadius = 10;
    [self addSubview:_bgView];

    for (int i=0; i<titles.count; i++)
    {
            UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(0, i*_bgView.bounds.size.height/titles.count, _bgView.bounds.size.width, _bgView.bounds.size.height/titles.count) title:titles[i] align:@"center" color:[UIColor blackColor] fontsize:15*PXSCALE tag:i clickAction:@selector(btnClick:)];
            [_bgView addSubview:btn];
            if (i==titles.count-1)
            {
//                btn.backgroundColor = tableViewBGColor;
                [btn setTitleColor:navBarbackgroundColor forState:UIControlStateNormal];
            }

        if (i!=0)
        {
            CALayer *line = [[CALayer alloc]init];
            line.frame = CGRectMake(0, btn.bounds.size.height*i, _bgView.bounds.size.width, 1);
            line.backgroundColor =tableViewBGColor.CGColor;
            [_bgView.layer addSublayer:line];
        }
    }
    
    
}


#pragma mark -创建邀请成功的视图
-(void)createYaoQingSuccessView{
//    标题
    UILabel *titleLabel = [PublicFunction getlabel:CGRectMake(0, 5, _bgView.bounds.size.width, 50) text:iStoreLocalizedString(@"邀请成功") fontSize:15*PXSCALE color:[UIColor blackColor] align:@"center"];
    [_bgView addSubview:titleLabel];
//    内容
    UILabel *msgLabel = [PublicFunction getlabel:CGRectMake(0, titleLabel.bounds.size.height+titleLabel.frame.origin.y, _bgView.bounds.size.width, _bgView.bounds.size.height-titleLabel.bounds.size.height-titleLabel.frame.origin.y-60) text:iStoreLocalizedString(@"您的邀请已经送达,等待对方同意") color:[UIColor grayColor] size:15*PXSCALE];
    
    [_bgView addSubview:msgLabel];
    UIButton *sureBtn = [PublicFunction getButtonInControl:self frame:CGRectMake(0, _bgView.bounds.size.height-60, _bgView.bounds.size.width, 50) title:iStoreLocalizedString(@"确定") align:@"center" color:[UIColor blackColor] fontsize:15*PXSCALE tag:1 clickAction:@selector(btnClick:)];
    [_bgView addSubview:sureBtn];
    
    for (int i=0; i<2; i++)
    {
        CALayer *line = [[CALayer alloc]init];
        line.frame = CGRectMake(0, i*msgLabel.bounds.size.height+titleLabel.bounds.size.height+titleLabel.frame.origin.y, _bgView.bounds.size.width, 1);
        line.backgroundColor = tableViewBGColor.CGColor;
        [_bgView.layer addSublayer:line];
    }
    
}
#pragma mark -解除关系的视图
-(void)createRemoveTypeView:(UIImage *)image withMesg:(NSString *)msg withCancel:(NSString *)cancel withSure:(NSString *)sure{
    UIImageView *headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.bgView.bounds.size.width/2-(50*PXSCALE)/2, 10, 50*PXSCALE, 50*PXSCALE)];
    headImageView.image = image;
    headImageView.layer.masksToBounds = YES;
    headImageView.layer.cornerRadius = headImageView.bounds.size.width/2.0;
    headImageView.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:headImageView];
    UILabel *msgLabel =[PublicFunction getlabel:CGRectMake(10, headImageView.bounds.size.height+headImageView.frame.origin.y, self.bgView.bounds.size.width-20, self.bgView.bounds.size.height-headImageView.bounds.size.height-10-70) text:msg size:15*PXSCALE align:@"center"];
    [self.bgView addSubview:msgLabel];
    
    CALayer *line1 = [[CALayer alloc]init];
    line1.frame = CGRectMake(0, self.bgView.bounds.size.height-(44*PXSCALEH), self.bgView.bounds.size.width, 1);
    line1.backgroundColor = tableViewBGColor.CGColor;// SetColor(@"#999999", 1).CGColor;
    [self.bgView.layer addSublayer:line1];
    
    for (int i = 0; i<2; i++)
    {
        UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(i*_bgView.bounds.size.width/2, line1.frame.origin.y, self.bgView.bounds.size.width/2, self.bgView.bounds.size.height-line1.frame.origin.y) title:cancel align:@"center" color:[UIColor lightGrayColor] fontsize:15*PXSCALE tag:i clickAction:@selector(btnClick:)];
        if (i==1)
        {
            [btn setTitle:sure forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [self.bgView addSubview:btn];
    }
    
    CALayer *line2 = [[CALayer alloc]init];
    line2.frame = CGRectMake(self.bgView.bounds.size.width/2, line1.frame.origin.y, 1, self.bgView.bounds.size.height-line1.frame.origin.y);
    line2.backgroundColor =tableViewBGColor.CGColor; //SetColor(@"#999999", 1).CGColor;
    [self.bgView.layer addSublayer:line2];
    [self.bgView.layer addSublayer:line2];
    
}
#pragma mark -赠送失败的视图
-(void)createSendGiftViewFailwithCancelTitle:(NSString *)cancel withSurceBtnTitle:(NSString *)sureTitle WithMsg:(NSString *)msg withTitle:(NSString *)title{
    CGFloat titleHeight = 50;
    
//    if (title)
//    {
        UILabel *titleLabel = [PublicFunction getlabel:CGRectMake(0, 0, _bgView.bounds.size.width, titleHeight) text:title fontSize:15*PXSCALE color:[UIColor blackColor] align:@"center"];
        [_bgView addSubview:titleLabel];

//    }
//    else{
        _bgView.bounds = CGRectMake(0, 0, _bgView.bounds.size.width, 200);
//    }
    UILabel *msgLabel = [PublicFunction getlabel:CGRectMake(10, titleHeight, _bgView.bounds.size.width-20, _bgView.bounds.size.height-titleHeight-44*PXSCALEH) text:msg BGColor:nil textColor:[UIColor grayColor] size:15*PXSCALE];
    msgLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:msgLabel];
    if(cancel&&sureTitle){
        for (int i=0; i<2; i++)
        {
            UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(i*_bgView.bounds.size.width/2, _bgView.bounds.size.height-44*PXSCALEH, _bgView.bounds.size.width/2, 44*PXSCALEH) title:cancel align:@"center" color:SetColor(@"#333333", 1) fontsize:15 tag:i clickAction:@selector(btnClick:)];
            
            if (i==1)
            {
                [btn setTitle:sureTitle forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            [_bgView addSubview:btn];
        }
        CALayer *line2 = [[CALayer alloc]init];
        line2.frame = CGRectMake(_bgView.bounds.size.width/2, titleHeight+msgLabel.bounds.size.height, 1, _bgView.bounds.size.height-(titleHeight+msgLabel.bounds.size.height));
        line2.backgroundColor = tableViewBGColor.CGColor;
        [_bgView.layer addSublayer:line2];
    }
    else{
        UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(0, _bgView.bounds.size.height-44*PXSCALEH, _bgView.bounds.size.width, 44*PXSCALEH) title:iStoreLocalizedString(@"取消") align:@"center" color:SetColor(@"#333333", 1) fontsize:15 tag:0 clickAction:@selector(btnClick:)];
        [_bgView addSubview:btn];
        if (cancel)
        {
            [btn setTitle:cancel forState:UIControlStateNormal];
        }
        else{
            [btn setTitle:sureTitle forState:UIControlStateNormal];
        }
    }
    for (int i=0; i<2; i++)
    {
        CALayer *line = [[CALayer alloc]init];
        line.frame = CGRectMake(0, i*msgLabel.bounds.size.height+titleHeight, _bgView.bounds.size.width, 1);
        line.backgroundColor = tableViewBGColor.CGColor;
        [_bgView.layer addSublayer:line];
    }
    
    
}
#pragma mark -取消和确认按钮触发方法
-(void)btnClick:(UIButton *)btn{
    
    switch (_myType)
    {
        case report:
        case DiaryAlertView:
        case shareAlertView:
        case reportType:
        case photoType:
        case reportHideBloack:
        {
            [UIView animateWithDuration:0.35 animations:^{
                _bgView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, _bgView.bounds.size.width, _bgView.bounds.size.height);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];

            break;
        }
        default:
        {
            [self dismissView];
            break;
        }
    }
    if (self.myBlock)
    {
        self.myBlock(btn.tag);
    }
    if(self.selectBlock){
        
        UIButton *payBtn = [self.bgView viewWithTag:20000];
        UIButton *wexinBtn = [self.bgView viewWithTag:20001];
        if (payBtn.selected) {
            
            self.selectBlock(payBtn.tag);
        }
        else{
            self.selectBlock(wexinBtn.tag);
        }
        
    }
}
-(void)showHNAlertView:(alertBlock)myblock{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    for (UIView *vi in window.subviews)
    {
        if([vi isKindOfClass:[HNAlertView class]]){
            
            [vi removeFromSuperview];
        }
    }
    
    
    [window addSubview:self];
    switch (_myType)
    {
        case report:
        case reportType:
        case DiaryAlertView:
        case shareAlertView:
        case photoType:
        case reportHideBloack:
        {
            if (_myType==report)
            {
                self.bgView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, _bgView.bounds.size.width,  _bgView.bounds.size.height);
            }
            else{
                self.bgView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, _bgView.bounds.size.width,  _bgView.bounds.size.height);
            }
            [UIView animateWithDuration:0.35 animations:^{
                
                _bgView.frame = CGRectMake((ScreenW -_bgView.bounds.size.width)/2.0, [UIScreen mainScreen].bounds.size.height-_bgView.bounds.size.height, _bgView.bounds.size.width, _bgView.bounds.size.height);
                
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
        default:
        {
            [HNAlertView exChangeOut:self.bgView dur:0.5];
            break;
        }
    }
    self.myBlock = myblock;
    
}
#pragma mark -消失
-(void)dismissView{
    [HNAlertView exChangeOut:self.bgView dur:1];
    [self removeFromSuperview];
}
#pragma mark -动画
+(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}
//举报界面初始化
-(id)initReportView:(NSArray *)titlesArray withTitle:(NSString *)title withCancelBtnTitle:(NSString *)cancel{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self createReportViewOnlyView:titlesArray withTitle:title withCancelBtn:cancel];
    }
    return self;
}
#pragma mark - 举报单独界面
-(void)createReportViewOnlyView:(NSArray *)titles withTitle:(NSString *)title withCancelBtn:(NSString *)cancel{
    
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-320,ScreenW,  50*PXSCALEH*(titles.count+2))];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:_bgView];
    
    CGFloat height = 0;
    if (!title)
    {
        self.bgView.frame = CGRectMake(0, ScreenH-320,ScreenW,  50*PXSCALEH*(titles.count+1));
    }
    else{
        UILabel *titleLabel = [PublicFunction getlabel:CGRectMake(0, 0, ScreenW,50*PXSCALEH) text:title fontSize:14 color:SetColor(@"#333333", 1) align:@"center"];
        [self.bgView addSubview:titleLabel];
        height = titleLabel.bounds.size.height;
    }
    for (int i=0; i<titles.count+1; i++)
    {
        UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(0, i*50*PXSCALEH+height, ScreenW, 50*PXSCALEH) title:nil align:@"center" color:SetColor(@"#333333", 1) fontsize:15 tag:i+1 clickAction:@selector(btnClick:)];
        btn.titleLabel.font = Font(15);
        [self.bgView addSubview:btn];
        if (i==titles.count)
        {
            [btn setTitle:cancel forState:UIControlStateNormal];
            btn.backgroundColor = tableViewBGColor;
            [btn setTitleColor:navBarbackgroundColor forState:UIControlStateNormal];
        }
        else{
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:SetColor(@"#333333", 1) forState:UIControlStateNormal];
            CALayer *line = [[CALayer alloc]init];
            line.frame = CGRectMake(0, (i+1)*btn.bounds.size.height, ScreenW, 1);
            line.backgroundColor = tableViewBGColor.CGColor;
            [_bgView.layer addSublayer:line];
        }
    }
    
}




#pragma mark -创建白色的背景视图
-(void)createBgView{
    
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,270*PXSCALE, 200*PXSCALEH)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 10;
    self.bgView.center = [[UIApplication sharedApplication].delegate window].center;
    [self addSubview:_bgView];

}

#pragma mark -  提交订单
-(id)initSubmitBtnView{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self createSubmitView];
    }
    return self;
}

-(void)createSubmitView{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake((ScreenW-300*PXSCALE)/2.0, 0, 300*PXSCALE, 213*PXSCALEH)];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 10;
    self.bgView.center = [[UIApplication sharedApplication].delegate window].center;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    UILabel *titleLabel = [PublicFunction getlabel:CGRectMake(0, 0, self.bgView.bounds.size.width, 50*PXSCALEH) text:iStoreLocalizedString(@"请选择支付方式") fontSize:15 color:SetColor(@"#333333", 1) align:@"center"];
    [self.bgView addSubview:titleLabel];
    NSArray *images = @[@"zhifubao_zhifu",@"weixin_zhifu"];
    NSArray *titles = @[iStoreLocalizedString(@"支付宝支付"),iStoreLocalizedString(@"微信支付")];
    for (int i=0; i<2; i++)
    {
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10*PXSCALE, titleLabel.bounds.size.height+10*PXSCALEH+40*PXSCALEH*i+i*15*PXSCALEH, 40*PXSCALEH, 40*PXSCALEH)];
        iconImageView.image = [UIImage imageNamed:images[i]];
//        iconImageView.layer.masksToBounds = YES;
//        iconImageView.layer.cornerRadius = iconImageView.bounds.size.width/2.0;
        [self.bgView addSubview:iconImageView];
        
        UILabel *label = [PublicFunction getlabel:CGRectMake(iconImageView.frame.origin.x+iconImageView.bounds.size.width+10*PXSCALE, iconImageView.frame.origin.y, 100, 30) text:titles[i] fontSize:12 color:SetColor(@"#333333", 1) align:@"left"];
        [self.bgView addSubview:label];
        
        UIButton *selectBtn = [PublicFunction getButtonInControl:self frame:CGRectMake(_bgView.bounds.size.width-50-15*PXSCALE, label.frame.origin.y, 50, 50) imageName:@"select" title:nil clickAction:@selector(selectClick:)];
        [selectBtn setImage:[UIImage imageNamed:@"select_Selected"] forState:UIControlStateSelected];
        selectBtn.tag = i+20000;
        [self.bgView addSubview:selectBtn];
        if (i==0)
        {
            selectBtn.selected = YES;
        }
        
    }
    UIButton *sureBtn = [PublicFunction getButtonInControl:self frame:CGRectMake(0, self.bgView.bounds.size.height -44*PXSCALEH,self.bgView.bounds.size.width, 44*PXSCALEH) title:iStoreLocalizedString(@"确认") align:@"center" color:SetColor(@"#333333",1) fontsize:15 tag:1 clickAction:@selector(btnClick:)];
    [self.bgView addSubview:sureBtn];
    
    CALayer *line1 = [CALayer new];
    line1.frame = CGRectMake(0,titleLabel.bounds.size.height, self.bounds.size.width, 1);
    line1.backgroundColor = tableViewBGColor.CGColor;
    [self.bgView.layer addSublayer:line1];
    
    CALayer *line2 = [CALayer new];
    line2.frame = CGRectMake(0, sureBtn.frame.origin.y, self.bounds.size.width, 2);
    line2.backgroundColor = tableViewBGColor.CGColor;
    [self.bgView.layer addSublayer:line2];
    
}
-(void)selectClick:(UIButton *)btn{
    
    UIButton *payBtn = [self.bgView viewWithTag:20000];
    UIButton *wexinBtn = [self.bgView viewWithTag:20001];
    payBtn.selected = NO;
    wexinBtn.selected = NO;
    btn.selected = !btn.selected;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touche = [touches anyObject];
    CGPoint point =  [touche locationInView:self];
    BOOL b =  CGRectContainsPoint(_bgView.frame, point);
    if (!b)
    {
        switch (_myType)
        {
            case report:
            case DiaryAlertView:
            case shareAlertView:
            case reportType:
            case  photoType:
            {
                [UIView animateWithDuration:0.35 animations:^{
                    _bgView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, _bgView.bounds.size.width, _bgView.bounds.size.height);
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
                
                break;
            }
            default:
            {
                [self dismissView];
                break;
            }
        }
      
    }
}

////邀请另一半
//-(id)initWithHeadImage:(NSString *)imageUrl WithMessges:(NSString *)msg withCancel:(NSString *)cancel withSure:(NSString *)sure{
//    
//    self = [super initWithFrame:[UIScreen mainScreen].bounds];
//    if (self)
//    {
//        _myType = removeRelation;
//        [self createBgView];
//        UIImageView *headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(_bgView.bounds.size.width/2-(50*PXSCALE)/2, 10, 50*PXSCALE, 50*PXSCALE)];
//        [headImageView sd_setImageWithURL:[NSURL URLWithString:DownLoadHeadCirclePic(imageUrl, ScaleWith(HeaderNomalImageWidth))] placeholderImage:[UIImage imageNamed:@"load_icon_failed"]];
//        headImageView.layer.masksToBounds = YES;
//        headImageView.layer.cornerRadius = headImageView.bounds.size.width/2.0;
//        headImageView.backgroundColor = [UIColor redColor];
//        [self.bgView addSubview:headImageView];
//        UILabel *msgLabel =[PublicFunction getlabel:CGRectMake(10, headImageView.bounds.size.height+headImageView.frame.origin.y, self.bgView.bounds.size.width-20, self.bgView.bounds.size.height-headImageView.bounds.size.height-10-70) text:msg size:15*PXSCALE align:@"center"];
//        [self.bgView addSubview:msgLabel];
//        
//        CALayer *line1 = [[CALayer alloc]init];
//        line1.frame = CGRectMake(0, self.bgView.bounds.size.height-(44*PXSCALEH), self.bgView.bounds.size.width, 1);
//        line1.backgroundColor = tableViewBGColor.CGColor;// SetColor(@"#999999", 1).CGColor;
//        [self.bgView.layer addSublayer:line1];
//        
//        if(cancel&&sure){
//            for (int i = 0; i<2; i++)
//            {
//                UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(i*_bgView.bounds.size.width/2, line1.frame.origin.y, self.bgView.bounds.size.width/2, self.bgView.bounds.size.height-line1.frame.origin.y) title:cancel align:@"center" color:[UIColor lightGrayColor] fontsize:15 tag:i clickAction:@selector(btnClick:)];
//                if (i==1)
//                {
//                    [btn setTitle:sure forState:UIControlStateNormal];
//                    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//                }
//                [self.bgView addSubview:btn];
//            }
//            CALayer *line2 = [[CALayer alloc]init];
//            line2.frame = CGRectMake(self.bgView.bounds.size.width/2, line1.frame.origin.y, 1, self.bgView.bounds.size.height-line1.frame.origin.y);
//            line2.backgroundColor =tableViewBGColor.CGColor; //SetColor(@"#999999", 1).CGColor;
//            [self.bgView.layer addSublayer:line2];
//            [self.bgView.layer addSublayer:line2];
//        }
//        else{
//            UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(0, line1.frame.origin.y, self.bgView.bounds.size.width,self.bgView.bounds.size.height-line1.frame.origin.y) title:cancel?cancel:sure align:@"center" color:[UIColor lightGrayColor] fontsize:15 tag:1 clickAction:@selector(btnClick:)];
//            [self.bgView addSubview:btn];
//        }
//    }
//    return self;
//}
//#pragma mark - //分享商品之后的弹出框
//
//-(id)initWithShareProductorTitlte:(NSString *)title withImage:(NSString *)imageUrl withDes:(NSString *)des withPrice:(NSString *)price{
//    
//    self = [super initWithFrame:[UIScreen mainScreen].bounds];
//    if (self)
//    {
//        self.bgView.frame = CGRectMake(0, 0, 300*PXSCALE, 200*PXSCALEH);
//        self.bgView.center = [[UIApplication sharedApplication].delegate window].center;
//        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//        [self createBgView];
//      
//        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,_bgView.width, ScaleHeight(35))];
//        titleLable.textColor = UIColorHexFromRGB(0x333333);
//        titleLable.font = Font(17);
//        titleLable.textAlignment = NSTextAlignmentCenter;
//        titleLable.text=  title;
//        [_bgView addSubview:titleLable];
//        CALayer *line = [[CALayer alloc]init];
//        line.frame = CGRectMake(0, titleLable.y+titleLable.height, _bgView.width, ScaleHeight(0.5));
//        line.backgroundColor = LineColor.CGColor;
//        [_bgView.layer addSublayer:line];
//       
////        DLog(@"商品分享的图片链接-----%@====%@", upLoadImage(imageUrl),imageUrl);
//        UIImageView *productImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleWith(10), line.frame.origin.y+ScaleHeight(10), ScaleWith(67), ScaleHeight(67))];
//        [productImageView sd_setImageWithURL:[NSURL URLWithString:DownLoadScalePic(imageUrl, ScaleWith(150), ScaleHeight(150))] placeholderImage:imageName(@"load_merchandise_failed")];
//        [_bgView addSubview:productImageView];
//        
//        CGRect desRect = [ToolsObject getStringFrame:des withFont:15 withMaxSize:CGSizeMake(_bgView.width-productImageView.x-productImageView.width-ScaleWith(24), 60)];
//        
//        UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(productImageView.x+productImageView.width+ScaleWith(12), productImageView.y, desRect.size.width, desRect.size.height)];
//        desLabel.numberOfLines=2;
//        desLabel.text = des;
//        desLabel.textColor = UIColorHexFromRGB(0x333333);
//        desLabel.font = Font(15);
//        [_bgView addSubview:desLabel];
//        
//        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(desLabel.x, desLabel.y+desLabel.height+ScaleHeight(10), _bgView.width-productImageView.x-productImageView.width-ScaleWith(24), ScaleHeight(20))];
//        priceLabel.textColor = navBarbackgroundColor;
//        priceLabel.font = Font(15);
//        priceLabel.text = price;
//        [_bgView addSubview:priceLabel];
//        
//        CGFloat height =0;
//        if (productImageView.y+productImageView.height>priceLabel.y+priceLabel.height) {
//            height = productImageView.y+productImageView.height;
//        }
//        else{
//            height = priceLabel.y+priceLabel.height;
//        }
//        CALayer *line2  =[[CALayer alloc]init];
//        line2.frame = CGRectMake(0, height+ScaleHeight(20), _bgView.width, ScaleHeight(0.5));
//        line2.backgroundColor = LineColor.CGColor;
//        [_bgView.layer addSublayer:line2];
//        
//        for (int i=0; i<2; i++)
//        {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            
//            btn.frame = CGRectMake(i*(_bgView.width/2.0), line2.frame.origin.y, _bgView.width/2.0, ScaleHeight(44));
//            btn.titleLabel.font = Font(15);
//            if (i==0)
//            {
//                [btn setTitle:@"取消" forState:UIControlStateNormal];
//                [btn setTitleColor:UIColorHexFromRGB(0x333333) forState:UIControlStateNormal];
//                btn.tag = 1;
//            }
//            else{
//                CALayer *line3 = [[CALayer alloc]init];
//                line3.frame = CGRectMake(0, ScaleHeight(2), ScaleWith(0.5), ScaleHeight(40));
//                line3.backgroundColor = LineColor.CGColor;
//                [btn.layer addSublayer:line3];
//                
//                [btn setTitle:@"立即查看" forState:UIControlStateNormal];
//                [btn setTitleColor:navBarbackgroundColor forState:UIControlStateNormal];
//                btn.tag = 2;
//            }
//            [btn addTarget:self action:@selector(productBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [_bgView addSubview:btn];
//        }
//        _bgView.frame= CGRectMake(_bgView.x, _bgView.y, _bgView.width,line2.frame.origin.y+ScaleHeight(46));
//    }
//    return self;
//}
-(void)productBtnClick:(UIButton *)btn{
    
    [self dismissView];
    if (self.myBlock)
    {
        self.myBlock(btn.tag);
    }
}

#pragma Mark--- 相册页面初始化
-(id)initRadioChooseView:(NSArray *)titlesArray withTitle:(NSString *)title withCancelBtnTitle:(NSString *)cancel{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        [self creatRadioPhotoTitle:titlesArray withtTitle:title withCancelbtn:cancel];
    }
    return self;
    
}

#pragma mark ---- 电台选择相册图片的接口
-(void)creatRadioPhotoTitle:(NSArray *)array withtTitle:(NSString*)title withCancelbtn:(NSString *)cancle{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH ,ScreenW,145*PXSCALEH)];
    self.bgView.backgroundColor = SetColor(@"#d9d9d9", 1.0);
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:_bgView];
    
    //取消按钮
    UIButton *btn = [PublicFunction getButtonInControl:self frame:CGRectMake(0,145*PXSCALEH-45*PXSCALEH, ScreenW, 45*PXSCALEH) title:iStoreLocalizedString(@"取消") align:@"center" color:SetColor(@"#111111", 1) fontsize:15 tag:0 clickAction:@selector(btnClick:)];
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = Font(16);
    [self.bgView addSubview:btn];
    
    //手机相册
    UIButton *phoneBtn = [PublicFunction getButtonInControl:self frame:CGRectMake(0,145*PXSCALEH-100*PXSCALEH, ScreenW, 45*PXSCALEH) title:array[0] align:@"center" color:TextMainBodyColor fontsize:14 tag:1 clickAction:@selector(btnClick:)];
    phoneBtn.backgroundColor = [UIColor whiteColor];
    phoneBtn.titleLabel.font = Font(16);
    [self.bgView addSubview:phoneBtn];
    
    //拍照
    UIButton *phote = [PublicFunction getButtonInControl:self frame:CGRectMake(0,0, ScreenW, 44*PXSCALEH) title:array[1] align:@"center" color:TextMainBodyColor fontsize:14 tag:2 clickAction:@selector(btnClick:)];
    phote.backgroundColor = [UIColor whiteColor];
    phote.titleLabel.font = Font(16);
    [self.bgView addSubview:phote];
}








@end
