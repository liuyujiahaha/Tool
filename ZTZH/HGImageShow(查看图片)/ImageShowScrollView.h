//
//  ImageShowScrollView.h
//  ZhongXingDays
//  日志图片查看 scrollView
//  Created by zhongxing on 15/7/27.
//  Copyright (c) 2015年 zhongxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MRImgLocation) {
    MRImgLocationLeft,
    MRImgLocationCenter,
    MRImgLocationRight,
};


@interface ImageShowScrollView : UIScrollView<UIScrollViewDelegate>

{
    NSDictionary* _imgViewDic;   // 展示板组
}

@property(nonatomic ,assign)NSInteger curIndex;     // 当前显示图片在数据源中的下标

@property(nonatomic ,retain)NSMutableArray *imgSource;

@property(nonatomic ,readonly)MRImgLocation imgLocation;    // 图片在空间中的位置

@property (nonatomic, strong) UIImage *placeholderImage; //占位图片



- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame withSourceData:(NSMutableArray *)imgSource withIndex:(NSInteger)index placeholderImage:(UIImage *)placeholderImage;

// 谦让双击放大手势
- (void)requireDoubleGestureRecognizer:(UITapGestureRecognizer *)tep;

@end

