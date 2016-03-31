//
//  XGCirculScrollView.h
//  Day3_ScrollWindow
//
//  Created by 彭丙向 on 16/2/26.
//  Copyright © 2016年 pengbingxiang. All rights reserved.
//

//轮播图

#import <UIKit/UIKit.h>

@interface XGCirculScrollView : UIView

/** 滚动图片名称 */
@property (nonatomic,strong) NSArray *imageNamesArray;
/** 是否可以手动滑动 */
@property (assign,nonatomic,getter=isUserEnabled) BOOL userEnabled;
/** 分页选择器选中是的颜色 */
@property (nonatomic,strong) UIColor *currentPageTintColor;
/** 分页选择器未选中是的颜色 */
@property (nonatomic,strong) UIColor *pageTintColor;
/** 滑动的方向，YES:上下滑/NO:左右滑(默认左右滑动) */
@property (nonatomic,assign,getter=isScrollDirection) BOOL scrollDirection;

+ (instancetype)circulScrollView;

@end
