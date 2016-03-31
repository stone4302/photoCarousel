//
//  XGCirculScrollView.m
//  Day3_ScrollWindow
//
//  Created by 彭丙向 on 16/2/26.
//  Copyright © 2016年 pengbingxiang. All rights reserved.
//

#import "XGCirculScrollView.h"

static int const imageViewCount = 3;

@interface XGCirculScrollView ()<UIScrollViewDelegate>
/** 循环滑动的容器 */
@property (nonatomic,strong) UIScrollView *scrollView;
/** 分页控制器 */
@property (nonatomic,strong) UIPageControl *pageControll;
/** 定时器 */
@property (nonatomic,strong) NSTimer *timer;
/** 记录上一次的偏移量 */
@property (nonatomic,assign) CGFloat offset;
@end

@implementation XGCirculScrollView

+ (instancetype)circulScrollView{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        scrollView.userInteractionEnabled = YES;
        scrollView.backgroundColor = [UIColor lightTextColor];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        for (int i=0; i<imageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            [self.scrollView addSubview:imageView];
        }
        
        UIPageControl *pageControll = [[UIPageControl alloc]init];
        pageControll.pageIndicatorTintColor = [UIColor grayColor];
        pageControll.currentPageIndicatorTintColor = [UIColor redColor];
        pageControll.currentPage = 0;
        pageControll.hidesForSinglePage = YES;//设置成单页就隐藏
        [self addSubview:pageControll];
        self.pageControll = pageControll;
        
    }
    return self;
}

#pragma mark - <UIScrollViewDelegate>
/*
 * scrollView开始拖拽时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
/*
 * scrollView结束拖拽时调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

/*
 * scrollView拖拽后停止减速时调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f~~~",scrollView.contentOffset.x);
    CGFloat temp_offset;
    CGFloat temp_size;
    if (self.scrollDirection == YES) {
        temp_size = self.scrollView.frame.size.height;
        temp_offset = scrollView.contentOffset.y;
    }else {
        temp_size = self.scrollView.frame.size.width;
        temp_offset = scrollView.contentOffset.x;
    }
    if (temp_offset > temp_size) {
        [self pageControllRightMove];
    }else if (temp_offset < temp_size) {
        [self pageControllLeftMove];
    }
    [self updateScrollViewData];
}
/*
 * scrollView停止自动滑动时调用,必须是走这个方法：setContentOffset
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self pageControllRightMove];
    [self updateScrollViewData];
}
#pragma mark - 分页选择器，右移
- (void)pageControllRightMove{
    NSInteger index = self.pageControll.currentPage;
    if (index >= self.imageNamesArray.count - 1) {
        index = 0;
    }else{
        index++;
    }
    self.pageControll.currentPage = index;
}
#pragma mark - 分页选择器，左移
- (void)pageControllLeftMove{
    NSInteger index = self.pageControll.currentPage;
    if (index <= 0) {
        index = self.imageNamesArray.count - 1;
    }else{
        index--;
    }
    self.pageControll.currentPage = index;
}
#pragma mark - 刷新滑窗中数据
- (void)updateScrollViewData{
    
    for (int i=0; i<imageViewCount; i++) {
        NSInteger index = self.pageControll.currentPage;
        UIImageView *imageView = self.scrollView.subviews[i];
        
        if (i == 0) {
            index--;
        }else if (i == 2){
            index++;
        }
        
        if (index < 0) {
            index = self.imageNamesArray.count - 1;
        }else if (index >= self.imageNamesArray.count){
            index = 0;
        }
        
        imageView.image = [UIImage imageNamed:self.imageNamesArray[index]];
        
    }
    if (self.scrollDirection == YES) {
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }else {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
}
#pragma mark - 滑窗向下一个imageView移动
- (void)next{
    if (self.scrollDirection == YES) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + self.frame.size.height) animated:YES];
    }else {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.frame.size.width, 0) animated:YES];
    }
}

#pragma mark - 开启定时器
- (void)startTimer{
    if (self.timer == nil) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:self.timerVal ? self.timerVal:5 target:self selector:@selector(next) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        self.timer = timer;
    }
}
#pragma mark - 关闭定时器
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat scroll_W = self.frame.size.width;
    CGFloat scroll_H = self.frame.size.height;
    
    self.scrollView.frame = self.bounds;
    if (self.scrollDirection == YES) {
        self.scrollView.contentSize = CGSizeMake(0 , imageViewCount * scroll_H);
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
    }else{
        self.scrollView.contentSize = CGSizeMake(imageViewCount * scroll_W, 0);
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    
    for (int i=0; i<imageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        if (self.scrollDirection == YES) {
            imageView.frame = CGRectMake(0, i * scroll_H, scroll_W, scroll_H);
        }else {
            imageView.frame = CGRectMake(i * scroll_W, 0, scroll_W, scroll_H);
        }
    }
    
    self.pageControll.frame = CGRectMake(scroll_W - 100, scroll_H - 40, 60, 20);
}

- (void)setImageNamesArray:(NSArray *)imageNamesArray{
    _imageNamesArray = imageNamesArray;
    
    self.pageControll.numberOfPages = imageNamesArray.count;
    self.pageControll.currentPage = 0;
    
    //有图片数据是调用
    
    //设置数据
    [self updateScrollViewData];
    //开启定时器,只有图片资源数量超过1才循环滑动
    if (imageNamesArray.count > 1) {
        [self startTimer];
    }else{
        //如果图片资源等于小于1，并且使scrollView不能手动滑动
        self.scrollView.userInteractionEnabled = NO;
    }
}
- (void)setUserEnabled:(BOOL)userEnabled{
    _userEnabled = userEnabled;
    if (self.imageNamesArray.count > 1) {
        self.scrollView.userInteractionEnabled = userEnabled;
    }
}
- (void)setPageTintColor:(UIColor *)pageTintColor{
    _pageTintColor = pageTintColor;
    self.pageControll.pageIndicatorTintColor = pageTintColor;
}
- (void)setCurrentPageTintColor:(UIColor *)currentPageTintColor{
    _currentPageTintColor = currentPageTintColor;
    self.pageControll.currentPageIndicatorTintColor = currentPageTintColor;
}
@end









