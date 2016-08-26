//
//  JJStar-TVViewController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/7.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJStar-TVViewController.h"

//自定义的下拉刷新控件
#import "JJRefreshNormalHeader.h"


//卫视数据模型
#import "JJStarTVModel.h"

//自定义cell
#import "JJStarTVViewCell.h"

//频道详情界面
#import "JJDetailsChannelViewController.h"

@interface JJStar_TVViewController ()<UITableViewDelegate,UITableViewDataSource>

/**UITableView*/
@property (nonatomic , strong)  UITableView *tableView;

/**卫视频道模型数组*/
@property (nonatomic , strong)  NSMutableArray *starTVArrs;



@end

@implementation JJStar_TVViewController

static NSString *starID = @"starCell";

- (void)viewDidLoad {
    [super viewDidLoad];
   //self.view.backgroundColor = JJRandomColor;


    //初始化用户界面
    [self initializeUserInterface];

    //刷新数据
    [self setupRefresh];

  

}



#pragma mark -- /**< 初始化用户界面 */
-(void)initializeUserInterface
{
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark -- 下拉刷新
-(void)setupRefresh
{
    //创建刷新控件并绑定调用方法
    JJRefreshNormalHeader *refreshHeader = [JJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    refreshHeader.automaticallyChangeAlpha = YES;
    //添加
    self.tableView.mj_header = refreshHeader;
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
    
}

#pragma mark -- 网络请求数据
-(void)loadNewData
{
    //配置参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"key"] = AppKey;
    parameter[@"pId"] = @"2";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:ChannelTVURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  NSLog(@"请求成功 -- %@",responseObject);
        
//              [responseObject[@"result"] writeToFile:@"/Users/jiangjun/Desktop/电视通-蒋俊-05/starTV.plist" atomically:YES];
        
       self.starTVArrs = [JJStarTVModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
        //  刷新表格(如果我们遇见那种tableView不走数据源方法，最好试试刷新表格。这种网络请求下来数据后，也刷新一下表格)
        [self.tableView reloadData];
        
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败 -- %@",error);
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}



#pragma mark -- 懒加载tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        
        
        //设置tableView和tableView的滚动条的内边距，让其能够全部显示在屏幕中，不被导航栏和底部标签栏遮挡
        //        self.tableView.contentInset = UIEdgeInsetsMake(99, 0, 49, 0);
        //        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
        
        
        
        
        
        //(self.view.mj_height - 99 - 49)这里高度这样设置是解决那个tableView滑动不到最底下的问题
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 99, self.view.mj_width,  self.view.mj_height - 99 - 49) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        //注册cell(从xib注册)
       [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JJStarTVViewCell class]) bundle:nil] forCellReuseIdentifier:starID];
        
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        _tableView.backgroundColor = [UIColor colorWithRed:0.8078 green:0.8078 blue:0.8078 alpha:1.0];
    }
    
    //设置cell的大概高度
    _tableView.rowHeight = 100;
    //取消自带的分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return _tableView;
    
}

//懒加载卫视数组模型
- (NSMutableArray *)starTVArrs
{
    if (!_starTVArrs) {
        _starTVArrs = [NSMutableArray array];
    }
    
      return  _starTVArrs;
}

#pragma mark -- UITableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self.starTVArrs.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JJStarTVViewCell *cell = [tableView dequeueReusableCellWithIdentifier:starID forIndexPath:indexPath];
    
    //拿到对应行模型
    JJStarTVModel *starTV = self.starTVArrs[indexPath.row];
   cell.starTV = starTV;
   
    
    NSMutableArray *channelImages = [NSMutableArray array];
    
    for (NSInteger index = 1; index < 39; index++) {
        NSString *channelImage = [NSString stringWithFormat:@"%ld.jpg",index];
        [channelImages addObject:channelImage];
    }
    
    cell.channelImage.image = [UIImage jj_circleImage:channelImages[indexPath.row]];
    
    
    
    
    //取消cell选中后的灰色背景
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    
    
    
    
    
    
    
    return cell ;
}

#pragma mark -- UITableView 代理方法
//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取当前点击的cell
    //  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"点击的是 -- %ld",indexPath.row);
  
    
    JJStarTVModel *channel = self.starTVArrs[indexPath.row];
    
    JJDetailsChannelViewController *detailsVc = [[JJDetailsChannelViewController alloc]init];
    detailsVc.hidesBottomBarWhenPushed = YES;
    
    detailsVc.channelCoding = channel.rel;
    [self.navigationController pushViewController:detailsVc animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
    
    
    
    
    
    
    
    
}

//描述cell的方法(为cell写一些小动画)
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.5;
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
    
}













@end
