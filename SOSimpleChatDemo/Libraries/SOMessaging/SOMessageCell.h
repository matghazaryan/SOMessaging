//
//  SOMessageCell.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

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
@property (weak, nonatomic) SOMessage *message;
@property (weak, nonatomic) UIImage *balloonImage;
@property (weak, nonatomic) UIImage *userImage;
@property (strong, nonatomic) UIFont *messageFont;

@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *mediaImageView;
@property (strong, nonatomic) UIView *mediaOverlayView; // For video only
@property (strong, nonatomic) UIView *otherView; //appears while dragging cell

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

@property (nonatomic) CGFloat messageMaxWidth;
@property (nonatomic) CGFloat messageMinHeight;

@property (nonatomic) UIEdgeInsets contentInsets;

@property (strong, nonatomic) UIView *containerView;

@property (weak, nonatomic) id<SOMessageCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth;
- (void)setMediaImageViewSize:(CGSize)size;
- (void)setUserImageViewSize:(CGSize)size;

- (void)adjustCell;

@end
