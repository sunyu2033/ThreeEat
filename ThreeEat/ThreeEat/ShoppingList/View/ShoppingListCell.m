//
//  TestCell.m
//  test
//
//  Created by 夏桂峰 on 16/1/9.
//  Copyright (c) 2016年 夏桂峰. All rights reserved.
//

#define SYCellHeight    70

#import "ShoppingListCell.h"

@interface ShoppingListCell()

@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *recipeNameLabel;
@property(nonatomic,strong) UILabel *ctimeLabel;
@property(nonatomic,strong) UIView *containerView;

@end

@implementation ShoppingListCell

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        for(UIView *sub in self.contentView.subviews)
        {
            [sub removeFromSuperview];
        }
        [self createUI];
    }
    return self;
}

- (void)setShoppingList:(SYShoppingList *)shoppingList
{
    NSURL *url = [NSURL URLWithString:shoppingList.img];
    [self.iconView sd_setImageWithURL:url];
    self.recipeNameLabel.text = shoppingList.title;
    self.ctimeLabel.text = [[Common sharedService] stringFromTimestamp:shoppingList.ctime withFormat:@"YYYY-MM-dd hh:mm"];
    
    [self setFrames];
}

- (void)setFrames {
    
    _iconView.frame = CGRectMake(10, 10, 50, 50);
    _recipeNameLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame)+10, CGRectGetMinY(_iconView.frame), kWidth-CGRectGetMaxX(_iconView.frame)-10*2, 34);
    _ctimeLabel.frame = CGRectMake(CGRectGetMinX(_recipeNameLabel.frame), CGRectGetMaxY(_recipeNameLabel.frame), CGRectGetWidth(_recipeNameLabel.frame), 20);
}

//创建UI
-(void)createUI
{
    //取消关注按钮
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(kWidth-100, 0, 50, SYCellHeight)];
    cancelBtn.backgroundColor=[UIColor grayColor];
    [cancelBtn setTitle:@"分享" forState:UIControlStateNormal];
    cancelBtn.titleLabel.numberOfLines=0;
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    //删除按钮
    UIButton *deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(kWidth-50, 0, 50, SYCellHeight)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.backgroundColor=[UIColor redColor];
    deleteBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:cancelBtn];
    [self.contentView addSubview:deleteBtn];
    
    //容器视图
    _containerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, SYCellHeight)];
    _containerView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_containerView];
    if(_isOpen)
        _containerView.center=CGPointMake(kWidth/2-100, _containerView.center.y);
    
    //添加左滑手势
    UISwipeGestureRecognizer *swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [_containerView addGestureRecognizer:swipLeft];
    
    //添加右滑手势
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [_containerView addGestureRecognizer:swipRight];
}

- (UIImageView *) iconView {
    
    if (!_iconView) {
        _iconView=[[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 4;
        _iconView.clipsToBounds = YES;
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [_containerView addSubview:_iconView];
        
        UILabel *seperator = [[UILabel alloc] init];
        seperator.frame = CGRectMake(0, SYCellHeight-0.5, kWidth, 0.5);
        seperator.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:seperator];
    }
    return _iconView;
}

- (UILabel *) recipeNameLabel{
    
    if (!_recipeNameLabel) {
        _recipeNameLabel=[[UILabel alloc]init];
        _recipeNameLabel.font = [UIFont systemFontOfSize:14];
        _recipeNameLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _recipeNameLabel.numberOfLines = 0;
        [_containerView addSubview:_recipeNameLabel];
    }
    return _recipeNameLabel;
}

- (UILabel *) ctimeLabel{
    
    if (!_ctimeLabel) {
        _ctimeLabel=[[UILabel alloc]init];
        _ctimeLabel.font = [UIFont systemFontOfSize:13];
        [_containerView addSubview:_ctimeLabel];
    }
    return _ctimeLabel;
}

/**取消关注*/
-(void)cancelAction
{
    if(self.cancelCallBack)
        self.cancelCallBack();
}
/**删除*/
-(void)deleteAction
{
    if(self.deleteCallBack)
        self.deleteCallBack();
}
/**滑动手势*/
-(void)swip:(UISwipeGestureRecognizer *)sender
{
    //滑动的回调
    if(self.swipCallBack)
        self.swipCallBack();
    //左滑
    if(sender.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        if(_isOpen)
            return;
        [UIView animateWithDuration:0.3 animations:^{
            sender.view.center=CGPointMake(sender.view.center.x-100, sender.view.center.y);
        }];
        _isOpen=YES;
    }
    //右滑
    else if(sender.direction==UISwipeGestureRecognizerDirectionRight)
    {
        if(!_isOpen)
            return;
        [UIView animateWithDuration:0.3 animations:^{
            sender.view.center=CGPointMake(kWidth/2, sender.view.center.y);
        }];
        _isOpen=NO;
    }
}
/**关闭左滑菜单*/
-(void)closeMenuWithCompletionHandle:(void (^)(void))completionHandle
{
    if(!_isOpen)
        return;
    __weak typeof(self) wkSelf=self;
    [UIView animateWithDuration:0.3 animations:^{
        wkSelf.containerView.center=CGPointMake(kWidth/2, wkSelf.containerView.center.y);
    }completion:^(BOOL finished) {
        if(completionHandle)
            completionHandle();
    }];
    _isOpen=NO;
}
@end
