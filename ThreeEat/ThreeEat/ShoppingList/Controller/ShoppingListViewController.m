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
#import "ShoppingListTableViewFactory.h"
#import "ShoppingListTableView.h"

@interface ShoppingListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SYTableView *tableView;
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
        
        ShoppingListTableViewFactory *factory = [[ShoppingListTableViewFactory alloc] init];
        _tableView = [factory createTableView];
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

/**初始化*/
-(void)loadData
{
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@"http://f.hiphotos.baidu.com/baike/w%3D268/sign=c9603f592f2eb938ec6d7df4ed6385fe/574e9258d109b3de0105d8d0ccbf6c81810a4ccb.jpg" forKey:@"img"];
    [dict1 setObject:@"五件利器成就外酥内软的布朗尼五件利器成就外酥内软的布朗尼" forKey:@"title"];
    [dict1 setObject:@"1458272953" forKey:@"ctime"];
    [dict1 setObject:@"55" forKey:@"sid"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@"http://images.meishij.net/p/20120308/cc2e8d768df8fd3de6503d765e8d81a1.jpg" forKey:@"img"];
    [dict2 setObject:@"早晚餐皆宜的鸡蛋料理" forKey:@"title"];
    [dict2 setObject:@"1458272953" forKey:@"ctime"];
    [dict2 setObject:@"45" forKey:@"sid"];
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    [dict3 setObject:@"http://f.hiphotos.baidu.com/baike/w%3D268/sign=c9603f592f2eb938ec6d7df4ed6385fe/574e9258d109b3de0105d8d0ccbf6c81810a4ccb.jpg" forKey:@"img"];
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
