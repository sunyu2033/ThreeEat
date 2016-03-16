//
//  NSString+Extend.h
//  Gymax
//
//  Created by oucaizi on 15/6/2.
//  Copyright (c) 2015年 com.xiangmei123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extend)

/// 获取字符串动态高
-(CGSize)stringForWidth:(CGFloat)width font:(UIFont*)font;

/// 获取字符串动态宽
-(CGSize)stringForHeight:(CGFloat)height font:(UIFont*)font;



@end
