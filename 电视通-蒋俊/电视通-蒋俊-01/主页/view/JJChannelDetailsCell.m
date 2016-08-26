//
//  JJChannelDetailsCell.m
//  电视通-蒋俊-01
//
//  Created by 蒋俊 on 16/7/11.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJChannelDetailsCell.h"
#import "JJChannelDetailsModel.h"
#import "AppDelegate.h"
#import "JJTabBarController.h"


@interface JJChannelDetailsCell ()

@property (weak, nonatomic) IBOutlet UILabel *channelDetailsLabel;

@property (weak, nonatomic) IBOutlet UILabel *channelTime;


@end



@implementation JJChannelDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    //设置提醒按钮选中状态下的图片
    [self.remindBtn setImage:[UIImage imageNamed:@"通知-1"] forState:UIControlStateSelected];

}


//重写模型的set方法
- (void)setChannelDetail:(JJChannelDetailsModel *)channelDetail
{
    _channelDetail = channelDetail;
    
    self.channelDetailsLabel.text = channelDetail.pName;
    self.channelTime.text = channelDetail.time;
 
    //重新给提醒按钮的状态赋值
    self.remindBtn.selected = channelDetail.isMarked;
    
    //Wie后面设置本地通知做准备
    self.playTime = channelDetail.time;
    self.channelName = channelDetail.cName;
    self.contentTV = channelDetail.pName;
    
}

#pragma mark -- 重写cell的frame方法来自己设置Cell的布局
-(void)setFrame:(CGRect)frame
{
    
   
    //设置Cell的高度少1;//为cell加上分割线，分割线颜色就是tableView的背景色
    frame.size.height -= 1;
    
    [super setFrame:frame];
    
}

#pragma mark -- 提醒按钮的点击方法

- (IBAction)clickRemindBtn:(UIButton *)sender {
   
    [sender setSelected:sender.selected ? false : true];
 // NSLog(@"时间%@,频道%@,内容%@",self.playTime,self.channelName,self.contentTV);
    
//   //时间转码
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
//    NSTimeZone * timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//    [fmt setTimeZone:timeZone];
//   //将当前时间转换为那个NSDate格式的
//    NSDate *playDate = [fmt dateFromString:self.playTime];
    
  //手机当前时间
    NSDateFormatter *fmt1 = [[NSDateFormatter alloc]init];
    fmt1.dateFormat = @"yyyy-MM-dd HH:mm";
    //设置东8区
    [fmt1 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];
    
    NSDate *nowDate = [NSDate date];
    NSString *nowStringDate = [fmt1 stringFromDate:nowDate];
    
  #pragma mark -- 分别截取出当前手机时间和节目播放时间的小时和分钟数
    NSString *nowHour = [nowStringDate substringWithRange:NSMakeRange(11, 2)];
   // NSLog(@"--%@",nowHour);
  NSString *nowSecond = [nowStringDate substringWithRange:NSMakeRange(14, 2)];
   // NSLog(@"--%@",nowSecond);

    int tegerHour = [nowHour intValue];
   // NSLog(@"%ld",tegerHour);
    int tegerSecond = [nowSecond intValue];
    
   //截取播放时间的时和分
    NSString *playHour = [self.playTime substringWithRange:NSMakeRange(11, 2)];
    NSString *playSecond = [self.playTime substringWithRange:NSMakeRange(14, 2)];
    int playHour1 = [playHour intValue];
    int playSecond1 = [playSecond intValue];
    
    
    if (tegerHour > playHour1 || (tegerHour == playHour1 && (tegerSecond - 5) > playSecond1)) {
        //设置提醒按钮无法点击
        sender.selected = false;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不好意思" message:@"您想预订的节目已播出或正在播出" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:sure];

        
        UIViewController *rootVc = [[[UIApplication sharedApplication]keyWindow] rootViewController];
        [rootVc presentViewController:alert animated:NO completion:nil];

    }else if (playHour1 > tegerHour || (playHour1 == tegerHour && (playSecond1 - 5)) > tegerSecond)
    {
        sender.selected = false;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"尊敬的用户" message:@"您是否要预定当前节目，我们会在节目开始前5分钟提醒您" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            sender.selected = true;
            //本地通知写到这里
           // 获得当前手机时间和播放时间间的差值
    
            NSTimeInterval hourInterval = (NSTimeInterval)(playHour1 - tegerHour)*3600;
            NSTimeInterval secondInterval = (NSTimeInterval)(playSecond1 - 5 - tegerSecond)*60;

    #pragma mark -- 本地通知
                    //本地通知
                    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
                    //触发时间
                   localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:(hourInterval + secondInterval)];
           // NSLog(@"--%f",(hourInterval + secondInterval));
                    //通知内容
                    localNoti.alertBody = [NSString stringWithFormat:@"您预订的%@频道的%@节目即将开始",self.channelName,self.contentTV];
                    //通知标题(一般写app名称)
                    localNoti.alertTitle = @"电视通";
                    //通知徽标
                    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
                    //根据设定的时间发送通知:
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
            
            
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        
        [alert addAction:sure];
        [alert addAction:cancel];
       
        UIViewController *rootVc = [[[UIApplication sharedApplication]keyWindow] rootViewController];
        [rootVc presentViewController:alert animated:NO completion:nil];
        
     }
    
    
  
    
//获得结果比较大小
//   // NSComparisonResult result = [nowDate compare:playDate];
//    
//    if (result == NSOrderedDescending || result == NSOrderedSame) {//播放时间小于或等于当前时间
//        //设置提醒按钮无法点击
//        sender.selected = false;
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不好意思" message:@"您想预订的节目已播出或正在播出" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction:sure];
//      
//        //这里有个bug
//        UIViewController *rootVc = [[[UIApplication sharedApplication]keyWindow] rootViewController];
//        [rootVc presentViewController:alert animated:NO completion:nil];
//
//      
//        
//    }else if (result == NSOrderedAscending)
//    {
//        //播放时间大于手机当前时间
//      
//      
//        
//     //获得当前手机时间和播放时间间的差值
//        NSTimeInterval interval = [playDate timeIntervalSinceNow];
//        NSLog(@"--%f",interval);
//     #pragma mark -- 本地通知
//        //本地通知
//        UILocalNotification *localNoti = [[UILocalNotification alloc] init];
//        //触发时间
 //       localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:interval];
//        //通知内容
//        localNoti.alertBody = [NSString stringWithFormat:@"您预订的%@频道的%@节目即将开始",self.channelName,self.contentTV];
//        //通知标题(一般写app名称)
//        localNoti.alertTitle = @"电视通";
//        //通知徽标
//        [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
//        //根据设定的时间发送通知:
//        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
//    }
    
    
    
    
    
    
    #pragma mark -- 3.判断代理者是否遵守了代理协议，如果遵守了就做事情
    if ([_delegate respondsToSelector:@selector(channelCellIsMarked:Cell:)]) {
        //如果遵守了代理协议，就把那个按钮的选中状态和当前的cell传过去
        [_delegate channelCellIsMarked:sender.selected Cell:self];
    }
}




















@end
