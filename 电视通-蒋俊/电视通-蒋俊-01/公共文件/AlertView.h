//
//  AlertView.h
//  坠落的警告视图
//
//  Created by mac on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//整个提示view的宽度
#define kAlertWidth 280.0f
//整个提示view的高度
#define kAlertHeight 160.0f
#define kTitleYOffset 15.0f
#define kTitleHeight 25.0f

#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f
#define kSingleButtonWidth 160.0f
#define kCoupleButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 10.0f
@interface AlertView : UIView
//提示视图的标题
@property (nonatomic, strong) UILabel *alertTitleLabel;
//提示视图的内容
@property (nonatomic, strong) UILabel *alertContentLabel;
//下方按钮
@property (nonatomic, strong) UIButton *Btn;
//
@property (nonatomic, strong) UIView *backImageView;

- (void)show;
- (id)initWithTitle:(NSString *)title contentText:(NSString *)content ButtonTitle:(NSString *)Title;
@end
