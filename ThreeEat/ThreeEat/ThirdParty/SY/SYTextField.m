//
//  SYTextField.m
//  快乐面试会
//
//  Created by WuJiaqi on 16/2/21.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "SYTextField.h"

@implementation SYTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self buildTextField:frame];
    }
    return self;
}

- (void)buildTextField:(CGRect)frame {

    self.frame = frame;
    self.returnKeyType = UIReturnKeySend;
    self.placeholder=@"请输入...";
    self.layer.cornerRadius = 5.0;
    self.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}

//-(void)drawRect:(CGRect)rect
//{
//    UIImage *bg = [UIImage imageNamed:@"wuduihao"];
//    bg = [bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.5];
//    [bg drawInRect:[self bounds]];
//}

@end
