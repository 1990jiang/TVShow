//
//  JJMainController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/7.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJMainController.h"
#import "JJTitleButton.h"
#import "JJCCTVViewController.h"
#import "JJStar-TVViewController.h"
#import "JJCMMBViewController.h"
#import "JJCityViewController.h"
#import "JJCETVViewController.h"
#import "JJOriginalTVViewController.h"
#import "JJFilmTVViewController.h"
//给scrollView写的3D效果分类
#import "UIScrollView+_DScrollView.h"


@interface JJMainController ()<UIScrollViewDelegate>

/**UIScrollView*/
@property (nonatomic , strong) UIScrollView *scrollView;

/**顶部按钮标题栏*/
@property (nonatomic , strong) UIView *titlesView;

/**按钮底部跟随指示器*/
@property (nonatomic , strong) UIView *indicatorView;

/**当前选中的标题按钮:用来记录选中的按钮，这样可以做到选中与没选中之间切换*/
@property (nonatomic , weak) JJTitleButton *selectedTitleButton;




@end

@implementation JJMainController

- (void)viewDidLoad {
    [super viewDidLoad];
   //配置导航栏
    [self setupNav];
   
    
    //添加子控制器(这个添加子控制的方法必须放在配置滚动视图的方法前面)
    //不然会造成滚动视图的scrollView.contentSize = 0,scrollView无法滚动
    [self addChildViewControllers];

    //配置滚动视图
    [self setupScrollView];
    
   //配置顶部的标题分类栏
    [self setUpTitlesView];

    
    //默认添加子控制器的View
    [self addChildVcView];
    
    
    
    
    
}

#pragma mark -- 配置导航栏
-(void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"television.png"]];
    
    //导航左边按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]init];
    leftItem.title = @"电视节目表";
    leftItem.tintColor = [UIColor colorWithRed:0.6157 green:0.0039 blue:0.1843 alpha:1.0];
    //导航右边按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]init];
    
    UIImage *rightImage = [UIImage imageNamed:@"save.png"];
    //设置图像的渲染样式
    rightImage = [rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [rightItem setImage:rightImage];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark -- 配置scrollView
-(void)setupScrollView
{
   //不允许系统自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    //创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
   // scrollView.frame = CGRectMake(0, 0, self.view.mj_width, self.view.mj_height);
    scrollView.frame = self.view.bounds;
    //[scrollView make3Dscrollview];
   //写个颜色用来测试
    scrollView.backgroundColor = [UIColor colorWithRed:0.8078 green:0.8078 blue:0.8078 alpha:1.0];
    //设置scrollView可以分页
    scrollView.pagingEnabled = YES;
   //去掉scrollView的水平和垂直滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    [self.view addSubview:scrollView];
  
//设置scrollView的滚动范围
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.mj_width, 0);
   
    
}


#pragma mark -- 配置顶部的频道类型标题
-(void)setUpTitlesView
{
    //创建标题View
    UIView *tielesView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_width, 35)];
    self.titlesView = tielesView;
    tielesView.backgroundColor = [[UIColor colorWithRed:0.9059 green:0.8667 blue:0.6902 alpha:1.0]colorWithAlphaComponent:0.5];
    [self.view addSubview:tielesView];
    //标题数组
    NSArray *titlesArr = @[@"央视",@"卫视",@"数字",@"城市",@"CETV",@"原创",@"影视"];
   //标题按钮宽度和高度
    CGFloat titleBtnW = self.view.mj_width / titlesArr.count;
    CGFloat titleBtnH = self.titlesView.mj_height;
    
    for (NSInteger index = 0; index < titlesArr.count; index ++) {
        JJTitleButton *titleBtn = [JJTitleButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(index * titleBtnW, 0, titleBtnW, titleBtnH);
        [titleBtn setTitle:titlesArr[index] forState:UIControlStateNormal];
        
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //给按钮设置个tag值
        titleBtn.tag = index;
        
        [self.titlesView addSubview:titleBtn];
    }
   //拿到第一个按钮
    JJTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
//创建按钮底部的跟随指示器
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [UIColor colorWithRed:0.6157 green:0.0039 blue:0.1843 alpha:1.0];
    //设置位置和大小
    indicatorView.mj_height = 1;
    indicatorView.mj_y = self.titlesView.mj_height - firstTitleButton.mj_y;
    //根据文字内容计算lable的宽度
    [firstTitleButton.titleLabel sizeToFit];
    //这个指示器view的宽度就是按钮里面文字属性的宽度
    indicatorView.mj_width = firstTitleButton.titleLabel.mj_width;
    //中心x值
    indicatorView.mj_centerX = firstTitleButton.mj_centerX;
    
    [self.titlesView addSubview:indicatorView];
    
    //默认选中第一个按钮(就是调用了那个按钮的点击事件，你刚一进来我就传个按钮给你，相当于那个按钮就被选中了)
    [self titleBtnClick:firstTitleButton];
}




