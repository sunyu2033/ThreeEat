//
//  ButtonUtility.h
//  BabySNS
//
//  Created by  on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//UIButton宏定义
#define BUTTON_TAG 1242310

@interface ButtonUtility : NSObject

/**
 根据ImageName和title创建自定义按钮
 @param imageName 图片名称
 @param highlightedImageName 高亮图片名称
 @param title 按钮标题
 @param font 字体
 @param target 回调对象
 @param sel 回调方法
 @returns 自定义按钮
 */
+(UIView*)customButtonViewWithImageName:(NSString*)imageName
                   highlightedImageName:(NSString*)highlightedImageName
                                  title:(NSString*)title 
                                   font:(UIFont *)font
                                 target:(id)target
                                 action:(SEL)sel;

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                 highlightedImageName:(NSString*)highlightedImageName
                                title:(NSString*)title
                                 font:(UIFont*)font
                            fontColor:(UIColor*)fontColor
                 fontHighlightedColor:(UIColor*)fontHighlightedColor
                               target:(id)target
                               action:(SEL)sel;

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                   highlightedImageName:(NSString*)highlightedImageName
                                  title:(NSString*)title
                                   font:(UIFont *)font
                                 target:(id)target
                                 action:(SEL)sel;

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                 highlightedImageName:(NSString*)highlightedImageName
                         stretchPoint:(CGSize)stretchPoint
                                title:(NSString*)title
                                 font:(UIFont *)font
                               target:(id)target
                               action:(SEL)sel;

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                 highlightedImageName:(NSString*)highlightedImageName
                               target:(id)target action:(SEL)sel;
@end
