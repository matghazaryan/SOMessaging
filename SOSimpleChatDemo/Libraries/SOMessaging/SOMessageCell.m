//
//  SOMessageCell.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "SOMessageCell.h"
#import "NSString+Calculation.h"

@interface SOMessageCell() < UIGestureRecognizerDelegate>
{
    BOOL isHorizontalPan;
}
@property (nonatomic) CGSize mediaImageViewSize;
@property (nonatomic) CGSize userImageViewSize;

@end

@implementation SOMessageCell

static CGFloat messageTopMargin;
static CGFloat messageBottomMargin;
static CGFloat messageLeftMargin;
static CGFloat messageRightMargin;

static CGFloat maxContentOffsetX;
static CGFloat contentOffsetX;

+ (void)load
{
    messageTopMargin = 9;
    messageBottomMargin = 9;
    messageLeftMargin = 15;
    messageRightMargin = 15;
    
    contentOffsetX = 0;
    maxContentOffsetX = 50;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.messageMaxWidth = messageMaxWidth;
        
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        self.panGesture.delegate = self;
        [self addGestureRecognizer:self.panGesture];
        
        [self setInitialSizes];
    }
    
    return self;
}

- (void)setInitialSizes
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
    }
    
    self.userImageView = [[UIImageView alloc] init];
    self.userImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.messageMaxWidth, 0)];
    self.label = [[UILabel alloc] init];
    self.mediaImageView = [[UIImageView alloc] init];
    self.balloonImageView = [[UIImageView alloc] init];

    if (!CGSizeEqualToSize(self.userImageViewSize, CGSizeZero)) {
        CGRect frame = self.userImageView.frame;
        frame.size = self.userImageViewSize;
        self.userImageView.frame = frame;
    }

    self.userImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.userImageView.clipsToBounds = YES;
    self.userImageView.backgroundColor = [UIColor clearColor];
    self.userImageView.layer.cornerRadius = 5;
    
    if (!CGSizeEqualToSize(self.mediaImageViewSize, CGSizeZero)) {
        CGRect frame = self.mediaImageView.frame;
        frame.size = self.mediaImageViewSize;
        self.mediaImageView.frame = frame;
    }
    
    self.mediaImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mediaImageView.clipsToBounds = YES;
    self.mediaImageView.backgroundColor = [UIColor clearColor];
    self.mediaImageView.userInteractionEnabled = YES;
    self.mediaImageView.layer.cornerRadius = 10;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMediaTapped:)];
    [self.mediaImageView addGestureRecognizer:tap];
    
    self.textView.textColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor clearColor];
    [self.textView setTextContainerInset:UIEdgeInsetsZero];
    self.textView.textContainer.lineFragmentPadding = 0;
    
    [self hideSubViews];
    
    self.containerView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    
    [self.contentView addSubview:self.containerView];
    
    [self.containerView addSubview:self.balloonImageView];
    [self.containerView addSubview:self.textView];
    [self.containerView addSubview:self.label];
    [self.containerView addSubview:self.mediaImageView];
    [self.containerView addSubview:self.userImageView];
}

- (void)hideSubViews
{
    self.userImageView.hidden = YES;
    self.textView.hidden = YES;
    self.label.hidden = YES;
    self.mediaImageView.hidden = YES;
}

- (void)setMediaImageViewSize:(CGSize)size
{
    _mediaImageViewSize = size;
    CGRect frame = self.mediaImageView.frame;
    frame.size = size;
    self.mediaImageView.frame = frame;
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
    [self adjustCell];
}
#pragma mark -
- (void)handleMediaTapped:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCell:didTapMedia:)]) {
        [self.delegate messageCell:self didTapMedia:self.message.media];
    }

}

#pragma mark -
- (void)setMessage:(SOMessage *)message
{
    _message = message;
 
    [self setInitialSizes];
    [self adjustCell];
}

