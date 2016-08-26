//
//  JJSearchController.m
//  电视通-蒋俊-01
//
//  Created by rimi on 16/7/7.
//  Copyright © 2016年 rimi. All rights reserved.
//

#import "JJSearchController.h"
//很牛的标签效果
#import "XLSphereView.h"

@interface JJSearchController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

/**搜索框*/
@property (nonatomic , strong) UISearchBar *searchBar;

/**标签效果*/
@property (nonatomic , strong) XLSphereView *sphereView;

/**搜索电影结果的tableView*/
@property (nonatomic , strong) UITableView *resultTableView;

/**搜索结果数组*/
@property (nonatomic , strong) NSMutableArray *resultArr;

/**假数据数组*/
@property (nonatomic , strong) NSMutableArray *movieArr;



@end

@implementation JJSearchController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.8902 green:0.9373 blue:0.6157 alpha:0.5];
    //配置导航栏
    [self setupNav];
    
    //初始化用户界面
    [self initializeUserInterface];

}

#pragma mark -- 配置导航栏
-(void)setupNav
{
    self.navigationItem.title = @"电影搜索";
   // [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]}];

}

#pragma mark -- /**< 初始化用户界面 */
-(void)initializeUserInterface
{
    [self.view addSubview:self.searchBar];
    
    [self.view addSubview:self.sphereView];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"search5.png"];
    [self.view addSubview:imageView];
    [self.view sendSubviewToBack:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(32, 100, 100, 44)];
    label.text = @"热门电影:";
    label.textColor = [UIColor colorWithRed:0.9765 green:0.9961 blue:0.9608 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    
    
}

#pragma mark -- 懒加载搜索框
-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.mj_width, 44)];
    //搜索框键盘样式
        _searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
    //提示文字
        _searchBar.placeholder = @"请输入电影名";
    //设置代理
        _searchBar.delegate = self;
    //搜索栏的背景色
    _searchBar.barTintColor = [UIColor colorWithRed:0.8078 green:0.8078 blue:0.8078 alpha:1.0];
    //搜索框的样式
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
   //搜索栏的样式
        _searchBar.barStyle = UIBarStyleDefault;

    }
    
    
    return _searchBar;
}

//懒加载球形标签栏
-(XLSphereView *)sphereView
{
    if (!_sphereView) {
        _sphereView = [[XLSphereView alloc]initWithFrame:CGRectMake(55, 160, 300, 300)];
        NSMutableArray *movieArr = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++) {
            NSArray *array = @[@"精武门",@"警察故事",@"僵尸先生",@"僵尸至尊",@"僵尸翻身",@"追梦人",@"罗马假日",@"探秘",@"麦田",@"侏罗纪公园",@"德古拉2000",@"吸血鬼日记",@"狼人",@"暴力街区",@"速度与激情",@"钢铁侠",@"心花路放",@"泰囧",@"人在囧途",@"海洋天堂"];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:0.7647 green:0.7765 blue:0.8039 alpha:1.0];
            [btn setTitleColor:[UIColor colorWithRed:0.9725 green:0.8275 blue:0.7098 alpha:1.0] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:22];
            btn.frame = CGRectMake(0, 0, 120, 40);
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
            [movieArr addObject:btn];
            [_sphereView addSubview:btn];
        
        }
       
        [_sphereView setItems:movieArr];
    }
    return _sphereView;
}


//懒加载搜索结果tableView
-(UITableView *)resultTableView
{
    if (!_resultTableView) {
        _resultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, self.view.mj_width, self.view.mj_height) style:UITableViewStylePlain];
        
        _resultTableView.dataSource = self;
        _resultTableView.delegate = self;
       //注册cell
        [_resultTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    
    
    return _resultTableView;
    
}
//懒加载搜索结果数组
- (NSMutableArray *)resultArr
{
    if (!_resultArr) {
        _resultArr = [NSMutableArray array];
    }
    
    return _resultArr;
}

