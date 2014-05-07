//
//  SOImageBrowserView.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 5/7/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOImageBrowserView : UIView

@property (strong, nonatomic) UIImage *image;
@property (nonatomic) CGRect startFrame;

- (void)show;
- (void)hide;

@end
