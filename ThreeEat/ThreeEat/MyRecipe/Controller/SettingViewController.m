//
//  SettingViewController.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/22.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingFooterView.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SYTool.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, SettingFooterViewDelegate, SYToolDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSMutableArray *cellNames;

@end

@implementation SettingViewController

/**创建表视图*/
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight = 44;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
}

- (void)loadData {
    
    _phoneNum = [DEFAULTS objectForKey:DEFAULTS_phone];
    _cellNames = [NSMutableArray arrayWithObjects:@"清除缓存",@"帮助文档",@"关于我们", nil];
    if (_phoneNum && [_phoneNum intValue]>0) {
        NSString *cellPhoneString = [NSString stringWithFormat:@"手机：%@", _phoneNum];
        [_cellNames insertObject:cellPhoneString atIndex:0];
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    } else {
        while ([cell.contentView.subviews lastObject]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.textLabel.text = _cellNames[indexPath.row];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, CGRectGetHeight(cell.contentView.frame)-0.5, SCREEN_WIDTH-20, 0.5);
    label.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(cell.contentView.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    CGFloat height = SCREEN_HEIGHT-self.tableView.contentSize.height;
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    // Create label with section title
    UIView *sectionView = [[UIView alloc] init];
    
    SettingFooterView *footerView = [[SettingFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-self.tableView.contentSize.height)];
    footerView.delegate = self;
    sectionView = footerView;
    
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self clearAppCache];
    }
}

#pragma mark - SettingFooterViewDelegate
- (void)pushToLoginViewController:(SettingFooterView *)view
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)pushToRegisterViewController:(SettingFooterView *)view
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)clearAppCache
{
    SYTool *tool = [[SYTool alloc] init];
    tool.delegate = self;
    [tool clearAppCache];
}

#pragma mark - SYToolDelegate
- (void)didFinishedClearCache:(SYTool *)tool
{
    NSLog(@"清理完成");
}

-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
