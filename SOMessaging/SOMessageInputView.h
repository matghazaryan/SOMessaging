//
//  SOMessageInputView.h
//  SOMessaging
//
// Created by : arturdev
// Copyright (c) 2014 SocialObjects Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

#import <UIKit/UIKit.h>
#import "SOPlaceholderedTextView.h"
#import "SOMessagingDelegate.h"

#define kAutoResizingMaskAll UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth

@interface SOMessageInputView : UIView

@property (weak, nonatomic) UITableView *tableView;

#pragma mark - Properties
@property (strong, nonatomic) UIImageView *textBgImageView;
@property (strong, nonatomic) SOPlaceholderedTextView *textView;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) UIButton *mediaButton;

@property (strong, nonatomic) UIView *separatorView;

@property (nonatomic, readonly) BOOL viewIsDragging;

/**
 * After setting above properties make sure that you called
 * -adjustInputView method for apply changes
 */
@property (nonatomic) CGFloat textInitialHeight;
@property (nonatomic) CGFloat textMaxHeight;
@property (nonatomic) CGFloat textTopMargin;
@property (nonatomic) CGFloat textBottomMargin;
@property (nonatomic) CGFloat textleftMargin;
@property (nonatomic) CGFloat textRightMargin;
//--

@property (weak, nonatomic) id<SOMessagingDelegate> delegate;

#pragma mark - Methods
- (void)adjustInputView;
- (void)adjustPosition;

@end