//懒加载假数据数组
-(NSMutableArray *)movieArr
{
    if (!_movieArr) {
        _movieArr = [@[@"寒战2",@"大鱼海棠",@"独立日",@"三人行",@"古田会议",@"绝战",@"泰山归来",@"遇见你之前",@"树大招风",@"完美陌生人",@"哭声",@"初恋这首情歌",@"天空之眼",@"破碎人生",@"各有少年时",@"肖申克的救赎",@"盗梦空间",@"阿甘正传",@"教父",@"海豚湾",@"机器人总动员",@"这个杀手不太冷",@"霸王别姬",@"乱世佳人",@"十三太保",@"泰坦尼克号",@"搏击俱乐部",@"美国往事",@"阿凡达",@"海上钢琴师",@"蝙蝠侠",@"星际穿越",@"少年派的奇幻漂流",@"忠犬八公的故事",@"完美世界",@"魔戒",@"放牛班的春天",@"闻香识女人",@"狮子王",@"龙猫",@"罗马假日",@"天空之城",@"飞越疯人院",@"鬼子来了",@"杀人回忆",@"音乐之声",@"天使爱美丽",@"低俗小说",@"情书",@"僵尸先生",@"僵尸翻身",@"疯狂动物城",@"钢琴家",@"死亡诗社",@"活着",@"幽灵公主",@"无法触碰",@"梦之安魂曲",@"一次离别",@"重庆森林",@"见龙卸甲",@"警察故事",@"A计划",@"与狼共舞",@"狼人",@"猩球崛起",@"侏罗纪世界",@"玻璃樽",@"罗生门",@"让子弹飞",@"泰囧",@"当幸福来敲门",@"黑衣人",@"钢铁侠",@"超人",@"神奇四侠",@"复仇者联盟",@"环太平洋",@"独裁者",@"1942",@"我的父亲母亲",@"红高粱",@"七宗罪",@"勇敢的心",@"速度与激情",@"无间道",@"楚门的世界",@"黑天鹅",@"大鱼",@"昆仑",@"蜀山传",@"沉默的羔羊",@"告白",@"燃情岁月",@"窃听风云",@"春光乍泄",@"蓝宇",@"风之谷",@"左耳",@"夏洛特烦恼",@"不能说的秘密",@"头文字D",@"百团大战",@"歼十出击",@"千与千寻",@"功夫",@"大话西游",@"黄河绝恋",@"明日帝国",@"中国",@"好日子",@"一个人的武林",@"传奇",@"我知女人心",@"女人花",@"蜘蛛侠",@"康熙王朝",@"美人鱼",@"我的极品女神",@"美国队长",@"魔兽",@"老炮儿",@"死神来了",@"赏金猎人",@"城市猎人",@"万万没想到",@"三体",@"逆战",@"小时代",@"不要向下看",@"笔仙",@"赌神",@"少林足球",@"海底总动员",@"开心谷",@"诗圣",@"七十二家房客",@"撕裂人",@"三毛流浪记",@"我是谁",@"2012",@"源代码",@"末日之战",@"生死停留",@"死亡幻觉",@"禁闭岛",@"穆赫兰道",@"蝴蝶效应",@"恐怖游轮",@"伤城",@"盗走达芬奇",@"万能钥匙",@"夺宝奇兵",@"",@"",@"真爱至上",@"",@"",@"头号通缉犯",@"婚纱",@"",@"东方不败",@"",@"一级恐惧",@"",@"国家宝藏",@"史密斯夫妇",@"",@"想飞的钢琴少年",@"",@"追捕",@"曼谷杀手",@"乡村教师 ",@"雨人",@"狙击电话亭",@"",@"",@"",@"史努比",@"卧虎藏龙Ⅱ青冥宝剑",@"美国精神病人",@"可爱的骨头",@"记忆裂痕",@"长城",@"鬼吹灯之九层妖塔",@"",@"",@"",@"",@"",@"天堂的孩子",@"自梳",@"",@"抢钱大作战",@"美国派",@"请别相信她",@"地狱",@"奇异博士",@"分手信",@"西游记之孙悟空三打白骨精",@"发达之路",@"狄仁杰",@"游戏规则",@"",@"",@"快枪手",@"放牛班的春天",@"兵临城下",@"蓝莓之夜",@"婚纱",@"神探飞机头",@"恐怖游轮",@"",@"万里长城",@"宾虚",@"爱丽丝镜中奇遇",@"特异儿童之家",@"爵迹",@"疯狂的石头",@"睡魔",@"死侍",@"曾经拥有",@"雏菊",@"怪物高中",@"大红狗",@"恐龙战队",@"埃及众神",@"最好的时刻",@"鸡皮疙瘩",@"全民情敌",@"整蛊至尊",@"打鬼特工队",@"舌尖上的新年",@"不要忘记我",@"动物乌托邦",@"机械师",@"青木原森林",@"洛奇",@"神秘海域",@"盗墓笔记",@"好人们",@"娃娃老板",@"",@"大话王",@"变脸",@"媳妇儿难当",@"血战艳遇",@"茅山后裔之阴阳双剑",@"我唾弃你的坟墓",@"青春劫",@"碟中谍",@"热血兄弟之黑道无情",@"菊花香",@"风语者",@"逍遥法外",@"飞越未来",@"",@"战争与和平",@"神奇遥控器",@"死亡别墅",@"魔面怪杰",@"盗走达芬奇",@"惊情四百年",@"木乃伊",@"证据",@"偷天情缘",@"美丽心灵的永恒阳光",@"辛德勒的名单",@"天才瑞普利",@"心灵捕手",@"大话天珠",@"超能太监",@"我脑中的橡皮擦",@"莫扎特传",@"无主之城",@"赌城风云",@"巴顿将军",@"暗花",@"低级小说",@"盗火线",@"失眠症",@"母女情深",@"爱谁谁之所谓相爱",@"触不到的恋人",@"嫌疑人的献身",@"寻找弗罗斯特",]mutableCopy];
    }
    
    
    return _movieArr;
}

