//
//  JJChannelTVViewCell.m
//  电视通-蒋俊-01
//
//  Created by 蒋俊 on 16/7/8.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJChannelTVViewCell.h"
#import "JJChannelTVModel.h"

@interface JJChannelTVViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *channelName;


@end


@implementation JJChannelTVViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重写模型属性
- (void)setChannelTV:(JJChannelTVModel *)channelTV
{
    _channelTV = channelTV;
    
    self.channelName.text = channelTV.channelName;
    
    //设置字体
    [self.channelName setFont:[UIFont fontWithName:@"STXingkai" size:28]];

    
}


#pragma mark -- 重写cell的frame方法来自己设置Cell的布局
-(void)setFrame:(CGRect)frame
{
    
    //设置Cell的高度少1;//为cell加上分割线，分割线颜色就是tableView的背景色
    frame.size.height -= 1;
    //设置cell左右两边都有10的间距
    //    frame.origin.x += 10;
    //    frame.size.width -= 20;
    //设置顶部也有间距10
    // frame.origin.y += 10;
    //有个扩展知识点，以后我们设置Cell的分割线也可以直接在这个基础上让Cell的高度减1;
    
    [super setFrame:frame];
    
}












@end
