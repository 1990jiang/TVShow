//
//  UIImage+XMGExtenion.m
//  项目-百思不得姐-01
//
//  Created by rimi on 16/6/15.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import "UIImage+XMGExtenion.h"

@implementation UIImage (XMGExtenion)
//实现方法(这个是个对象方法)
- (instancetype)jj_circleImage
{
    //我们在图片下载完成这里来做圆形图片(我们不用图层，直接将我们加载的正方形图片弄成圆形就好)
    
    //1.开启图形上下文(这个上下文的大小呢，和我们加载的图片是一样大的)
    UIGraphicsBeginImageContext(self.size);
    //2.拿到上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3.添加一个圆(Ellipse:椭圆)
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(ctx,  rect);
    //4.裁剪
    CGContextClip(ctx);
    //5.绘制图片(把服务器的图片画到这个圆上)
    [self drawInRect:rect];
    //6.获得图片(将当前绘制的图片赋值)
   UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //7.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

//写个类方法(调用类方法，你传个图片名给我，我给你变成圆形的)
+ (instancetype)jj_circleImage:(NSString *)name
{
   //好好理解一下这个写法
    return [[self imageNamed:name] jj_circleImage];
}





@end
