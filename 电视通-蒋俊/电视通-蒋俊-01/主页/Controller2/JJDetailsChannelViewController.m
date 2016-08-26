//
//  JJDetailsChannelViewController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/11.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJDetailsChannelViewController.h"
//自定义cell和模型
#import "JJChannelDetailsCell.h"
#import "JJChannelDetailsModel.h"
//自定义的下拉刷新控件
#import "JJRefreshNormalHeader.h"
//网页界面
#import "JJWebViewController.h"
//自定义导航栏按钮
#import "JJItemManager.h"

@interface JJDetailsChannelViewController ()<UITableViewDataSource,UITableViewDelegate,JJChannelDetailsCellDelegate>


/**tableView*/
@property (nonatomic , strong) UITableView *tableView;


/**模型数组*/
@property (nonatomic , strong) NSMutableArray *channelDetailsArrs;

/**数据库实例*/
@property (nonatomic , strong) FMDatabase *db;


/**右边按钮是否点击的状态*/
@property (nonatomic , strong) NSString *isSelected;

/**右边按钮属性*/
@property (nonatomic , strong) UIButton *rightBtn;



@end

@implementation JJDetailsChannelViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    //每次运行程序时，判断按钮的状态
    BOOL selected = [[NSUserDefaults standardUserDefaults] boolForKey:@"button"];
    [self.rightBtn setSelected:selected];
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    //初始化用户界面
    [self initializeUserInterface];
    
    //刷新数据
    [self setupRefresh];

   //配置导航栏
    [self setupNav];

   //配置数据库
    [self setupFMDB];


}


#pragma mark -- /**< 初始化用户界面 */
-(void)initializeUserInterface
{
    [self.view addSubview:self.tableView];
    
    
    

    
}

#pragma mark -- 配置导航栏
-(void)setupNav
{
   self.title = self.channelCoding;
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    
    //导航左边按钮
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:@selector(popTORootController)];
    
    
    
    UIImage *leftImage = [UIImage imageNamed:@"fanhui.png"];
    //设置图像的渲染样式
    leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(popTORootController)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
//导航右边按钮
  self.rightBtn = [JJItemManager itemWithImage:@"收藏.png" selectedImage:@"收藏-1.png" target:self action:@selector(clickSaveBtn:)];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
  //  self.rightBtn = (UIButton *)rightItem;
}



#pragma mark -- 自定义导航栏左边返回按钮后的返回方法
-(void)popTORootController
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    parameter[@"code"] = self.channelCoding;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:ChannelDetailsURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      // NSLog(@"请求成功 -- %@",responseObject);
        
        //        [responseObject[@"result"] writeToFile:@"/Users/jiangjun/Desktop/蒋俊的项目三/电视通-蒋俊-03/channelTV.plist" atomically:YES];
        
        self.channelDetailsArrs = [JJChannelDetailsModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
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
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.mj_width, self.view.mj_height ) style:UITableViewStylePlain];
    
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.backgroundColor = [UIColor colorWithRed:0.8078 green:0.8078 blue:0.8078 alpha:1.0];

        
    //注册cell
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JJChannelDetailsCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
        //设置cell的大概高度
        _tableView.rowHeight = 100;
        
        //取消自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}








#pragma mark -- tableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.channelDetailsArrs.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JJChannelDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    JJChannelDetailsModel *channelDetail = self.channelDetailsArrs[indexPath.row];
    
    cell.channelDetail = channelDetail;
    
    
    #pragma mark -- 4.设置代理
    
    cell.delegate = self;
    
    return cell;
}


#pragma mark -- tableView的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //拿到模型
    JJChannelDetailsModel *channel = self.channelDetailsArrs[indexPath.row];
    JJWebViewController *webVc = [[JJWebViewController alloc]init];
    
    webVc.channelPlayUrl = channel.pUrl;
    webVc.channelTitle = channel.pName;
    [self.navigationController pushViewController:webVc animated:YES];
    
}


#pragma mark -- 自定义cell的代理方法，用于解决提醒按钮点击后的循环引用
-(void)channelCellIsMarked:(BOOL)isMarked Cell:(JJChannelDetailsCell *)cell
{
    //根据tableView的这个方法拿到
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(_channelDetailsArrs && _channelDetailsArrs.count)
    {
        JJChannelDetailsModel *model = [_channelDetailsArrs objectAtIndex:indexPath.row];
        model.isMarked = isMarked;
    }
}


#pragma mark -- 右边收藏按钮的监听方法
-(void)clickSaveBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
    //保存按钮状态
    [[NSUserDefaults standardUserDefaults] setBool:btn.isSelected forKey:@"button"];
    //用NSUserDefaults 保存数据时都写一个这个同步代码
    [[NSUserDefaults standardUserDefaults] synchronize];

if (btn.selected == YES) {
    
        //增加数据
        NSString *name = self.channelCoding;
        self.isSelected = @"YES";
        
        BOOL flag =  [_db executeUpdate:@"insert into t_save1 (name,state) values (?,?)",name,self.isSelected];
        if (flag) {
            NSLog(@"插入数据成功");
        }
        
        //这里的?号就是SQLite语句中的占位符,这样我们就可以插入可变的字符串了
   }else if (btn.selected == NO)
    {
       
        //删除数据
        BOOL flag = [_db executeUpdate:@"delete from t_save1 where name = (?)",self.channelCoding];
        if (flag) {
            NSLog(@"删除数据成功");
        }
    }
}


#pragma mark -- 配置数据库
-(void)setupFMDB
{
   
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"save1.sqlite"];
    
    //1.创建数据库实例(这个方法就是给一个你保存的数据库的全路径，我给你创建一个数据库实例（仅仅创建一个实例）)
    FMDatabase *db = [FMDatabase databaseWithPath:filePath];
   
    _db = db;
    
    [MJSingle sharedMJSingle].db = db;
    
    //2.打开数据库
    BOOL flag =  [db open];
    if (flag) {
        NSLog(@"打开成功");
    }else
    {
        NSLog(@"打开失败");
    }
  
    //3.创建数据库表
   BOOL flag1 = [db executeUpdate:@"create table if not exists t_save1 (id integer primary key autoincrement, name text, state text );"];
    if (flag1) {
        NSLog(@"创表成功");
    }else
    {
        NSLog(@"创表失败");
    }
}

////视图即将消失的时候
//-(void)viewWillDisappear:(BOOL)animated{
//    
//    //查找数据是用:Query, 返回的是个FMResultSet对象
//    FMResultSet *result = [[MJSingle sharedMJSingle].db executeQuery:@"select * from t_save1;"];
//    
//    //从结果集里面往下找
//    while ([result next]) {
//        //根据字段名取出对应的数据
//        NSString *state = [result stringForColumn:@"state"];
//        self.isSelected = state;
//    }
//
//    if ([self.isSelected isEqualToString:@"YES"]) {
//        self.rightBtn.selected = true;
//    }
//    
//}





















@end
