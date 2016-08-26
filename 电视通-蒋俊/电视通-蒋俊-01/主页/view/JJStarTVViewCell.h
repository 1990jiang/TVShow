//
//  JJStarTVViewCell.h
//  电视通-蒋俊-01
//
//  Created by 蒋俊 on 16/7/9.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJStarTVModel;

@interface JJStarTVViewCell : UITableViewCell

/**模型*/
@property (nonatomic , strong) JJStarTVModel *starTV;

@property (weak, nonatomic) IBOutlet UIImageView *channelImage;

@end
