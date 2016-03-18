//
//  ShoppingListViewController.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

//#define SYWidth [UIScreen mainScreen].bounds.size.width
//#define SYHeight [UIScreen mainScreen].bounds.size.height

#import "ShoppingListViewController.h"
#import "ShoppingListCell.h"
#import "SYShoppingList.h"

@interface ShoppingListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *shoppingList;

@end

@implementation ShoppingListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.shoppingList removeAllObjects];
    [self loadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.view addSubview:self.tableView];
    [self addHeader];
    [self addFooter];
}
/**创建表视图*/
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

/**初始化*/
-(void)loadData
{
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@"https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D360/sign=1b99a81332d3d539de3d09c50a86e927/ae51f3deb48f8c54469d4dc23e292df5e1fe7f95.jpg" forKey:@"img"];
    [dict1 setObject:@"五件利器成就外酥内软的布朗尼五件利器成就外酥内软的布朗尼" forKey:@"title"];
    [dict1 setObject:@"1458272953" forKey:@"ctime"];
    [dict1 setObject:@"55" forKey:@"sid"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@"https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=9dc05140d4a20cf45990f9df46084b0c/d058ccbf6c81800add9a5fc9b53533fa838b47fe.jpg" forKey:@"img"];
    [dict2 setObject:@"早晚餐皆宜的鸡蛋料理" forKey:@"title"];
    [dict2 setObject:@"1458272953" forKey:@"ctime"];
    [dict2 setObject:@"45" forKey:@"sid"];
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    [dict3 setObject:@"https://ss1.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/image/h%3D200/sign=c898bddf19950a7b6a3549c43ad0625c/14ce36d3d539b600be63e95eed50352ac75cb7ae.jpg" forKey:@"img"];
    [dict3 setObject:@"意大利宽面配青酱和xun干牛肉" forKey:@"title"];
    [dict3 setObject:@"1458272953" forKey:@"ctime"];
    [dict3 setObject:@"23" forKey:@"sid"];
    NSArray *array = @[dict1, dict2, dict3];
    
    NSArray *lists = [SYShoppingList shoppingListsWithArray:array];
    [_shoppingList addObjectsFromArray:lists];
    [_tableView reloadData];
}

- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [_tableView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc reloadData];
            // 结束刷新
            [vc.tableView headerEndRefreshing];
        });
    }];
    
    // 自动刷新(一进入程序就下拉刷新)
//    [_tableView headerBeginRefreshing];
}

//创建刷新和加载更多地控件
- (void)addFooter
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    _tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _tableView.footerRefreshingText = @"正在帮你加载中,请稍等";
}

- (void)footerRereshing
{
    NSLog(@"ccccc");
}

#pragma mark - 懒加载
- (NSMutableArray *)shoppingList {
    if (_shoppingList == nil) {
        _shoppingList = [NSMutableArray array];
    }
    return _shoppingList;
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"_shoppingList:%lu", (unsigned long)_shoppingList.count);
    return _shoppingList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const cid=@"cid";
    ShoppingListCell *cell=[tableView dequeueReusableCellWithIdentifier:cid];
    if(!cell)
        cell=[[ShoppingListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    SYShoppingList *shoppingList = _shoppingList[indexPath.row];
    cell.shoppingList = shoppingList;
    __weak typeof(self) wkSelf=self;
    __weak typeof(cell) wkCell=cell;
    //取消的回调
    cell.cancelCallBack=^{
        //关闭菜单
        [wkCell closeMenuWithCompletionHandle:^{
            //发送取消关注的请求
            //若请求成功，则从数据源中删除以及从界面删除
            [wkSelf.shoppingList removeObjectAtIndex:indexPath.row];
            [wkSelf.tableView reloadData];
            
        }];
    };
    //删除的回调
    cell.deleteCallBack=^{
        //关闭菜单
        [wkCell closeMenuWithCompletionHandle:^{
            //发送删除请求
            //若请求成功，则从数据源中删除以及从界面删除
            [wkSelf.shoppingList removeObjectAtIndex:indexPath.row];
            [wkSelf.tableView reloadData];
        }];
    };
    //左右滑动的回调
    cell.swipCallBack=^{
        for(ShoppingListCell *tmpCell in tableView.visibleCells)
            [tmpCell closeMenuWithCompletionHandle:nil];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)reloadData
{
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
