//
//  JJUserController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/7.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJUserController.h"
//导入收藏界面
#import "JJSaveController.h"

//导入蒙版第三方
#import "SVProgressHUD.h"

//导入友盟
#import "UMSocial.h"
//导入封装的提示视图
#import "AlertView.h"

//导入系统自带分享的框架
#import <Social/Social.h>

//宏定义一下缓存路径
#define JJCacheFile  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject


@interface JJUserController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>


/**tableView*/
@property (nonatomic , strong)  UITableView *tableView;

/**UITableView 头部视图*/
@property (nonatomic , strong) UIView *headerView;

/**cell名字数组*/
@property (nonatomic , strong) NSArray *cellName;

/**清除缓存的Label*/
@property (nonatomic , strong) UILabel *cacheLabel;

/**保存缓存的字符串*/
@property (nonatomic , strong)  NSString *sizeText;




@end

@implementation JJUserController

static NSString *userID = @"userID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.title = @"用户设置";
    
   
    /**< 初始化用户界面 */
    [self initializeUserInterface];
    
    [self.tableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //调用计算缓存文件大小的方法
    unsigned long long size = [self countCacheSize];
    self.sizeText = nil;
    if (size >= pow(10, 9))
    {//size >= 1GB
        self.sizeText = [NSString stringWithFormat:@"%.2fGB",size/ pow(10, 9)];
    }else if (size >= pow(10, 6))
    {
        self.sizeText = [NSString stringWithFormat:@"%.2fMB",size/ pow(10, 6)];
    }else if (size >= pow(10, 3))
    {
        self.sizeText = [NSString stringWithFormat:@"%.2fKB",size/ pow(10, 3)];
    }else
    {
        self.sizeText = [NSString stringWithFormat:@"%zdB",size];
        
    }

    self.cacheLabel.text = self.sizeText;
    
}

#pragma mark -- 界面设置
-(void)initializeUserInterface
{
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark -- 计算缓存文件夹cache的大小
-(unsigned long long)countCacheSize
{
   
    //0.--先设置一个文件夹总大小属性(因为苹果官方返回的文件大小值是unsigned long long类型的，我们也保持一致用这个)
    unsigned long long size = 0;
    
    
    //1.1先取出缓存文件夹的路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    //2.获得文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
   //3.--开始用for循环遍历出文件夹cache下的所有文件
  
    NSArray *subpaths = [mgr subpathsAtPath:cachesPath];
    for (NSString *subpath in subpaths) {
        //获得子文件路径并拼接为其全路径(cachePath:是cache的路径，拼接上里面文件的路径，就是文件的全路径)
        NSString *fullSubpath = [cachesPath stringByAppendingPathComponent:subpath];
 
        //获得文件属性--里面就有当前文件的大小
        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
         size += attrs.fileSize;
    }
//    //将最后大小size转化为NSString类型
//    NSString *cacheSize = [NSString stringWithFormat:@"%llu",size];
        return size;
}

#pragma mark -- 懒加载tableView
- (UITableView *)tableView
{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor colorWithRed:0.8078 green:0.8078 blue:0.8078 alpha:1.0];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
        //注册cell
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:userID];
        //不要tableView滚动
        //_tableView.scrollEnabled = NO;
        
        //取消自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        
   }
    
    
    
    return _tableView;
    
}

//懒加载头部视图
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.mj_width, 260)];
      
        
        _headerView.backgroundColor = [UIColor colorWithRed:0.8078 green:0.8078 blue:0.8078 alpha:1.0];
        
      //添加头部图片
        UIImageView *personalImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.headerView.mj_width, 200)];
        personalImage.image = [UIImage imageNamed:@"tou2.jpeg"];
    
        [_headerView addSubview:personalImage];
    
    //循环添加三个按钮
       
