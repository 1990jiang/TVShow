//
//  JJWebViewController.h
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/12.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJWebViewController : UIViewController

/**接收播放地址的字符串*/
@property (nonatomic , strong) NSString *channelPlayUrl;

/**接收播放节目的内容标题*/
@property (nonatomic , strong) NSString *channelTitle;




@end
