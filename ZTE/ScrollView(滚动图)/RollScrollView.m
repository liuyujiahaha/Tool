//
//  RollScrollView.m
//  直销通2.8.0
//
//  Created by BecksZ on 16/3/25.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "RollScrollView.h"
#import "UIImageView+WebCache.h"

@interface RollScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;     // 滚动视图
@property (nonatomic, strong) UIPageControl *pageControl;   // 分页器
@property (nonatomic, strong) NSTimer *scrollTimer;         // 滚动计时
@property (nonatomic, strong) NSArray *sourceArr;           // 资源列表，可为url和image
@end

@implementation RollScrollView

// 检测资源释放
- (void)dealloc
{
    NSLog(@"RollScrollView dealloc");
}

#pragma mark - 初始化
- (id)initPageViewWithFrame:(CGRect)frame source:(NSArray *)sourceArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sourceArr = sourceArr;
        self.userInteractionEnabled = YES;
        [self initSubviews];
    }
    return self;
}

- (void)pageWithSource:(NSArray *)sourceArr
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
    self.sourceArr = sourceArr;
    self.userInteractionEnabled = YES;
    [self initSubviews];
}

#pragma mark - Delegate
#pragma mark ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖动scrollview的时候 停止计时器控制的跳转
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    //当手指滑动scrollview，而scrollview减速停止的时候 开始计算当前的图片的位置
    int currentPage = self.scrollView.contentOffset.x/width;
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(width*self.sourceArr.count, 0, width, height) animated:NO];
        self.pageControl.currentPage = self.sourceArr.count-1;
    }
    else if (currentPage == self.sourceArr.count+1) {
        [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    //拖动完毕的时候 重新开始计时器控制跳转
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
}

#pragma mark - Actions
- (void)nextPage:(NSTimer *)timer
{
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    int currentPage = self.scrollView.contentOffset.x/width;
    
    if (currentPage == 0) {
        self.pageControl.currentPage = self.sourceArr.count-1;
    }
    else if (currentPage == self.sourceArr.count+1) {
        [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
        self.pageControl.currentPage = 0;
        // 设定定时器加速，因为从最后一页跳到该页时，会有一个重复滚动动作
        [self.scrollTimer setFireDate:[NSDate dateWithTimeInterval:self.timeInterval sinceDate:[NSDate date]]];
        [self.scrollTimer fire];
    }
    else {
        self.pageControl.currentPage = currentPage-1;
        NSInteger currPageNumber = self.pageControl.currentPage;
        CGRect rect = CGRectMake((currPageNumber+2)*width, 0, width, height);
        [self.scrollView scrollRectToVisible:rect animated:YES];
        currPageNumber++;
        if (currPageNumber == self.sourceArr.count) {
            CGRect newRect=CGRectMake(width*self.sourceArr.count, 0, width, height);
            [self.scrollView scrollRectToVisible:newRect animated:NO];
            currPageNumber = 0;
        }
        self.pageControl.currentPage = currPageNumber;
    }
}
//点击图片的时候 触发
- (void)singleTap:(UITapGestureRecognizer *)tapGesture
{
    if (self.tapType != RollScrollViewTapTypeNone) {
        return;
    }
    if (self.rollScrollViewDelegate && [self.rollScrollViewDelegate respondsToSelector:@selector(rollScrollViewDidClickAtPage:)]) {
        if (self.sourceArr && self.sourceArr.count>0) {
            [self.rollScrollViewDelegate rollScrollViewDidClickAtPage:self.pageControl.currentPage];
        }
    }
}

#pragma mark - 子视图
- (void)initSubviews
{
    // 子控件大小
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGRect fitRect = CGRectMake(0, 0, width, height);
    
    if (self.sourceArr.count==0) {
        [self addSubview:[self imageWithFrame:fitRect]];
    }
    else if (self.sourceArr.count==1) {
        id source = [self.sourceArr firstObject];
        [self addSubview:[self imageViewWithSource:source frame:fitRect]];
    }
    else {
        [self addSubview:self.scrollView];
        self.scrollView.contentSize = CGSizeMake(width*(self.sourceArr.count+2), height);
        self.scrollView.frame = fitRect;
        
        // 将最后一张图加载到最前
        id sourceFirst = [self.sourceArr lastObject];
        [self.scrollView addSubview:[self imageViewWithSource:sourceFirst frame:fitRect]];
        // 添加其他图片
        for (int i = 0; i < self.sourceArr.count; i++) {
            CGRect imgRect = CGRectMake(width*(i+1), 0, width, height);
            [self.scrollView addSubview:[self imageViewWithSource:[self.sourceArr objectAtIndex:i] frame:imgRect]];
        }
        // 将第一张图片加到最后
        CGRect lastImgRect = CGRectMake(width*(self.sourceArr.count+1), 0, width, height);
        [self.scrollView addSubview:[self imageViewWithSource:[self.sourceArr firstObject] frame:lastImgRect]];
        
        [self addSubview:self.pageControl];
        self.pageControl.frame=CGRectMake(0, height-30, width, 30);
        //设置样式在右边
        CGSize pointSize = [self.pageControl sizeForNumberOfPages:self.sourceArr.count];
        CGFloat page_x = -(self.pageControl.bounds.size.width - pointSize.width) / 2+20*layoutBy6() ;
        [self.pageControl setBounds:CGRectMake(page_x, self.pageControl.bounds.origin.y,self.pageControl.bounds.size.width, self.pageControl.bounds.size.height)];
        
        [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
}

#pragma mark 初始化图片
- (UIImageView *)imageViewWithSource:(NSString *)source frame:(CGRect)fitRect
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:fitRect];
    if ([[source lowercaseString] hasPrefix:@"http://"] || [[source lowercaseString] hasPrefix:@"https://"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:source] placeholderImage:[UIImage imageNamed:@"default_banner_icon"]];
    }
    else {
        imageView.image=[UIImage imageNamed:source];
    }
    return imageView;
}

- (UIImageView *)imageWithFrame:(CGRect)fitRect
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:fitRect];
    imageView.image=[UIImage imageNamed:@"default_banner_icon"];
    return imageView;
}

#pragma mark - Setter Getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled=YES;
        _scrollView.delegate=self;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = self.sourceArr.count;
        _pageControl.currentPageIndicatorTintColor = hexStringToColor(@"ffffff");
        _pageControl.pageIndicatorTintColor = hexStringToColorA(@"ffffff",0.45);
        _pageControl.currentPage = 0;
        _pageControl.enabled = YES;
    }
    return _pageControl;
}

- (RollScrollViewTapType)tapType
{
    if (!_tapType) {
        _tapType = RollScrollViewTapTypeTap;
    }
    return _tapType;
}


@end
