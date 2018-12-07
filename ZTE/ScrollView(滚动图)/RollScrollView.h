//
//  RollScrollView.h
//  直销通2.8.0
//
//  Created by BecksZ on 16/3/25.
//  Copyright © 2016年 jun. All rights reserved.
//

/**
 * 滚动图展示，提供url和imageName两种传值方式
 *
 * 网络图片加载基于SDWebImage
 */
#import <UIKit/UIKit.h>

/**
 *  状态控制，是否可点
 */
typedef NS_ENUM(NSInteger, RollScrollViewTapType) {
    /**
     *  默认,可点击
     */
    RollScrollViewTapTypeTap = 100,
    /**
     *  不可点击
     */
    RollScrollViewTapTypeNone
};

/**
 * 滚动点击代理，提供两种点击方式
 */
@protocol RollScrollViewDelegate <NSObject>

@optional
/**
 *  点击方法
 *
 *  @param pageIndex 下标
 */
- (void)rollScrollViewDidClickAtPage:(NSInteger)pageIndex;

@end

@interface RollScrollView : UIView

@property (nonatomic, weak) id <RollScrollViewDelegate> rollScrollViewDelegate;   // 代理
@property (nonatomic, assign) RollScrollViewTapType tapType;                      // 是否可点
@property (nonatomic, strong) NSString *loadingImgName;                           // 加载默认图
@property (nonatomic, assign) NSTimeInterval timeInterval;                        // 滚动延迟，默认5秒
/**
 *  初始化方法－url链接
 *
 *  @param frame
 *  @param sourceArr 资源
 *
 *  @return RollScrollView
 */
- (id)initPageViewWithFrame:(CGRect)frame source:(NSArray *)sourceArr;
/**
 *  资源赋值－使用init初始化使用
 *
 *  @param sourceArr 资源
 */
- (void)pageWithSource:(NSArray *)sourceArr;
@end
