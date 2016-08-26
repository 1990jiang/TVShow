//
//  JJTabBarController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/7.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJTabBarController.h"
#import "JJNavigationController.h"
#import "JJMainController.h"
#import "JJUserController.h"
#import "JJSearchController.h"
#import "JJSaveController.h"



@interface JJTabBarController ()

@end

@implementation JJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
   //给标签栏设置背景颜色()
  // self.tabBar.backgroundColor = [UIColor orangeColor];
  [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.9725 green:0.9804 blue:0.7451 alpha:1.0]];
    
    
    //******创建一个统一的UITabBarItem 对象(关键啊)******//
    UITabBarItem *item = [UITabBarItem appearance];
/** 文字属性 **/
  //配置普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
 //配置选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.0392 green:0.0392 blue:0.0235 alpha:1.0];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
  //******* 创建子控制器 **********//
    [self setupChildViewController:[[JJNavigationController alloc]initWithRootViewController:[[JJMainController alloc]init]] title:@"主页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildViewController:[[JJNavigationController alloc]initWithRootViewController:[[JJSearchController alloc]init]] title:@"搜索" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildViewController:[[JJNavigationController alloc]initWithRootViewController:[[JJSaveController alloc]init]] title:@"收藏" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    [self setupChildViewController:[[JJNavigationController alloc]initWithRootViewController:[[JJUserController alloc]init]] title:@"用户" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
   
}

#pragma mark -- 创建子控制器方法
-(void)setupChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
   // vc.view.backgroundColor = JJRandomColor;
    //设置标签栏item的标题
    vc.tabBarItem.title = title;
    //设置普通状态和选中状态下的图片
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //添加子控制器
    [self addChildViewController:vc];
}
























































@end