//        NSArray *buttonName = @[@"收藏123.png",@"小夜灯123.png",@"设置123.png"];
//        
//        CGFloat buttonW = _headerView.mj_width / buttonName.count;
//        CGFloat buttonH = _headerView.mj_height - personalImage.mj_height;
//        
//        for (NSInteger index = 0; index < 3; index ++) {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(index * buttonW, 200, buttonW, buttonH);
//            btn.tag = 1000 + index;
//            
//            [btn setImage:[UIImage imageNamed:buttonName[index]] forState:UIControlStateNormal];
//          
//            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [_headerView addSubview:btn];
//        }
    }
    return _headerView;
}

//懒加载cell名字数组
- (NSArray *)cellName
{
    if (!_cellName) {
        _cellName = @[@"支持我们",@"自定义频道",@"检查更新",@"精品应用推荐",@"分享",@"清除缓存",@"调节亮度"];

    }
    
    return _cellName;
}






#pragma mark -- UITableViewData
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cellName.count;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userID forIndexPath:indexPath];
    
    
    
    //去掉cell选中的背景色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.backgroundColor = [UIColor colorWithRed:0.8078 green:0.8078 blue:0.8078 alpha:1.0];
    
    cell.textLabel.text = self.cellName[indexPath.row];
   //设置cell的字体
    [cell.textLabel setFont:[UIFont fontWithName:@"STXingkai" size:22]];
   
  //给cell添加控件
    
    if ([cell.textLabel.text isEqualToString:@"清除缓存"]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(340, 0, 100, 44)];
         self.cacheLabel = label;
       //调用计算缓存文件大小的方法
         unsigned long long size = [self countCacheSize];
        self.sizeText = nil;
        if (size >= pow(10, 9))
        {//size >= 1GB
             self.sizeText = [NSString stringWithFormat:@"%.2fGB",size/ pow(10, 9)];
        }else if (size >= pow(10, 6))
        {
             self.sizeText = [NSString stringWithFormat:@"%.2fMB",size/ pow(10, 6)];
        }else if (size >= pow(10, 3))
        {
            self.sizeText = [NSString stringWithFormat:@"%.2fKB",size/ pow(10, 3)];
        }else
        {
             self.sizeText = [NSString stringWithFormat:@"%zdB",size];
            
        }
       
        
       
        label.text =  self.sizeText;
        [label setFont:[UIFont fontWithName:@"STXingkai" size:22]];
        [cell addSubview:label];
    }
    if ([cell.textLabel.text  isEqualToString:@"调节亮度"]) {
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(200, -28, 200, 100)];
        //设置滑块左边（小于部分）线条的颜色
        slider.minimumTrackTintColor = [UIColor whiteColor];
        
        slider.value = 0.5;
        //添加事件
        [slider addTarget:self action:@selector(lightTonight:) forControlEvents:UIControlEventValueChanged];
        
        [cell addSubview:slider];
    
    }
    
    
    
    
    
    
    
    
    
    return cell;
}

#pragma mark -- 滑块的监听方法
-(void)lightTonight:(UISlider *)slider
{
    //调节屏幕亮度
    [[UIScreen mainScreen] setBrightness: slider.value];
    
    
    
}

#pragma mark -- 用户界面三个按钮的监听事件
//-(void)clickBtn:(UIButton *)btn
//{
//    //靠tag值来判断点击的是哪一个按钮
//   if (btn.tag == 1000)
//   {
//       NSLog(@"这是收藏按钮");
//       
//       JJSaveController *saveVc = [[JJSaveController alloc]init];
//      [self.navigationController pushViewController:saveVc animated:YES];
//      
//   }else if (btn.tag == 1001)//这是夜间按钮
//   {
//       
//   }else
//   {
//       NSLog(@"这是收藏按钮");
//   }
//    
//    
//    
//}

#pragma mark -- tableView的代理方法

