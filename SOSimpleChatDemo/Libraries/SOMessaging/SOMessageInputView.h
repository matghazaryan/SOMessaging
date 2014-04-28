//
//  SOMessageInputView.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/25/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOPlaceholderedTextView.h"

#define kAutoResizingMaskAll UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth

@interface SOMessageInputView : UIView

@property (weak, nonatomic) UITableView *tableView;

#pragma mark - Properties
@property (strong, nonatomic) UIImageView *textBgImageView;
@property (strong, nonatomic) SOPlaceholderedTextView *textView;
@property (strong, nonatomic) UIButton *sendButton;
@property (strong, nonatomic) UIButton *mediaButton;

/**
 * After setting above properties make sure that you called
 * -adjustInputView; method for apply changes
 */
@property (nonatomic) CGFloat textInitialHeight;
@property (nonatomic) CGFloat textMaxHeight;
@property (nonatomic) CGFloat textTopMargin;
@property (nonatomic) CGFloat textBottomMargin;
@property (nonatomic) CGFloat textleftMargin;
@property (nonatomic) CGFloat textRightMargin;
//--

#pragma mark - Methods
- (void)adjustInputView;
- (void)adjustPosition;

@end
