//
//  ShoppingListTableViewFactory.m
//  ThreeEat
//
//  Created by WuJiaqi on 16/3/21.
//  Copyright © 2016年 Samsun. All rights reserved.
//

#import "ShoppingListTableViewFactory.h"
#import "ShoppingListTableView.h"

@implementation ShoppingListTableViewFactory

- (SYTableView *)createTableView
{
    ShoppingListTableView *tableView = [[ShoppingListTableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return tableView;
}

@end