#pragma mark -- 标题按钮的监听事件
-(void)titleBtnClick:(JJTitleButton *)titleButton
{
    //我们要实现点击的那个按钮实现变色，而没有选中的有恢复成没有选中的状态
    //思路是用一个选择按钮来保存当前按钮的状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    //点击按钮时，指示器移动到相应的位置
    [UIView animateWithDuration:0.35 animations:^{
       self.indicatorView.mj_centerX = titleButton.mj_centerX;
    }];
    //点击按钮后scrollView滚动到相应的地方
    //拿到scrollView的偏移属性
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag *self.scrollView.mj_width;
    [self.scrollView setContentOffset:offset animated:YES];
    
    
}

#pragma mark -- 添加子控制器
- (void)addChildViewControllers
{
    JJCCTVViewController *cctvVc = [[JJCCTVViewController alloc]init];
    [self addChildViewController:cctvVc];
    JJStar_TVViewController *starVc = [[JJStar_TVViewController alloc]init];
    [self addChildViewController:starVc];
    JJCMMBViewController *cmmbVc = [[JJCMMBViewController alloc]init];
    [self addChildViewController:cmmbVc];
    JJCityViewController *cityVc = [[JJCityViewController alloc]init];
    [self addChildViewController:cityVc];
    JJCETVViewController *cetvVc = [[JJCETVViewController alloc]init];
    [self addChildViewController:cetvVc];
    JJOriginalTVViewController *originalVc = [[JJOriginalTVViewController  alloc]init];
    [self addChildViewController:originalVc];
    JJFilmTVViewController *filmVc = [[JJFilmTVViewController alloc]init];
    [self addChildViewController:filmVc];
}

#pragma mark -- ScrollView的代理方法
//停止滚动动画时调用(当使用setContentOffset: animated: 或者scrollRectVisible:animated方法让scrollView开始了滚动动画，最后动画结束时，就会调用这个方法)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    [self addChildVcView];
    
}
//滚动减速时调用(这个是人为拖拽时快停止时调用)scrollView开始了滚动动画，最后动画结束时，就会调用这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //人为拖拽时，要能够点击/选中对应的按钮
    //获得按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.mj_width;
    //根据索引取出对应的button
    JJTitleButton *titleButton = self.titlesView.subviews[index];
    //还有一种方法，给一个tag值，然后在父控件中去找符合tag值的子控件
    //XMGTitleButton *titleButton = (XMGTitleButton *)[self.titlesView viewWithTag:index];
    
    [self titleBtnClick:titleButton];
    //人为拖拽的时候也要添加子控制器的View
    [self addChildVcView];
    
}
#pragma mark -- 添加子控制器视图
-(void)addChildVcView
{
    //添加所有子控制器的view到scrollView上->我们要和那个上面的按钮配合起来，并且实现UIViewController的懒加载
    //思路我们怎么知道是点击的哪一个按钮呢:用scrollView的偏移量除以其宽度，就是那个按钮的索引了
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.mj_width;
    //取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    //这里判断一下，只有我们发现这个ChildVc.view有父控制器了，证明它已经被创建过了，我们就不要去重新创建了，直接返回
    if (childVc.view.superview)  return;
    //上面的判断这样写也行
    // if (childVc.view.window) return;
    //判断还可以这样写
    // if ([childVc isViewLoaded]) return;
    
    //设置子控制器View的一些参数
    childVc.view.mj_y = 0;
    childVc.view.mj_x = index * self.scrollView.mj_width;
    childVc.view.mj_width = self.scrollView.mj_width;
    childVc.view.mj_height = self.scrollView.mj_height;
    //上面四句可以写成一句
    // childVc.view.frame = self.scrollView.bounds;
    //将子控制器的view添加到scrollView上
    [self.scrollView addSubview:childVc.view];
 
    
    
    
}

































    
    
@end
