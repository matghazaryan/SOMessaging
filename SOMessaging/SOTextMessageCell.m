//
//  SOTextMessageCell.m
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

#import "SOTextMessageCell.h"
#import "NSString+Calculation.h"

@implementation SOTextMessageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier messageMaxWidth:messageMaxWidth];
    
    if (self) {
        [self initTextView];
    }
    
    return self;
}

-(void)initTextView
{
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.messageMaxWidth, 0)];
    
    self.textView.textColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor clearColor];
    [self.textView setTextContainerInset:UIEdgeInsetsZero];
    self.textView.textContainer.lineFragmentPadding = 0;
    
    [self.containerView addSubview:self.textView];
}

-(void)setMessage:(id<SOMessage>)message
{
    [super setMessage:message];
    self.textView.textColor = message.fromMe ? [UIColor whiteColor] : [UIColor blackColor];
}

-(void)adjustCell
{
    [super adjustCell];
    
    [self adjustForTextOnly];
}

- (void)adjustForTextOnly
{
    CGFloat userImageViewLeftMargin = 3;
    
    CGRect usedFrame = [self usedRectForWidth:self.messageMaxWidth];;
    if (self.balloonMinWidth) {
        CGFloat messageMinWidth = self.balloonMinWidth - [self.class messageLeftMargin] - [self.class messageRightMargin];
        if (usedFrame.size.width <  messageMinWidth) {
            usedFrame.size.width = messageMinWidth;
            
            usedFrame.size.height = [self usedRectForWidth:messageMinWidth].size.height;
        }
    }
    
    CGFloat messageMinHeight = self.balloonMinHeight - [self.class messageTopMargin] - [self.class messageBottomMargin];
    
    if (self.balloonMinHeight && usedFrame.size.height < messageMinHeight) {
        usedFrame.size.height = messageMinHeight;
    }
    
    self.textView.font = self.messageFont;
    
    CGRect frame = self.textView.frame;
    frame.size.width  = usedFrame.size.width;
    frame.size.height = usedFrame.size.height;
    frame.origin.y = [self.class messageTopMargin];
    
    CGRect balloonFrame = CGRectZero;
    balloonFrame.size.width = frame.size.width + [self.class messageLeftMargin] + [self.class messageRightMargin];
    balloonFrame.size.height = frame.size.height + [self.class messageTopMargin] + [self.class messageBottomMargin];
    balloonFrame.origin.y = 0;
    frame.origin.x = self.message.fromMe ? [self.class messageLeftMargin] : (balloonFrame.size.width - frame.size.width - [self.class messageLeftMargin]);
    if (!self.message.fromMe && self.userImage) {
        frame.origin.x += userImageViewLeftMargin + self.userImageViewSize.width;
        balloonFrame.origin.x = userImageViewLeftMargin + self.userImageViewSize.width;
    }
    
    frame.origin.x += self.contentInsets.left - self.contentInsets.right;
    
    self.textView.frame = frame;
    
    CGRect userRect = CGRectZero;
    userRect.size = self.userImageViewSize;
    
    if (!CGSizeEqualToSize(userRect.size, CGSizeZero) && self.userImage) {
        if (balloonFrame.size.height < userRect.size.height) {
            balloonFrame.size.height = userRect.size.height;
        }
    }
    
    self.balloonImageView.frame = balloonFrame;
    self.balloonImageView.backgroundColor = [UIColor clearColor];
    self.balloonImageView.image = self.balloonImage;
    
    self.textView.editable = NO;
    self.textView.scrollEnabled = NO;
    self.textView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
    
    
    
    if (self.userImageView.autoresizingMask & UIViewAutoresizingFlexibleTopMargin) {
        userRect.origin.y = balloonFrame.origin.y + balloonFrame.size.height - userRect.size.height;
    } else {
        userRect.origin.y = 0;
    }
    
    if (self.message.fromMe) {
        userRect.origin.x = balloonFrame.origin.x + userImageViewLeftMargin + balloonFrame.size.width;
    } else {
        userRect.origin.x = balloonFrame.origin.x - userImageViewLeftMargin - userRect.size.width;
    }
    self.userImageView.frame = userRect;
    self.userImageView.image = self.userImage;
    
    CGRect frm = CGRectZero;
    frm.origin.x = self.message.fromMe ? self.contentView.frame.size.width - balloonFrame.size.width - kBubbleRightMargin : kBubbleLeftMargin;
    frm.origin.y = kBubbleTopMargin;
    frm.size.height = balloonFrame.size.height;
    frm.size.width = balloonFrame.size.width;
    if (!CGSizeEqualToSize(userRect.size, CGSizeZero) && self.userImage) {
        self.userImageView.hidden = NO;
        frm.size.width += userImageViewLeftMargin + userRect.size.width;
        if (self.message.fromMe) {
            frm.origin.x -= userImageViewLeftMargin + userRect.size.width;
        }
    }
    
    
    if (frm.size.height < self.userImageViewSize.height) {
        CGFloat delta = self.userImageViewSize.height - frm.size.height;
        frm.size.height = self.userImageViewSize.height;
        
        for (UIView *sub in self.containerView.subviews) {
            CGRect fr = sub.frame;
            fr.origin.y += delta;
            sub.frame = fr;
        }
    }
    self.containerView.frame = frm;
    
    // Adjusing time label
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    self.timeLabel.frame = CGRectZero;
    self.timeLabel.text = [formatter stringFromDate:self.message.date];
    
    [self.timeLabel sizeToFit];
    CGRect timeLabel = self.timeLabel.frame;
    timeLabel.origin.x = self.contentView.frame.size.width + 5;
    self.timeLabel.frame = timeLabel;
    self.timeLabel.center = CGPointMake(self.timeLabel.center.x, self.containerView.center.y);
    
}

- (CGRect)usedRectForWidth:(CGFloat)width
{
    CGRect usedFrame = CGRectZero;
    
    if (self.message.attributes) {
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self.message.text attributes:self.message.attributes];
        self.textView.attributedText = attributedText;
        usedFrame.size = [self.message.text usedSizeForMaxWidth:width withAttributes:self.message.attributes];
    } else {
        self.textView.text = self.message.text;
        usedFrame.size = [self.message.text usedSizeForMaxWidth:width withFont:self.messageFont];
    }
    
    return usedFrame;
}

@end
