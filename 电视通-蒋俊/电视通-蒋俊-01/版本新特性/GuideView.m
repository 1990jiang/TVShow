//
//  GuideView.m
//  封装的版本新特性(引导界面)
//
//  Created by 蒋俊 on 16/7/18.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "GuideView.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface GuideView()<UIScrollViewDelegate>

{
    UIScrollView*   _scrollView;
    CGSize          _size;
}
//分页控制器
@property(nonatomic,strong)UIPageControl* pageControl;

@end



@implementation GuideView

#pragma mark -- 重写initWithFrame方法，在其中给自定义View布局和添加子控件
- (instancetype)initWithFrame:(CGRect)frame
{
     if (self = [super initWithFrame:frame])
     {
        _size = frame.size;
         //声明滚动视图
         _scrollView = [[UIScrollView alloc]initWithFrame:frame];
         [self addSubview:_scrollView];
        //取消弹簧效果
         _scrollView.bounces = NO;
         _scrollView.delegate = self;
         //设置分页效果
         _scrollView.pagingEnabled = YES;
       //去掉水平和垂直
         _scrollView.showsVerticalScrollIndicator = NO;
         _scrollView.showsHorizontalScrollIndicator = NO;
         //加载pagecontrol
         [self addSubview:self.pageControl];
 
         //添加移除操作(点击移除)
         UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelf)];
         [self addGestureRecognizer:tap];
         
    }
    
    return self;
}


#pragma mark -- 移除View的方法
-(void)removeSelf
{
    //当前页是最后一页时移除
    if (_pageControl.currentPage == _guideImages.count - 1) {
        [self removeFromSuperview];
    }
}

#pragma mark -- 懒加载pagecontrol
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(_size.width * 0.5, _size.height - 60, 0, 40)];
        _pageControl.backgroundColor = [UIColor redColor];
    }
    return _pageControl;
    
}

#pragma mark -- 图片数组的setting方法
-(void)setGuideImages:(NSArray *)guideImages
{
    _guideImages = guideImages;
    
    if (guideImages.count > 0) {
        _pageControl.numberOfPages = guideImages.count;
        //设置滚动范围
        _scrollView.contentSize = CGSizeMake(guideImages.count * _size.width, _size.height);
    
     //遍历加载所有图片
        for (int i = 0; i < guideImages.count; i ++) {
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _size.width, 0, _size.width, _size.height)];
            [imageView setImage:[UIImage imageNamed:guideImages[i]]];
            [_scrollView addSubview:imageView];
        }

    
    }
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    _pageControl.currentPage = round(offset.x / kScreenWidth);
}
















@end
