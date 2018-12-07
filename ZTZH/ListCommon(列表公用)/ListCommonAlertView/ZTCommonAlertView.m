//
//  ZTCommonAlertView.m
//  ZTStaff
//
//  Created by yujia liu on 2018/11/21.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import "ZTCommonAlertView.h"
@interface ZTCommonAlertView()
/** 弹窗主内容view */
@property (nonatomic,strong) UIView *contentView;
/** 弹窗标题 */
@property (nonatomic,copy)   NSString *title;
/** 弹窗信息 */
@property (nonatomic,copy)   NSString *message;
/** 左边按钮title */
@property (nonatomic,copy)   NSString *leftButtonTitle;
/** 右边按钮title */
@property (nonatomic,copy)   NSString *rightButtonTitle;
/** 左侧block */
@property (nonatomic,strong)   ZTCommonAlertViewBlock leftBlock;
/** 右侧block */
@property (nonatomic,strong)   ZTCommonAlertViewBlock rightBlock;
@end
@implementation ZTCommonAlertView

-(instancetype)initWithTitle:(NSString *)title message:(NSString *)message leftButton:(NSString *)leftButton rightButton:(NSString *)rightButton leftBlock:(nullable ZTCommonAlertViewBlock)leftBlock rightBlock:(ZTCommonAlertViewBlock)rightBlock{
    self = [super init];
    self.title = title;
    self.message = message;
    self.leftButtonTitle = leftButton;
    self.rightButtonTitle = rightButton;
    self.leftBlock = leftBlock;
    self.rightBlock = rightBlock;
    [self setUI];
    
    return self;
}

-(void)setUI{
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self addSubview:backgroundView];
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [backgroundView addGestureRecognizer:tapAction];
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    
    //弹窗主内容
    self.contentView = [[UIView alloc]init];
    self.contentView.frame = CGRectMake((ScreenWidth - 285) / 2, (ScreenHeight - 160) / 2, 285, 160);
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 6;
    self.contentView.alpha = 0.0f;
    [UIView animateWithDuration:0.4 animations:^{
        self.contentView.alpha = 1.0f;
    }];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.contentView.frame), 22)];
    [self.contentView addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    
    //内容
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+0, CGRectGetWidth(self.contentView.frame), 60)];
    [self.contentView addSubview:messageLabel];
    messageLabel.font = [UIFont boldSystemFontOfSize:15];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = UIColorFromHexadecimalRGB(0x262626);
    messageLabel.text = self.message;
    
    //取消按钮
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 160 - 45, 285 / 2, 45)];
    [cancelBtn setTitle:self.leftButtonTitle forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UIColorFromHexadecimalRGB(0x666666) forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelBtn];
    
    //确认按钮
    UIButton *comfirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMinY(cancelBtn.frame), CGRectGetWidth(cancelBtn.frame), 45)];
    [comfirmBtn setTitle:self.rightButtonTitle forState:UIControlStateNormal];
    [comfirmBtn setTitleColor:UIColorFromHexadecimalRGB(0xDF3448) forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:comfirmBtn];
    
    UIView *rowLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(cancelBtn.frame), CGRectGetWidth(titleLabel.frame), 1)];
    rowLine.backgroundColor = UIColorFromHexadecimalRGB(0xDEDEDE);
    [self.contentView addSubview:rowLine];
    
    UIView *crossLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(comfirmBtn.frame), CGRectGetMinY(comfirmBtn.frame), 1, CGRectGetHeight(comfirmBtn.frame))];
    crossLine.backgroundColor = UIColorFromHexadecimalRGB(0xDEDEDE);
    [self.contentView addSubview:crossLine];
}

#pragma mark - response methods
-(void)rightAction{
    [self dismiss];
    if (self.rightBlock) {
        self.rightBlock();
    }
}

-(void)leftAction{
    [self dismiss];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

#pragma mark - 弹出此弹窗
/** 弹出此弹窗 */
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}

@end
