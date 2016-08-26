//
//  UIView+mjExtenion.h
//  项目-//
//  Created by 蒋俊 on 16/5/20.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMGExtenion)

///**宽度属性*/
//@property (nonatomic , assign) CGFloat width;
///**高度属性*/
//@property (nonatomic , assign) CGFloat height;

//为什么要加前缀，是为了说明这是自己写的，也好区分(还有一点容易和其它第三方框架冲突)


/**尺寸属性*/
@property (nonatomic , assign) CGSize mj_size;
/**宽度属性*/
@property (nonatomic , assign) CGFloat mj_width;
/**高度属性*/
@property (nonatomic , assign) CGFloat mj_height;

/**控件的x值*/
@property (nonatomic , assign) CGFloat mj_x;
/**控件的y值*/
@property (nonatomic , assign) CGFloat mj_y;

/**中心点x值*/
@property (nonatomic , assign) CGFloat mj_centerX;
/**中心点y值*/
@property (nonatomic , assign) CGFloat mj_centerY;

/**右边--控件最大 x 值*/
@property (nonatomic , assign) CGFloat mj_right;

/**左边--控件最大 y 值*/
@property (nonatomic , assign) CGFloat mj_bottom;

//
+ (instancetype)viewFromXib;
















@end
