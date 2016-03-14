//
//  ButtonUtility.m
//  BabySNS
//
//  Created by  on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ButtonUtility.h"

@implementation ButtonUtility

+(UIView*)customButtonViewWithImageName:(NSString*)imageName
                   highlightedImageName:(NSString*)highlightedImageName
                                  title:(NSString*)title font:(UIFont *)font target:(id)target action:(SEL)sel{
	CGSize size = [title sizeWithFont:font];
	
	
	UIImage* image = [UIImage imageNamed:imageName];
	UIImage* highlightedImage = [UIImage imageNamed:highlightedImageName];
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.titleLabel.font = font;
	[button setFrame:CGRectMake(0, 0, MAX((size.width+15),40), MAX(image.size.height,size.height))];
	[button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateSelected];
	[button setBackgroundImage:[image stretchableImageWithLeftCapWidth:20 topCapHeight:15] forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateHighlighted];
	[button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.tag = BUTTON_TAG;
    UIView* buttonView = [[UIView alloc] initWithFrame:button.frame];
    [buttonView addSubview:button];
	return [buttonView autorelease];
}

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                 highlightedImageName:(NSString*)highlightedImageName
                                title:(NSString*)title
                                 font:(UIFont*)font
                            fontColor:(UIColor*)fontColor
                 fontHighlightedColor:(UIColor*)fontHighlightedColor
                               target:(id)target
                               action:(SEL)sel{
    CGSize stretchPoint = CGSizeMake(20, 15);
    CGSize size = [title sizeWithFont:font];
	
	UIImage* image = [UIImage imageNamed:imageName];
	UIImage* highlightedImage = [UIImage imageNamed:highlightedImageName];
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.titleLabel.font = font;
	[button setFrame:CGRectMake(0, 0, MAX((size.width+15),40), MAX(image.size.height,size.height))];
	[button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:stretchPoint.width topCapHeight:stretchPoint.height] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:stretchPoint.width topCapHeight:stretchPoint.height] forState:UIControlStateSelected];
	[button setBackgroundImage:[image stretchableImageWithLeftCapWidth:stretchPoint.width topCapHeight:stretchPoint.height] forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:fontColor forState:UIControlStateNormal];
    [button setTitleColor:fontHighlightedColor forState:UIControlStateHighlighted];
	[button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.tag = BUTTON_TAG;
	return button;
}

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                   highlightedImageName:(NSString*)highlightedImageName
                                  title:(NSString*)title
                                   font:(UIFont *)font
                                 target:(id)target
                                 action:(SEL)sel{
    return [[self class] customButtonWithImageName:imageName
                              highlightedImageName:highlightedImageName
                                      stretchPoint:CGSizeMake(20, 15)
                                             title:title
                                              font:font
                                            target:target
                                            action:sel];
}

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                 highlightedImageName:(NSString*)highlightedImageName
                         stretchPoint:(CGSize)stretchPoint
                                title:(NSString*)title
                                 font:(UIFont *)font
                               target:(id)target
                               action:(SEL)sel{
    CGSize size = [title sizeWithFont:font];
	
	UIImage* image = [UIImage imageNamed:imageName];
	UIImage* highlightedImage = [UIImage imageNamed:highlightedImageName];
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.titleLabel.font = font;
	[button setFrame:CGRectMake(0, 0, MAX((size.width+15),40), MAX(image.size.height,size.height))];
	[button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:stretchPoint.width topCapHeight:stretchPoint.height] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:stretchPoint.width topCapHeight:stretchPoint.height] forState:UIControlStateSelected];
	[button setBackgroundImage:[image stretchableImageWithLeftCapWidth:stretchPoint.width topCapHeight:stretchPoint.height] forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateHighlighted];
	[button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    button.tag = BUTTON_TAG;
	return button;
}

+(UIButton*)customButtonWithImageName:(NSString*)imageName
                   highlightedImageName:(NSString*)highlightedImageName
                                  target:(id)target action:(SEL)sel{
	UIImage* image = [UIImage imageNamed:imageName];
	UIImage* highlightedImage = [UIImage imageNamed:highlightedImageName];
    UIImage* selectedImage = [UIImage imageNamed:highlightedImageName];
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:selectedImage forState:UIControlStateSelected];
	[button setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	[button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
	return button;
}

@end
