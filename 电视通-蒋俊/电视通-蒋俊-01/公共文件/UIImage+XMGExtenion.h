//
//  UIImage+XMGExtenion.h
//  项目-百思不得姐-01
//
//  Created by rimi on 16/6/15.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMGExtenion)

//给我一个图片，调用这个方法，我给你返回圆形的图片
//instancetype:是@interface后面是什么类，就返回什么
- (instancetype)jj_circleImage;

//写个类方法(调用类方法，你传个图片名给我，我给你变成圆形的)
+ (instancetype)jj_circleImage:(NSString *)name;

@end
