//
//  UIControl+UMengAnalytics.h
//  PlayCarParadise
//
//  Created by liuyujia on 2018/9/13.
//  Copyright © 2018年 CarFun. All rights reserved.
//

/*
    * 友盟统计点击事件的分类
    * 使用runtime替换了原来按钮的点击事件，每个所点击的按钮的名字传事件给友盟统计。
    注意：虽然总监不要求实现这个事件传递，但是顺便就写了，如果后续不要刻意删除
 */

#import <UIKit/UIKit.h>

@interface UIControl (UMengAnalytics)

@end
