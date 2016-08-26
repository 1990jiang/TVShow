//
//  JJTitleButton.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/7.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJTitleButton.h"

@implementation JJTitleButton

//重写父类的初始化方法，在这里面做一些统一设置
//为什么是重写这个方法呢?
//因为即使是重写init方法，最后也会来到initWithFrame方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor colorWithRed:0.6157 green:0.0039 blue:0.1843 alpha:1.0] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return self;
}



@end
