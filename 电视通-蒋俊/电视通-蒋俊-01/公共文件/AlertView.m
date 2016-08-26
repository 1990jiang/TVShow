//
//  AlertView.m
//  坠落的警告视图
//
//  Created by mac on 14-1-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView


- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
        ButtonTitle:(NSString *)Title{
    if (self = [super init]) {
        self.layer.cornerRadius = 8.0;
        self.backgroundColor = [UIColor colorWithRed:0.9216 green:0.9255 blue:0.9373 alpha:1.0];
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kTitleYOffset, kAlertWidth, kTitleHeight)];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        self.alertTitleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:64.0/255.0 blue:71.0/255.0 alpha:1];
        [self addSubview:self.alertTitleLabel];
        
        CGFloat contentLabelWidth = kAlertWidth - 16;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, CGRectGetMaxY(self.alertTitleLabel.frame), contentLabelWidth, 60)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textAlignment = self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
       //设置提示文字的颜色
        self.alertContentLabel.textColor = [UIColor colorWithRed:127.0/255.0 green:127.0/255.0 blue:127.0/255.0 alpha:1];
       //提示文字的字体大小
        self.alertContentLabel.font = [UIFont systemFontOfSize:15.0f];
        [self addSubview:self.alertContentLabel];
        
        CGRect BtnFrame;
        
        
        BtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth - 60) * 0.5, kAlertHeight - kButtonBottomOffset - kButtonHeight, kSingleButtonWidth + 60, kButtonHeight );
        self.Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.Btn.frame = BtnFrame;
        
    }
   //返回按钮的颜色设置
    [self.Btn setBackgroundColor:[UIColor colorWithRed:0.349 green:0.2902 blue:0.3451 alpha:1.0]];
   //设置标题
    [self.Btn setTitle:Title forState:UIControlStateNormal];
    //设置字体大小
    self.Btn.titleLabel.font  = [UIFont boldSystemFontOfSize:14];
    //设置按钮文字颜色
    [self.Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //按钮点击事件
    [self.Btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //按钮圆角
    self.Btn.layer.cornerRadius = 8.0;
    [self addSubview:self.Btn];
    
    
    self.alertTitleLabel.text = title;
    self.alertContentLabel.text = content;
   //左上角的关闭按钮
    UIButton *xButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [xButton setImage:[UIImage imageNamed:@"alert1.png"] forState:UIControlStateNormal];
    [xButton setImage:[UIImage imageNamed:@"alert2.png"] forState:UIControlStateHighlighted];
    xButton.frame = CGRectMake(kAlertWidth - 32, 0, 32, 32);
    [self addSubview:xButton];
    [xButton addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
    return self;
}
//下方按钮的点击方法
- (void)BtnClicked:(id)sender
{
    
   // [self dismissAlert];
    
}
//显示
- (void)show
{
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    self.frame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    [shareWindow addSubview:self];
}
//消失
- (void)dismissAlert
{
    [self removeFromSuperview];
    
}
//移除当前
- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    CGRect afterFrame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(shareWindow.bounds), kAlertWidth, kAlertHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        
        self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIWindow *shareWindow = [UIApplication sharedApplication].keyWindow;
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:shareWindow.bounds];
    }
    self.backImageView.backgroundColor = [UIColor blackColor];
    self.backImageView.alpha = 0.6f;
    [shareWindow addSubview:self.backImageView];
    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(shareWindow.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(shareWindow.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

@end