#pragma mark -- 球形标签效果的按钮监听方法
- (void)buttonPressed:(UIButton *)btn
{
    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
        
            self.searchBar.text = btn.currentTitle;
        
        }];
    }];
}


#pragma mark -- 搜索框的代理方法
//刚刚开始在输入框输入时(搜索框刚刚成为第一响应者时)
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
   
    //加载tabelView并移除那个最热标签
    [self.sphereView removeFromSuperview];
    [self.view addSubview:self.resultTableView];
    
    searchBar.showsCancelButton = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    //重新设置取消按钮
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor colorWithRed:0.5843 green:0.7333 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
        }
    }

    
    
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    //将搜索结果数组置为空
    self.resultArr = nil;
    //
    for (int i = 0 ; i < self.movieArr.count; i++) {
        NSString *string = self.movieArr[i];
       
        if (string.length >= searchText.length && searchText.length != 0) {
            //截取出本地影片名(截取的长度取决于我们那个搜索框中输入的长度)
            NSString *movieName = [self.movieArr[i] substringWithRange:NSMakeRange(0, searchText.length)];
            //判断根据输入长度截取出来的本地字符和搜索框中的是否相等
           
            if ( [movieName isEqualToString:searchText]) {
                //给结果数组添加数据
                [self.resultArr addObject:self.movieArr[i]];
                
            }
//              else if (self.resultArr.count == 0)
//            {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不好意思" message:@"找不到您要搜索的电影" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
//                 [alert addAction:sure];
//                
//              [self presentViewController:alert animated:YES completion:^{
//                 
//                  searchBar.text = nil;
//                  
//              }];
//                
//            }
            
        }
        
    }
    
   //刷新表格数据
    [self.resultTableView reloadData];
}

//搜索按钮点击的回调
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
    
    if (self.resultArr.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不好意思" message:@"找不到您要搜索的电影" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:^{
            
            searchBar.text = nil;
            
        }];
        
    }else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"已是全部搜索结果" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:sure];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

//searchBar结束编辑时调用
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   

}



/**
 *  取消按钮的响应事件
 *
 *  @param searchBar UISearchBar
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
  //点击取消按钮，将标签动画加载回来，将tableView隐藏
    [self.view addSubview:self.sphereView];
    [self.resultTableView removeFromSuperview];

  //点击取消按钮清空searchBar
    searchBar.text = nil;
}


#pragma mark -- UITableView的处理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArr.count;


}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.resultArr[indexPath.row];
    return cell;
}


#pragma mark -- UITableView的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.searchBar.text = self.resultArr[indexPath.row];
    
    
    
}










































































@end
