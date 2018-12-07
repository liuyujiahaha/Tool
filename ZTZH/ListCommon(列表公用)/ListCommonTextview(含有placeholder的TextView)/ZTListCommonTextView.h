//
//  ZTListCommonTextView.h
//  ZTStaff
//
//  Created by yujia liu on 2018/11/23.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTListCommonTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 限制最多输入字数 */
@property (nonatomic, assign) NSUInteger maxLengthInput;

@end

NS_ASSUME_NONNULL_END