- (void)adjustCell
{
    [self hideSubViews];
    
    if (self.message.type == SOMessageTypeText) {
        self.textView.hidden = NO;
        [self adjustForTextOnly];
    } else if (self.message.type == SOMessageTypePhoto) {
        self.mediaImageView.hidden = NO;
        [self adjustForPhotoOnly];
    } else if (self.message.type == SOMessageTypeVideo) {
        self.mediaImageView.hidden = NO;
        
    } else if (self.message.type == SOMessageTypeOther) {
        
    }
    
    self.containerView.autoresizingMask = self.message.fromMe ? UIViewAutoresizingFlexibleLeftMargin : UIViewAutoresizingFlexibleRightMargin;

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

//---
- (void)adjustForTextOnly
{
    CGRect usedFrame = CGRectZero;
    if (self.message.attributes) {
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self.message.text attributes:self.message.attributes];
        self.textView.attributedText = attributedText;
        usedFrame.size = [self.message.text usedSizeForMaxWidth:self.messageMaxWidth withAttributes:self.message.attributes];
    } else {
        self.textView.text = self.message.text;
        usedFrame.size = [self.message.text usedSizeForMaxWidth:self.messageMaxWidth withFont:self.messageFont];
    }
    
    if (self.messageMinHeight && usedFrame.size.height < self.messageMinHeight) {
        usedFrame.size.height = self.messageMinHeight;
    }
    
    self.textView.font = self.messageFont;
    
    CGRect frame = self.textView.frame;
    frame.size.width  = usedFrame.size.width;
    frame.size.height = usedFrame.size.height;
    frame.origin.y = messageTopMargin;

    CGRect balloonFrame = self.balloonImageView.frame;
    balloonFrame.size.width = frame.size.width + messageLeftMargin + messageRightMargin;
    balloonFrame.size.height = frame.size.height + messageTopMargin + messageBottomMargin;
    
    frame.origin.x = self.message.fromMe ? messageLeftMargin : (balloonFrame.size.width - frame.size.width - messageLeftMargin);
    
    self.textView.frame = frame;
    
    self.balloonImageView.frame = balloonFrame;
    self.balloonImageView.backgroundColor = [UIColor clearColor];
    self.balloonImageView.image = self.balloonImage;
    
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    self.textView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
    
    
    CGRect userRect = self.userImageView.frame;
    
    if (self.userImageView.autoresizingMask & UIViewAutoresizingFlexibleTopMargin) {
        userRect.origin.y = balloonFrame.origin.y + balloonFrame.size.height - userRect.size.height;
    } else {
        userRect.origin.y = 0;
    }
    CGFloat userImageViewLeftMargin = 3;
    if (self.message.fromMe) {
        userRect.origin.x = balloonFrame.origin.x + userImageViewLeftMargin + balloonFrame.size.width;
    } else {
        userRect.origin.x = balloonFrame.origin.x - userImageViewLeftMargin - userRect.size.width;
    }
    self.userImageView.frame = userRect;
    self.userImageView.image = self.userImage;
    
    CGRect frm = self.containerView.frame;
    frm.origin.x = self.message.fromMe ? self.contentView.frame.size.width - balloonFrame.size.width - kBubbleRightMargin : kBubbleLeftMargin;
    frm.origin.y = kBubbleTopMargin;
    frm.size.width = balloonFrame.size.width;
    if (!CGSizeEqualToSize(userRect.size, CGSizeZero)) {
        self.userImageView.hidden = NO;
        frm.size.width += userImageViewLeftMargin + userRect.size.width;
        if (self.message.fromMe) {
            frm.origin.x -= userImageViewLeftMargin + userRect.size.width;
        } else {
            frm.origin.x += userImageViewLeftMargin + userRect.size.width;
        }
    }
    frm.size.height = balloonFrame.size.height;
    self.containerView.frame = frm;
}

//---
- (void)adjustForPhotoOnly
{
    UIImage *image = [[UIImage alloc] initWithData:self.message.media];
    self.mediaImageView.image = image;

    CGRect frame = self.mediaImageView.frame;    
    
    CGRect balloonFrame = self.balloonImageView.frame;
    balloonFrame.size.width = frame.size.width + messageLeftMargin + messageRightMargin;
    balloonFrame.size.height = frame.size.height + messageTopMargin + messageBottomMargin;
    
    frame.origin.x = self.message.fromMe ? messageLeftMargin : (balloonFrame.size.width - frame.size.width - messageLeftMargin);
    frame.origin.y = messageTopMargin;
    
    self.mediaImageView.frame = frame;
    
    self.balloonImageView.frame = balloonFrame;
    self.balloonImageView.backgroundColor = [UIColor clearColor];
    self.balloonImageView.image = self.balloonImage;
    
    
    CGRect frm = self.containerView.frame;
    frm.origin.x = self.message.fromMe ? self.contentView.frame.size.width - balloonFrame.size.width - kBubbleRightMargin : kBubbleLeftMargin;
    frm.origin.y = kBubbleTopMargin;
    frm.size.width = balloonFrame.size.width;
    frm.size.height = balloonFrame.size.height;
    self.containerView.frame = frm;
}

//---

//---

#pragma mark - GestureRecognizer delegates
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{

    CGPoint velocity = [self.panGesture velocityInView:self.panGesture.view];
    if (self.panGesture.state == UIGestureRecognizerStateBegan) {
        isHorizontalPan = fabs(velocity.x) > fabs(velocity.y);
    }
    
    return !isHorizontalPan;

//    return YES;
}

#pragma mark - 
- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint velocity = [pan velocityInView:pan.view];
    
    if (pan.state == UIGestureRecognizerStateBegan) {
            isHorizontalPan = fabs(velocity.x) > fabs(velocity.y);
    }
    
    if (isHorizontalPan) {
        NSArray *visibleCells = [self.tableView visibleCells];
        
        if (pan.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.2 animations:^{
                for (SOMessageCell *cell in visibleCells) {
                    
                    contentOffsetX = 0;
                    CGRect frame = cell.contentView.frame;
                    frame.origin.x = contentOffsetX;
                    cell.contentView.frame = frame;
                }
            }];
        } else {
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


@end
