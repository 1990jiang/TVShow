//
//  AppDelegate.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/6.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "AppDelegate.h"
#import "JJTabBarController.h"
//导入友盟
#import "UMSocial.h"
//手动集成微信的头文件
#import "UMSocialWechatHandler.h"

#import "GuideView.h"

@interface AppDelegate ()

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //1.创建window并设置大小
    self.window = [[UIWindow alloc]init];
    //2.设置主窗口大小为屏幕尺寸
    self.window.frame = [UIScreen mainScreen].bounds;
   //设置个颜色看看效果
    //self.window.backgroundColor = JJColorA(234, 212, 32, 255);
    
    
    
 #pragma mark -- 注册通知
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    application.applicationIconBadgeNumber = 0;
   
//设置友盟的AppKey
    [UMSocialData setAppKey:@"578c894ae0f55a30f30008d3"];

    //设置微信AppId、appSecret，分享url(先用友盟的)
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //设置如果检测到当前用户没有安装我集成的分享平台，直接隐藏平台
    //这里面需要隐藏的可以自己加
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];

    
//设置版本新特性
    NSArray* guideImages = @[@"guide1",@"guide2",@"guide3",@"guide4"];
    GuideView* guide = [[GuideView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    guide.guideImages = guideImages;
    [UIView animateWithDuration:0.5 animations:^{
        guide.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];

    //   使用NSUserDefaults来判断程序是否第一次启动
    NSUserDefaults *FirstLaunch = [NSUserDefaults standardUserDefaults];
    if (![FirstLaunch valueForKey:@"firsttime"]) {
        [FirstLaunch setValue:@"sd" forKey:@"firsttime"];
        
        JJTabBarController *Vc = [[JJTabBarController alloc]init];

        self.window.rootViewController = Vc;
        [Vc.view addSubview:guide];
       // [self.window.rootViewController.view addSubview:guide];
    }else{
        //3.设置窗口的根控制器
        self.window.rootViewController = [[JJTabBarController alloc]init];

    }
    //4.使window成为主窗口出现
    [self.window makeKeyAndVisible];

    
    
    return YES;
}
//要在Application中调用一下这个方法(添加系统回调)
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   //当app进入后台的时候，重新将屏幕亮度设置到一个合适的值
    [[UIScreen mainScreen] setBrightness: 0.5];//0.5是自己设定认为比较合适的亮度值
    

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/////禁止全局 横屏
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
//    return UIInterfaceOrientationMaskPortrait;
//}

@end
