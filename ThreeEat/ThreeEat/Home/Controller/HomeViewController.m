//
//  HomeViewController.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/14.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#define SYCollectionMargin      10
#define SYHeightOfHeader        172
#define HEADER_IDENTIFIER @"WaterfallHeader"

#import "HomeViewController.h"
#import "BannerModel.h"
#import "AdView.h"
#import "BannerModel.h"
#import "LNGood.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallHeader.h"
//#import "HomeCollectionHeader.h"

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CHTCollectionViewDelegateWaterfallLayout,CHTCollectionViewWaterfallCellDelegate>

// 商品列表数组
@property (nonatomic, strong) NSMutableArray *goodsList;
// 当前的数据索引
@property (nonatomic, assign) NSInteger index;
// 是否正在加载数据标记
@property (nonatomic, assign, getter=isLoading) BOOL loading;
// 瀑布流布局
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation HomeViewController

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
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
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
    [_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:HEADER_IDENTIFIER];
    
    [self loadData];
    [self addHeader];
    [self createRefreshView];
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
- (void)createRefreshView{
    
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
    // 刷新数据
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
        //广告轮播
        NSArray *imagesURL = @[
                               @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                               @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                               @"http://img14.360buyimg.com/n6/jfs/t2200/83/1603372575/63020/fd2c7af2/56ce60aaNdc53e003.jpg"
                               ];
        // 情景三：图片配文字(可选)
        NSArray *titles = @[@"感谢您的支持，如果下载的",
                            @"代码在使用过程中出现问题",
                            @"您可以发邮件到qzycoder@163.com",
                            ];
        
        NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
        [dic1 setObject:imagesURL[0] forKey:@"bannerUrl"];
        [dic1 setObject:titles[0] forKey:@"bannerTitle"];
        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
        [dic2 setObject:imagesURL[1] forKey:@"bannerUrl"];
        [dic2 setObject:titles[1] forKey:@"bannerTitle"];
        NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
        [dic3 setObject:imagesURL[2] forKey:@"bannerUrl"];
        [dic3 setObject:titles[2] forKey:@"bannerTitle"];
        
        NSMutableArray *models = [NSMutableArray arrayWithObjects:dic1, dic2, dic3, nil];
        models = [BannerModel bannerModelWithArray:models];
        
        AdView *adView = [AdView adScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SYHeightOfHeader) modelArr:models imagePropertyName:@"bannerUrl" pageControlShowStyle:UIPageControlShowStyleCenter];
        [adView setAdTitlePropertyName:@"bannerTitle" withShowStyle:AdTitleShowStyleCenter];
        //    adView.isNeedCycleRoll = YES;     //是否需要支持定时循环滚动，默认为YES
        adView.adMoveTime = 5.0;                //设置图片滚动时间,默认3s
        
        //图片被点击后回调的方法
        adView.callBackForModel = ^(BannerModel *banner) {
            NSLog(@"%@--%@",banner.bannerTitle, banner.bannerUrl);
        };
        [reusableview addSubview:adView];

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

- (void)addCollection:(CHTCollectionViewWaterfallCell *)cell
{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    LNGood *good = _goodsList[indexPath.row];
    good.isCollection = @"1";
    good.collectionNum = [NSString stringWithFormat:@"%d", [good.collectionNum intValue]+1];
    [self reloadData];
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
