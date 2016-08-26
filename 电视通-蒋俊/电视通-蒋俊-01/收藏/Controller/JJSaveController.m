//
//  JJSaveController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/7.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJSaveController.h"
//自定义cell
#import "JJSaveCollectionViewCell.h"

@interface JJSaveController ()<UICollectionViewDelegate,UICollectionViewDataSource>



/**收藏背景图*/
@property (nonatomic , strong)  UIImageView *saveImage;

/**滚动视图*/
@property (nonatomic , strong)  UIScrollView *saveScrollView;

/**收藏的集合*/
@property (nonatomic , strong)  UICollectionView *saveCollection;

/**接收传过来的频道名*/
@property (nonatomic , strong)  NSMutableArray *saveArrs;





@end

@implementation JJSaveController

//视图即将出现的时候
-(void)viewWillAppear:(BOOL)animated
{
    [self.saveCollection reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

   // self.view.backgroundColor = [UIColor greenColor];
   
    [self setupNav];
    
    
}


#pragma mark -- 配置导航栏
-(void)setupNav
{
    
    self.navigationItem.title = @"频道收藏";
  //可以把用户界面push过来时左上角的箭头去掉
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]init];
    self.navigationItem.leftBarButtonItem = leftItem;

    //初始化用户界面
    [self initializeUserInterface];

    
}


#pragma mark -- 懒加载
//懒加载数据库数组
-(NSMutableArray *)saveArrs
{
    if (!_saveArrs) {
        _saveArrs = [NSMutableArray array];
    }
    
    return _saveArrs;
}


//懒加载背景图片
-(UIImageView *)saveImage
{
    if (!_saveImage) {
        _saveImage = [[UIImageView alloc]init];
        _saveImage.frame = CGRectMake(0, 0, self.saveScrollView.mj_width, self.saveScrollView.mj_height);
        _saveImage.image = [UIImage imageNamed:@"收藏背景1"];
         [_saveImage addSubview:self.saveCollection];
       
    }
    return _saveImage;
}

//懒加载scrollView
-(UIScrollView *)saveScrollView
{
    if (!_saveScrollView) {
        _saveScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_width, self.view.mj_height - 49)];
        _saveScrollView.backgroundColor = [UIColor colorWithRed:0.8745 green:0.8902 blue:0.6314 alpha:1.0];
      //去掉垂直的滑动线
        _saveScrollView.showsVerticalScrollIndicator = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        _saveScrollView.contentSize = CGSizeMake(0, 740);
        [_saveScrollView addSubview:self.saveImage];
   
        
    }
    return _saveScrollView;
}

//懒加载收藏的集合视图
-(UICollectionView *)saveCollection
{
    if (!_saveCollection) {
      //先写布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(350, 60);
        //每个item间的距离
       //layout.minimumInteritemSpacing = 10;
        //每一行item间的距离
        layout.minimumLineSpacing = 15;
      //初始化collectionView
        _saveCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 5, self.saveImage.mj_width, self.saveImage.mj_height- 49) collectionViewLayout:layout];
        _saveCollection.backgroundColor = [UIColor clearColor];
        _saveCollection.dataSource = self;
        _saveCollection.delegate = self;
        
      //注册collectionViewCell
        [_saveCollection registerNib:[UINib nibWithNibName:NSStringFromClass([JJSaveCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _saveCollection;
}

#pragma mark -- /**< 初始化用户界面 */
-(void)initializeUserInterface
{
    
    [self.view addSubview:self.saveScrollView];
    //[self.view addSubview:self.saveImage];
    
    
}

#pragma mark -- 集合视图数据源方法


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //查询数据
    //查找数据是用:Query, 返回的是个FMResultSet对象
  FMResultSet *result = [[MJSingle sharedMJSingle].db executeQuery:@"select * from t_save1;"];
    
    //从结果集里面往下找
    while ([result next]) {
        //根据字段名取出对应的数据
        NSString *name = [result stringForColumn:@"name"];
        [self.saveArrs addObject:name];
    }

     
    return self.saveArrs.count;
  
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JJSaveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.channelLabel.text = [NSString stringWithFormat:@"®%@",self.saveArrs[indexPath.row]];
   // NSLog(@"---%@",self.saveArrs[0]);
    
    return cell;
}




#pragma mark -- 集合视图代理方法
















@end
