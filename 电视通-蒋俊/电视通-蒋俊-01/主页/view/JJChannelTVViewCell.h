//
//  JJChannelTVViewCell.h
//  电视通-蒋俊-01
//
//  Created by 蒋俊 on 16/7/8.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJChannelTVModel;

@interface JJChannelTVViewCell : UITableViewCell

/**模型*/
@property (nonatomic , strong) JJChannelTVModel *channelTV;

@property (weak, nonatomic) IBOutlet UIImageView *channelImage;

@end