//点击cell的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row == 6) {
        return;
    }else
    {
        //拿到cell
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [UIView animateWithDuration:0.5 animations:^{
            cell.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
        }];
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                
                cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
                
                
                
            } completion:^(BOOL finished) {
                
                
                if (indexPath.row == 0) {//支持我们
                    
//                    [self popUpAlertWithTitle:@"谢谢支持" Message:@"您的关注是我们前进的动力"];
                    
                    AlertView *alert = [[AlertView alloc]initWithTitle:@"谢谢支持" contentText:@"感谢使用我们的app,欢迎提出您宝贵意见和建议,让我们进一步优化应用,提升您的使用体验" ButtonTitle:@"邮箱:1142512230@qq.com"];
                    [alert show];
  
                    
                }
                if (indexPath.row == 1) {//支持我们
                    
                    [self popUpAlertWithTitle:@"非常抱歉" Message:@"暂时无法自定义频道"];
                }
                if (indexPath.row == 2) {//检查更新
                    [self popUpAlertWithTitle:@"尊敬的用户" Message:@"当前已是最新版本"];
                }
                if (indexPath.row == 3) {//精品应用推荐
                    
                }
                if (indexPath.row == 4) {
                  
                    [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:@"电视通" shareImage:[UIImage imageNamed:@"test_t108"]
                                                shareToSnsNames:@[UMShareToTencent,UMShareToWechatSession,UMShareToQQ] delegate:self];
                    
      
                    
                    
                    
                    
                    
                    
                #pragma mark --  先用系统自带的分享一下，直接发送到腾讯微博
                    
//                    //1.首先判断腾讯微博能不能用
//                    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTencentWeibo]) {
//                        return;
//                    }
//                    
//                    //2.创建控制器并设置ServiceType
//                    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];
//                    
//                    //添加要分享的图片
//                    [composeVc addImage:[UIImage imageNamed:@"Snip20160716_93"]];
//                    //添加要分享的文字
//                    [composeVc setInitialText:@"这是我自己做的iOS-App,名字叫电视通。一款在ipone端进行电视节目预告的app,附带的地址不是下载地址，是我的技术博客地址(声明本次微博只是做应用测试用的)"];
//                    //添加要分享的url
//                    [composeVc addURL:[NSURL URLWithString:@"http://www.jianshu.com/users/5ec8b2f1f3eb/latest_articles"]];
//                    //弹出分享控制器
//                    [self presentViewController:composeVc animated:YES completion:nil];
//                    //监听用户点击事件
//                    composeVc.completionHandler = ^(SLComposeViewControllerResult result){
//                        if (result == SLComposeViewControllerResultDone) {
//                           // NSLog(@"点击了发送");
//                        } else if (result == SLComposeViewControllerResultCancelled)
//                        {
//                           // NSLog(@"点击了取消");
//                        }
//                    };
//     
                    
                    
                    
                    
                }
                if (indexPath.row == 5) {//清除缓存
                   
                    
                    [self clearCaches];
                    
                    

                }
                
                
            }];
        });
        

    }
    
    
}
#pragma mark -- 清除缓存的方法
-(void)clearCaches
{
   
   
    
    //弹出指示器
    [SVProgressHUD showWithStatus:@"正在清除缓存..."];
    //设置指示器样式
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
   
           //2.删掉自定义的缓存->这些对文件夹的操作都需要用到文件管理器
        NSFileManager *mgr = [NSFileManager defaultManager];
        //调用文件管理器的删除文件的方法
        [mgr removeItemAtPath:JJCacheFile error:nil];
        //文件夹删除后，你还要将文件夹再创建回来，只不过里面没有东西了
        [mgr createDirectoryAtPath:JJCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
        
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        //需要延迟的代码
       
        //再回到主线程创建空的原始文件夹
        //所有的缓存都清除好了
        
        //隐藏指示器
        [SVProgressHUD dismiss];
       
        self.cacheLabel.text = @"0B";
        //重新设置文字
        //self.cacheLabel.text =  self.sizeText;
    });

 
}




#pragma mark -- 封装的小弹窗
-(void)popUpAlertWithTitle:(NSString *)title Message:(NSString *)message
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -- 友盟的代理方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        NSLog(@"分享成功");
    }
    
    
    
    
    
}


























@end
