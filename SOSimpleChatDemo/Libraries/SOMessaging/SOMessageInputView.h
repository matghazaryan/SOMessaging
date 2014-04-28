//
//  SOMessageInputView.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/25/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAutoResizingMaskAll UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth

#define kInitialInputViewHeight 44

@interface SOMessageInputView : UIView

#pragma mark - Properties
@property (strong, nonatomic) UIImageView *textBgImageView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *sendButton;

#pragma mark - Methods
- (void)adjustPosition;

@end
