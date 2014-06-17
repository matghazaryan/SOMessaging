//
//  SOMessageCell.m
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

#import "SOMessageCell.h"

@interface SOMessageCell() < UIGestureRecognizerDelegate>
{
    BOOL isHorizontalPan;
}

@end

@implementation SOMessageCell

static CGFloat messageTopMargin = 9;
static CGFloat messageBottomMargin = 9;
static CGFloat messageLeftMargin = 15;
static CGFloat messageRightMargin = 15;

static CGFloat maxContentOffsetX = 50;
static CGFloat contentOffsetX = 0;

static CGFloat initialTimeLabelPosX;
static BOOL cellIsDragging;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.messageMaxWidth = messageMaxWidth;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        self.panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
        
        [self initContainerView];
        [self initUserImageView];
        [self initBalloon];
        [self setInitialSizes];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOrientationWillChandeNote:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    }
    
    return self;
}

-(void)initContainerView
{
    self.containerView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [self.contentView addSubview:self.containerView];
}

-(void)initUserImageView
{
    self.userImageView = [[UIImageView alloc] init];
    self.userImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    if (!CGSizeEqualToSize(self.userImageViewSize, CGSizeZero)) {
        CGRect frame = self.userImageView.frame;
        frame.size = self.userImageViewSize;
        self.userImageView.frame = frame;
    }
    self.userImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.userImageView.clipsToBounds = YES;
    self.userImageView.backgroundColor = [UIColor clearColor];
    self.userImageView.layer.cornerRadius = 5;
    
    [self.containerView addSubview:self.userImageView];
}

-(void)initBalloon
{
    self.balloonImageView = [[UIImageView alloc] init];
    
    [self.containerView addSubview:self.balloonImageView];
}

- (void)setInitialSizes
{
    if (self.timeLabel) {
        [self.timeLabel removeFromSuperview];
    }
    
    self.timeLabel = [[UILabel alloc] init];
    
    [self hideSubViews];
    
    [self.contentView addSubview:self.timeLabel];
    
    self.contentView.clipsToBounds = NO;
    self.clipsToBounds = NO;
    
    self.timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
}

- (void)hideSubViews
{
    self.userImageView.hidden = YES;
}

- (void)setMediaImageViewSize:(CGSize)size
{
    _mediaImageViewSize = size;
}

- (void)setUserImageViewSize:(CGSize)size
{
    _userImageViewSize = size;
    CGRect frame = self.userImageView.frame;
    frame.size = size;
    self.userImageView.frame = frame;
}

- (void)setUserImage:(UIImage *)userImage
{
    _userImage = userImage;
    if (!userImage) {
        self.userImageViewSize = CGSizeZero;
    }
    [self adjustCell];
}

#pragma mark -
- (void)setMessage:(id<SOMessage>)message
{
    _message = message;

    [self setInitialSizes];
//    [self adjustCell];
}

- (void)adjustCell
{
    [self hideSubViews];
    
    self.containerView.autoresizingMask = self.message.fromMe ? UIViewAutoresizingFlexibleLeftMargin : UIViewAutoresizingFlexibleRightMargin;
    initialTimeLabelPosX = self.timeLabel.frame.origin.x;
/* 
--  Not implemented ---
    else if (self.message.type & (SOMessageTypePhoto | SOMessageTypeText)) {
        self.textView.hidden = NO;
        self.mediaImageView.hidden = NO;
    } else if (self.message.type & (SOMessageTypeVideo | SOMessageTypeText)) {
        self.textView.hidden = NO;
        self.mediaImageView.hidden = NO;
    }
*/
}

#pragma mark - GestureRecognizer delegates
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    CGPoint velocity = [self.panGesture velocityInView:self.panGesture.view];
    if (self.panGesture.state == UIGestureRecognizerStateBegan) {
        isHorizontalPan = fabs(velocity.x) > fabs(velocity.y);
    }
    
    return !isHorizontalPan;
}

#pragma mark - 
- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint velocity = [pan velocityInView:pan.view];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        isHorizontalPan = fabs(velocity.x) > fabs(velocity.y);
        
        if (!cellIsDragging) {
            initialTimeLabelPosX = self.timeLabel.frame.origin.x;
        }
    }
    
    if (isHorizontalPan) {
        NSArray *visibleCells = [self.tableView visibleCells];
        
        if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {
            cellIsDragging = NO;
            [UIView animateWithDuration:0.25 animations:^{
                [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
                for (SOMessageCell *cell in visibleCells) {
                    
                    contentOffsetX = 0;
                    CGRect frame = cell.contentView.frame;
                    frame.origin.x = contentOffsetX;
                    cell.contentView.frame = frame;
                    
                    if (!cell.message.fromMe) {
                        CGRect timeframe = cell.timeLabel.frame;
                        timeframe.origin.x = initialTimeLabelPosX;
                        cell.timeLabel.frame = timeframe;
                    }
                }
            }];
        } else {
            cellIsDragging = YES;
            
            CGPoint translation = [pan translationInView:pan.view];
            CGFloat delta = translation.x * (1 - fabs(contentOffsetX / maxContentOffsetX));
            contentOffsetX += delta;
            if (contentOffsetX > 0) {
                contentOffsetX = 0;
            }
            if (fabs(contentOffsetX) > fabs(maxContentOffsetX)) {
                contentOffsetX = -fabs(maxContentOffsetX);
            }
            for (SOMessageCell *cell in visibleCells) {
                if (cell.message.fromMe) {
                    CGRect frame = cell.contentView.frame;
                    frame.origin.x = contentOffsetX;
                    cell.contentView.frame = frame;
                } else {
                    CGRect frame = cell.timeLabel.frame;
                    frame.origin.x = initialTimeLabelPosX - fabs(contentOffsetX);
                    cell.timeLabel.frame = frame;
                }
            }
        }
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = contentOffsetX;
    self.contentView.frame = frame;
}

- (void)handleOrientationWillChandeNote:(NSNotification *)note
{
    self.panGesture.enabled = NO;
    self.panGesture.enabled = YES;
}

#pragma mark - Getters and Setters
+ (CGFloat) messageTopMargin
{
    return messageTopMargin;
}

+ (void) setMessageTopMargin:(CGFloat)margin
{
    messageTopMargin = margin;
}

+ (CGFloat) messageBottomMargin;
{
    return messageBottomMargin;
}

+ (void) setMessageBottomMargin:(CGFloat)margin
{
    messageBottomMargin = margin;
}

+ (CGFloat) messageLeftMargin
{
    return messageLeftMargin;
}

+ (void) setMessageLeftMargin:(CGFloat)margin
{
    messageLeftMargin = margin;
}

+ (CGFloat) messageRightMargin
{
    return messageRightMargin;
}

+ (void) setMessageRightMargin:(CGFloat)margin
{
    messageRightMargin = margin;
}

+ (CGFloat)maxContentOffsetX
{
    return maxContentOffsetX;
}

+ (void)setMaxContentOffsetX:(CGFloat)offsetX
{
    maxContentOffsetX = offsetX;
}

#pragma mark -
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
