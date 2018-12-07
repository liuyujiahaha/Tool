//
//  ZTEaseBlankView.m
//  ZTStaff
//
//  Created by zhongxing on 2018/4/26.
//  Copyright © 2018年 智慧正通. All rights reserved.
//

#import "ZTEaseBlankView.h"

typedef void(^ZTEaseBlankViewClickBlock)(void);

@interface ZTEaseBlankView ()
{
    ZTEaseBlankViewType _type;
}

//系统自带活动指示器
@property (nonatomic, strong) UIActivityIndicatorView *activity;

//图片 ImageView
@property (nonatomic, strong) UIImageView *mainImageView;

//标题文字 Label
@property (nonatomic, strong) UILabel *titleLabel;

//block 点击按钮时触发
@property (nonatomic, copy) ZTEaseBlankViewClickBlock clickBlock;


@end


@implementation ZTEaseBlankView

#pragma mark - Intial Method

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        //self
        self.frame = CGRectMake(0, 0, 200.0f, 200.0f);
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        self.center = window.center;
        
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}


#pragma mark - Private Method

- (void)tapAction {
    
    if (self.clickBlock && _type != ZTEaseBlankViewTypeLoading) {
        self.clickBlock();
    }
    
}


#pragma mark - Public Method

/**
 *  显示
 *  @param  type           SAEaseBlankViewType显示类型
 */
- (void)showWithType:(ZTEaseBlankViewType)type {
    
    [self showWithType:type clickAction:nil];
    
}


/**
 *  显示
 *  @param  type           ZTEaseBlankViewType显示类型
 *  @param  clickAction    页面无数据时 无网络链接状态时 点击按钮触发
 */
- (void)showWithType:(ZTEaseBlankViewType)type clickAction:(void (^ __nullable)(void))clickAction {
    
    _type = type;
    
    switch (type) {
        case ZTEaseBlankViewTypeLoading:
            
            self.activity.hidden = NO;
            [self.activity startAnimating];
            if (_mainImageView) {
                _mainImageView.hidden = YES;
            }
            if (_titleLabel) {
                _titleLabel.hidden = YES;
            }
            if (_titleLabel) {
                _titleLabel.hidden = YES;
            }
            
            break;
            
        case  ZTEaseBlankViewTypeNoData:
            
            self.mainImageView.hidden = NO;
            self.titleLabel.hidden = NO;
            if (_activity) {
                [_activity stopAnimating];
                _activity.hidden = YES;
            }
            break;
            
        case  ZTEaseBlankViewTypeNoNetwork:
            
            self.mainImageView.hidden = NO;
            self.titleLabel.hidden = NO;
            if (_activity) {
                [_activity stopAnimating];
                _activity.hidden = YES;
            }
            break;
            
        case  ZTEaseBlankViewTypeError:
            
            self.mainImageView.hidden = NO;
            self.titleLabel.hidden = NO;
            if (_activity) {
                [_activity stopAnimating];
                _activity.hidden = YES;
            }
            break;
            
        case  ZTEaseBlankViewTypeNoPermissions:
            
            self.mainImageView.hidden = NO;
            self.titleLabel.hidden = NO;
            if (_activity) {
                [_activity stopAnimating];
                _activity.hidden = YES;
            }
            break;
            
        default:
            break;
    }
    
    
    self.clickBlock = ^{
        
        if (clickAction) {
             clickAction();
        }
       
    };
    
}


/**
 *  移除
 */
- (void)dismiss {
    
    [self removeFromSuperview];
    
}


#pragma mark - Get Method

- (UIActivityIndicatorView *)activity {
    
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activity startAnimating];
        [self addSubview:_activity];
        [_activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    return _activity;
}


- (UIImageView *)mainImageView {
    
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]init];
        _mainImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_mainImageView];
        [_mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).with.offset(-30.0f);
            make.width.mas_equalTo(150.0f);
            make.height.mas_equalTo(150.0f);
        }];
        
        if (_type ==  ZTEaseBlankViewTypeNoData) {
            _mainImageView.image = [UIImage imageNamed:@"easeBlankView_noData_icon"];
            
        }else if (_type ==  ZTEaseBlankViewTypeNoNetwork){
            _mainImageView.image = [UIImage imageNamed:@"easeBlankView_noNetwork_icon"];
       
        }else if (_type ==  ZTEaseBlankViewTypeError){
            _mainImageView.image = [UIImage imageNamed:@"easeBlankView_noData_icon"];
       
        } else if (_type ==  ZTEaseBlankViewTypeNoPermissions){
            _mainImageView.image = [UIImage imageNamed:@"easeBlankView_noPermissions_icon"];
        }
    }
    return _mainImageView;
}


- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = APP_FONT(15.0f);
        _titleLabel.textColor = RGB(189, 189, 189);
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).with.offset(55.0f);
            make.width.mas_equalTo(300.0f);
            make.height.mas_equalTo(60.0f);
        }];
        
        if (_type ==  ZTEaseBlankViewTypeNoData) {
            _titleLabel.text = @"暂无数据\n点击屏幕刷新数据";
            
        } else if (_type ==  ZTEaseBlankViewTypeNoNetwork){
            _titleLabel.text = @"网络请求失败\n请检查您的网络并点击屏幕刷新";
       
        } else if (_type ==  ZTEaseBlankViewTypeError){
            _titleLabel.text = @"加载失败\n请检查您的网络并点击屏幕刷新";
        
        } else if (_type ==  ZTEaseBlankViewTypeNoPermissions){
            _titleLabel.text = @"暂无权限";
        }
        
        
    }
    return _titleLabel;
}




@end
