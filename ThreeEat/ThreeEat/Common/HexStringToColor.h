//
//  HexStringToColor.h
//  HappyWork
//
//  Created by WuJiaqi on 15/4/16.
//  Copyright (c) 2015年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HexStringToColor : NSObject

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor:(UIColor*) color;
+ (UIColor *) colorWithHexString:(NSString *)color;

@end
