//
//  UIView+mjExtenion.m
//  项目-
//
//  Created by 蒋俊 on 16/5/20.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "UIView+XMGExtenion.h"

//1.因为我们会经常修改一个控件的宽度高度等属性，我们直接将这个分类的头文件导入到PCH文件中

@implementation UIView (XMGExtenion)


#pragma mark -- 思路，我们对每个属性都重写了其getter和setter方法，当我们使用.语法调用属性时，就会来到我们自己的方法
//2.对我们设置的属性实现方法

//----3.实现宽度高度的get方法
-(CGFloat)mj_width
{
    return self.frame.size.width;
}

-(CGFloat)mj_height
{
    return self.frame.size.height;
}

//---4.实现set方法
- (void)setMj_width:(CGFloat)mj_width
{
    CGRect frame = self.frame;
    frame.size.width = mj_width;
    self.frame = frame;
}

- (void)setMj_height:(CGFloat)mj_height
{
    CGRect frame = self.frame;
    frame.size.height = mj_height;
    self.frame = frame;
}

/*************控件x,y的值设定*************/
- (CGFloat)mj_x
{
    return self.frame.origin.x;
}

- (CGFloat)mj_y
{
    return self.frame.origin.y;
}

- (void)setMj_x:(CGFloat)mj_x
{
    CGRect frame = self.frame;
    frame.origin.x = mj_x;
    self.frame = frame;
}

- (void)setMj_y:(CGFloat)mj_y
{
    CGRect frame = self.frame;
    frame.origin.y = mj_y;
    self.frame = frame;
}

/***********控件的中心点X,y写********************/
- (CGFloat)mj_centerX
{
    return self.center.x;
}

- (CGFloat)mj_centerY
{
    return self.center.y;
}

- (void)setMj_centerX:(CGFloat)mj_centerX
{
    CGPoint center = self.center;
    center.x = mj_centerX;
    self.center = center;
}

- (void)setMj_centerY:(CGFloat)mj_centerY
{
    CGPoint center = self.center;
    center.y = mj_centerY;
    self.center = center;
}
//************最大x和最大y******************//
- (CGFloat)mj_right
{
  //    return  self.mj_x + self.mj_width;
    return CGRectGetMaxX(self.frame);//两种写法是一样的哦
}

- (CGFloat)mj_bottom
{
    
    return self.mj_y + self.mj_height;
}

- (void)setMj_right:(CGFloat)mj_right
{
    self.mj_x = mj_right - self.mj_width;
  //别人把mj_right传给你，而你就用来计算自己控件实际的 x 值就好啊
}

- (void)setMj_bottom:(CGFloat)mj_bottom
{
    
    self.mj_y = mj_bottom - self.mj_height;
}

//实现mj_size的get和set方法

- (CGSize)mj_size
{
    return self.frame.size;
}

- (void)setMj_size:(CGSize)mj_size
{
    CGRect frame = self.frame;
    frame.size = mj_size;
    self.frame = frame;
}


//
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}






































@end
