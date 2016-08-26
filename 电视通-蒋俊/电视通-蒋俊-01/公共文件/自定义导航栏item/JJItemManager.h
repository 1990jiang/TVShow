//
//  JJItemManager.h
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/13.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJItemManager : NSObject


//写一个类方法自定义item
+ (UIButton *)itemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;



@end
