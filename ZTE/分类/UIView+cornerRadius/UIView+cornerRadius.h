//
//  UIView+cornerRadius.h
//  Tool
//
//  Created by liuyujia on 2018/12/6.
//  Copyright © 2018 liuyujia. All rights reserved.
//
//  使用例子
//  - (UIImageView *)blackBGimageView {
//
//    if (!_blackBGimageView) {
//
//        _blackBGimageView = [[UIImageView alloc] init];
//        _blackBGimageView.frame = CGRectMake(100, 100, 50, 50);
//        _blackBGimageView.backgroundColor = [UIColor redColor];
//        [_blackBGimageView addRoundedCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
//                                   withRadii:CGSizeMake(5.0, 5.0)
//                                    viewRect:CGRectMake(0, 0, 50, 50)];
//    }
//
//    return _blackBGimageView;
//}

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (cornerRadius)
#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
