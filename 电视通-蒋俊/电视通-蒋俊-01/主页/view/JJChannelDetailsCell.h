//
//  JJChannelDetailsCell.h
//  电视通-蒋俊-01
//
//  Created by 蒋俊 on 16/7/11.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJChannelDetailsModel;
@class JJChannelDetailsCell;


#pragma mark -- 1.写个协议(解决点击提醒按钮后，循环引用的问题)

@protocol JJChannelDetailsCellDelegate <NSObject>

//实现的方法

-(void)channelCellIsMarked:(BOOL)isMarked Cell:(JJChannelDetailsCell *)cell;

@end

@interface JJChannelDetailsCell : UITableViewCell

/**模型属性*/
@property (nonatomic , strong) JJChannelDetailsModel *channelDetail;

@property (weak, nonatomic) IBOutlet UIButton *remindBtn;

#pragma mark -- 2 定义代理属性
/**代理属性*/
@property (nonatomic , weak) id<JJChannelDetailsCellDelegate> delegate;

/**单独的时间属性来接收那个网络申请下来的时间*/
@property (nonatomic , strong)  NSString *playTime;

/**电视频道名*/
@property (nonatomic , strong) NSString *channelName;

/**电视节目单详情*/
@property (nonatomic , strong) NSString *contentTV;

@end
