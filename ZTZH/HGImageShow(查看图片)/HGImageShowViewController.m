//
//  HGImageShowViewController.m
//  HighGoApp
//
//  Created by zhongxing on 16/4/2.
//  Copyright © 2016年 深圳市嗨走科技有限公司. All rights reserved.
//

#import "HGImageShowViewController.h"
#import "ImageShowScrollView.h"
#import "UIViewExt.h"


@interface HGImageShowViewController ()

@end

@implementation HGImageShowViewController

#pragma mark - 视图控制器生命周期方法
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
}

- (void)loadView{
    [super loadView];
    self.title = @"图片查看";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子视图
    [self initSubViews];
    
    
}

#pragma mark - 私有方法

#pragma mark 初始化子视图
- (void)initSubViews{
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    //轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    
    //scrollview
    ImageShowScrollView *imgShowView = [[ImageShowScrollView alloc]
                                        initWithFrame:self.view.frame
                                        withSourceData:_imageArray
                                        withIndex:_index
                                        placeholderImage:self.placeholderImage];
    [imgShowView requireDoubleGestureRecognizer:[[self.view gestureRecognizers] lastObject]];
    [self.view addSubview:imgShowView];
    
    
    //显示图片下标的Lable
    _indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    _indexLabel.center = self.view.center;
    _indexLabel.top = ScreenHeight - 50;
    _indexLabel.backgroundColor = [UIColor clearColor];
    _indexLabel.textColor = [UIColor whiteColor];
    _indexLabel.textAlignment = NSTextAlignmentCenter;
    _indexLabel.font = APP_FONT(18.0f);
    _indexLabel.text = [NSString stringWithFormat:@"%zi/%zi",imgShowView.curIndex+1,_imageArray.count];
    [self.view addSubview:_indexLabel];
    
    if (_imageArray.count == 1) {
        _indexLabel.hidden = YES;
    }
    
}


#pragma mark  轻拍手势

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - 内存方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
