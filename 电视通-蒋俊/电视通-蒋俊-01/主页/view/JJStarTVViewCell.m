//
//  JJStarTVViewCell.m
//  电视通-蒋俊-01
//
//  Created by 蒋俊 on 16/7/9.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJStarTVViewCell.h"
#import "JJStarTVModel.h"

@interface JJStarTVViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *channelName;




@end



@implementation JJStarTVViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//重写模型属性
-(void)setStarTV:(JJStarTVModel *)starTV
{
       
    _starTV = starTV;
    
    self.channelName.text = starTV.channelName;
    [self.channelName setFont:[UIFont fontWithName:@"STXingkai" size:28]];
    
    
}

#pragma mark -- 重写cell的frame方法来自己设置Cell的布局
-(void)setFrame:(CGRect)frame
{
    
    //设置Cell的高度少1;//为cell加上分割线，分割线颜色就是tableView的背景色
    frame.size.height -= 1;
    
    
    [super setFrame:frame];
    
}












@end
