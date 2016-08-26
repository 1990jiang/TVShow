//
//  JJItemManager.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/13.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJItemManager.h"

@implementation JJItemManager

+ (UIButton *)itemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的相关属性
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //return [[UIBarButtonItem alloc]initWithCustomView:button];
    return button;
}



@end
