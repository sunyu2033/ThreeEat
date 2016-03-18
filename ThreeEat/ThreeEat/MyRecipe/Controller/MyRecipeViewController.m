//
//  MyRecipeViewController.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#define SYCollectionMargin      10
#define SYHeightOfHeader        70
#define HEADER_IDENTIFIER @"WaterfallHeader"

#import "MyRecipeViewController.h"
#import "BannerModel.h"
#import "AdView.h"
#import "BannerModel.h"
#import "LNGood.h"
#import "MJRefresh.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "RecipeCollectionHeader.h"
#import "SYInfo.h"
#import "MyInfoView.h"
#import "ShoppingListViewController.h"

@interface MyRecipeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout,CHTCollectionViewWaterfallCellDelegate, MyInfoViewDelegate>

// 商品列表数组
@property (nonatomic, strong) NSMutableArray *goodsList;
// 当前的数据索引
@property (nonatomic, assign) NSInteger index;
// 是否正在加载数据标记
@property (nonatomic, assign, getter=isLoading) BOOL loading;
// 瀑布流布局
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RecipeCollectionHeader *headerView;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation MyRecipeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
    
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self startLoading];
    //    [self stopLoading];
    CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    flowLayout.headerHeight = SYHeightOfHeader;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, SYCollectionMargin, SYCollectionMargin, SYCollectionMargin);
    
    //collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = self.view.backgroundColor;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.allowsMultipleSelection = NO;                    //默认为NO,是否可以多选
    _collectionView.scrollEnabled = YES;
    [self.view addSubview:_collectionView];
    
    //注册
    [_collectionView registerClass:[CHTCollectionViewWaterfallCell class] forCellWithReuseIdentifier:@"CHTCollectionViewWaterfallCell"];
    
    //定义 section的  headerView
    //此处的identifier:@"HeaderView" 和 viewForSupplementaryElementOfKind 中的必须一样
    //还可以设置footer
    [_collectionView registerClass:[RecipeCollectionHeader class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    
    [self loadData];
    [self addHeader];
    [self addFooter];
}

- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc reloadData];
            // 结束刷新
            [vc.collectionView headerEndRefreshing];
        });
    }];
    
    // 自动刷新(一进入程序就下拉刷新)
//    [self.collectionView headerBeginRefreshing];
}

//创建刷新和加载更多地控件
- (void)addFooter{
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    _collectionView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _collectionView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _collectionView.footerRefreshingText = @"正在帮你加载中,请稍等";
}

- (void)footerRereshing {
    NSLog(@"footer");
}

/**
 *  加载数据
 */
- (void)loadData {
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setObject:@"http://e.hiphotos.baidu.com/image/pic/item/8cb1cb1349540923592e4e479758d109b3de4947.jpg" forKey:@"img"];
    [dict1 setObject:@"速成巧克力布丁" forKey:@"title"];
    [dict1 setObject:@"甜点和烘烤食品" forKey:@"discribe"];
    [dict1 setObject:@"6,263" forKey:@"admireNum"];
    [dict1 setObject:@"1" forKey:@"isAdmire"];
    [dict1 setObject:@"21.3K" forKey:@"collectionNum"];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setObject:@"http://f.hiphotos.baidu.com/image/pic/item/242dd42a2834349b7eaf886ccdea15ce37d3beaa.jpg" forKey:@"img"];
    [dict2 setObject:@"法式香草面包(Fougasse)配番茄干" forKey:@"title"];
    [dict2 setObject:@"快手甜品" forKey:@"discribe"];
    [dict2 setObject:@"21.3K" forKey:@"admireNum"];
    [dict2 setObject:@"0" forKey:@"isAdmire"];
    [dict2 setObject:@"6,298" forKey:@"collectionNum"];
    
    
    NSArray *array = [NSArray arrayWithObjects:dict1,dict2,dict2,dict2,dict1,dict2,dict2,dict2,dict2,dict1,dict2,dict2,dict2,dict1,nil];
    NSArray *goods = [LNGood goodsWithArray:array];
    goods = [CHTCollectionViewWaterfallCell getContentHeight:goods];
    [self.goodsList addObjectsFromArray:goods];
}

#pragma mark - 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建可重用的cell
    
    CHTCollectionViewWaterfallCell *cell = (CHTCollectionViewWaterfallCell *)[collectionView
                                                                              dequeueReusableCellWithReuseIdentifier:@"CHTCollectionViewWaterfallCell"
                                                                              forIndexPath:indexPath];
    cell.delegate = self;
    LNGood *good = self.goodsList[indexPath.row];
    cell.good = good;
    
    return cell;
}

#pragma mark - FooterView
/**
 *  追加视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == CHTCollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:HEADER_IDENTIFIER
                                                                 forIndexPath:indexPath];
        
        NSDictionary *dic = @{@"icon":@"http://e.hiphotos.baidu.com/image/pic/item/8cb1cb1349540923592e4e479758d109b3de4947.jpg",
                              @"username":@"孙玉",
                              @"levelName":@"食神"};
        SYInfo *info = [SYInfo infoWithDict:dic];
        MyInfoView *infoView = [[MyInfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, SYHeightOfHeader)];
        infoView.delegate = self;
        infoView.info = info;
        [reusableview addSubview:infoView];
        
    }else if (kind == CHTCollectionElementKindSectionFooter) {
        
    }
    return reusableview;
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - 懒加载
- (NSMutableArray *)goodsList {
    if (_goodsList == nil) {
        _goodsList = [NSMutableArray array];
    }
    return _goodsList;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LNGood *good = _goodsList[indexPath.item];
    CGSize size = CGSizeMake(good.w, good.h+good.contentHeight);
    return size;
}

- (void)addAdmire:(CHTCollectionViewWaterfallCell *)cell
{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    LNGood *good = _goodsList[indexPath.row];
    good.isAdmire = @"1";
    good.admireNum = [NSString stringWithFormat:@"%d", [good.admireNum intValue]+1];
    [self reloadData];
}

- (void)pushToFavorViewController:(MyInfoView *)view
{
    
}

- (void)pushToSettingViewController:(MyInfoView *)view
{

}

- (void)reloadData
{
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
