//
//  JJRefreshNormalHeader.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/8.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJRefreshNormalHeader.h"

@implementation JJRefreshNormalHeader

#pragma mark -- 要自定义刷新控件，要重写小码哥的这个方法，类似于layoutSubViews

-(void)prepare
{
    //调用父类
    [super prepare];
   //修改刷新文字颜色
    self.stateLabel.textColor = [UIColor colorWithRed:0.6588 green:0.6 blue:0.6353 alpha:1.0];
   //下面更新文字的颜色
    self.lastUpdatedTimeLabel.textColor = [UIColor colorWithRed:0.6588 green:0.6 blue:0.6353 alpha:1.0];
   //自定义刷新提示文字
    [self setTitle:@"下拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开,节目出现" forState:MJRefreshStatePulling];
    [self setTitle:@"小主,正在加载数据..." forState:MJRefreshStateRefreshing];
}







@end
