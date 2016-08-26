//
//  JJWebViewController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/12.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJWebViewController.h"


@interface JJWebViewController ()


/**网页视图*/
@property (nonatomic , strong) UIWebView *channelWebView;



@end

@implementation JJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //初始化用户界面
    [self initializeUserInterface];
    
   
    
    
}

#pragma mark -- 懒加载webView
-(UIWebView *)channelWebView
{
    if (!_channelWebView) {
        _channelWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
         _channelWebView.backgroundColor = [UIColor colorWithRed:0.9176 green:0.9569 blue:0.7569 alpha:1.0];
        //自动对页面进行缩放以适应屏幕
        _channelWebView.scalesPageToFit = YES;
        
        //是否允许网络内嵌视频播放(手机上默认是NOipad上默认是YES)
        _channelWebView.allowsInlineMediaPlayback = YES;
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.channelPlayUrl]];
        [_channelWebView loadRequest:request];

        //NSLog(@"--%@",self.channelPlayUrl);
    }
    
    return _channelWebView;
}

#pragma mark -- /**< 初始化用户界面 */
-(void)initializeUserInterface
{
    [self.view addSubview:self.channelWebView];
    
    
    
    self.title = self.channelTitle;
    
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor orangeColor]}];
//    
    
    
    
    
    //导航左边按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(popTORootController)];
    
    UIImage *leftImage = [UIImage imageNamed:@"fanhui.png"];
    //设置图像的渲染样式
    leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [leftItem setImage:leftImage];
    
    self.navigationItem.leftBarButtonItem = leftItem;

}

#pragma mark -- 自定义导航栏左边返回按钮后的返回方法
-(void)popTORootController
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
























@end
