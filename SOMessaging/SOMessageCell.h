//
//  SOMessageCell.h
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
#import "SOMessage.h"

#define kBubbleTopMargin 0
#define kBubbleLeftMargin 7
#define kBubbleRightMargin 7
#define kBubbleBottomMargin 20

@class SOMessageCell;
@protocol SOMessageCellDelegate <NSObject>

@optional
- (void)messageCell:(SOMessageCell *)cell didTapMedia:(NSData *)media;

@end

@interface SOMessageCell : UITableViewCell

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) id<SOMessage> message;
@property (weak, nonatomic) UIImage *balloonImage;
@property (weak, nonatomic) UIImage *userImage;
@property (strong, nonatomic) UIFont *messageFont;

@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *timeLabel; //appears while dragging cell
@property (strong, nonatomic) UIImageView *mediaImageView;
@property (strong, nonatomic) UIView *mediaOverlayView; // For video only

@property (strong, nonatomic) UIImageView *balloonImageView;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

+ (CGFloat) messageTopMargin;
+ (void) setMessageTopMargin:(CGFloat)margin;
+ (CGFloat) messageBottomMargin;
+ (void) setMessageBottomMargin:(CGFloat)margin;
+ (CGFloat) messageLeftMargin;
+ (void) setMessageLeftMargin:(CGFloat)margin;
+ (CGFloat) messageRightMargin;
+ (void) setMessageRightMargin:(CGFloat)margin;

+ (CGFloat) maxContentOffsetX;
+ (void) setMaxContentOffsetX:(CGFloat)offsetX;

+ (void)setDefaultConfigs;

@property (nonatomic) CGFloat balloonMinWidth;
@property (nonatomic) CGFloat balloonMinHeight;
@property (nonatomic) CGFloat messageMaxWidth;

@property (nonatomic) UIEdgeInsets contentInsets;

@property (strong, nonatomic) UIView *containerView;

@property (weak, nonatomic) id<SOMessageCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth;
- (void)setMediaImageViewSize:(CGSize)size;
- (void)setUserImageViewSize:(CGSize)size;

- (void)adjustCell;

@end
