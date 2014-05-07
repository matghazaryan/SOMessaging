//
//  SOImageBrowserView.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 5/7/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "SOImageBrowserView.h"

#define kImageHeight 400.0f

@interface SOImageBrowserView()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *hideButton;

@end

@implementation SOImageBrowserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0;
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.hideButton.backgroundColor = [UIColor clearColor];
        [self.hideButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.hideButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.hideButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
        [self.hideButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        self.hideButton.frame = CGRectMake(20, 15, 50, 30);

        
        [self addSubview:self.backgroundView];
        [self addSubview:self.imageView];
        [self addSubview:self.hideButton];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self];
    
    self.imageView.image = self.image;
    self.imageView.frame = self.startFrame;
    
    CGRect frame = CGRectZero;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = kImageHeight;
    frame.origin.y = ([UIScreen mainScreen].bounds.size.height - kImageHeight)/2;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundView.alpha = 1;
        self.imageView.frame = frame;
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }];
}

- (void)hide
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = self.startFrame;
        self.imageView.alpha = 0;
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)doneButtonTapped:(id)sender
{
    [self hide];
}

- (void)dealloc
{
    
}

@end
