//
//  JJChannelDetailsModel.h
//  电视通-蒋俊-01
//
//  Created by 蒋俊 on 16/7/11.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJChannelDetailsModel : NSObject

/**电视频道名*/
@property (nonatomic , strong) NSString *cName;

/**电视节目单详情*/
@property (nonatomic , strong) NSString *pName;

/**电视节目播放地址*/
@property (nonatomic , strong) NSString *pUrl;

/**节目播出时间*/
@property (nonatomic , strong) NSString *time;

/**提醒按钮的判断*/
@property (nonatomic , assign) BOOL isMarked;




@end
