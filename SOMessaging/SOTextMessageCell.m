//
//  SOTextMessageCell.m
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

#import "SOTextMessageCell.h"

static const int userImageViewLeftMargin = 3;

@interface SOTextMessageCell()

@property NSDateFormatter* dateFormatter;

@end

@implementation SOTextMessageCell

+(CGSize)sizeForMessage:(id<SOMessage>)message constrainedToWidth:(CGFloat)width withFont:(UIFont*)font
{
    static UITextView* textMeasurementView;
    if(!textMeasurementView){
        textMeasurementView = [self newTextView];
        textMeasurementView.frame = CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX);
    }
    
    // Performance optimization
    if(textMeasurementView.font != font){
        textMeasurementView.font = font;
    }
    
    [self setTextForMessage:message onTextView:textMeasurementView];
    
    return [textMeasurementView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
}

+(void)setTextForMessage:(id<SOMessage>)message onTextView:(UITextView*)textView
{
    if (message.attributes) {
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:message.text attributes:message.attributes];
        textView.attributedText = attributedText;
    } else {
        textView.text = message.text;
    }
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier messageMaxWidth:messageMaxWidth];
    
    if (self) {
        [self initTextView];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"HH:mm"];
    }
    
    return self;
}

-(void)initTextView
{
    self.textView = [self.class newTextView];
    self.textView.frame = CGRectMake(0, 0, self.messageMaxWidth, 0);
    
    [self.containerView addSubview:self.textView];
}

+(UITextView*)newTextView
{
    UITextView* textView = [[UITextView alloc] init];

    textView.textColor = [UIColor whiteColor];
    textView.backgroundColor = [UIColor clearColor];
    [textView setTextContainerInset:UIEdgeInsetsZero];
    textView.textContainer.lineFragmentPadding = 0;
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber;
    
    return textView;
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
    // Performance optimization
    if(self.textView.font != self.messageFont){
        self.textView.font = self.messageFont;
    }
    
    [self.class setTextForMessage:self.message onTextView:self.textView];
    
    CGSize textSize = [self.class sizeForMessage:self.message constrainedToWidth:self.messageMaxWidth withFont:self.messageFont];
    if (self.balloonMinWidth) {
        CGFloat messageMinWidth = self.balloonMinWidth - [self.class messageLeftMargin] - [self.class messageRightMargin];
        if (textSize.width <  messageMinWidth) {
            textSize.width = messageMinWidth;
            
            textSize.height = [self.class sizeForMessage:self.message constrainedToWidth:messageMinWidth withFont:self.messageFont].height;
        }
    }
    
    CGFloat messageMinHeight = self.balloonMinHeight - [self.class messageTopMargin] - [self.class messageBottomMargin];
    
    if (self.balloonMinHeight && textSize.height < messageMinHeight) {
        textSize.height = messageMinHeight;
    }
    
    CGRect frame = self.textView.frame;
    frame.size = textSize;
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
    
    CGRect frm = CGRectMake(self.message.fromMe ? self.contentView.frame.size.width - balloonFrame.size.width - kBubbleRightMargin : kBubbleLeftMargin,
                            kBubbleTopMargin,
                            balloonFrame.size.width,
                            balloonFrame.size.height);
    if (!CGSizeEqualToSize(userRect.size, CGSizeZero) && self.userImage) {
        self.userImageView.hidden = NO;
        
        CGFloat offset = userImageViewLeftMargin + userRect.size.width;
        frm.size.width += offset;
        if (self.message.fromMe) {
            frm.origin.x -= offset;
        }
    }
    
    if (frm.size.height < self.userImageViewSize.height) {
        CGFloat delta = self.userImageViewSize.height - frm.size.height;
        
        frm.size.height = self.userImageViewSize.height;
        frm.origin.y += delta;
    }
    self.containerView.frame = frm;
    
    // Adjusing time label
    self.timeLabel.text = [self.dateFormatter stringFromDate:self.message.date];
    
    [self.timeLabel sizeToFit];
    CGRect timeLabel = self.timeLabel.frame;
    timeLabel.origin.x = self.contentView.frame.size.width + 5;
    self.timeLabel.frame = timeLabel;
    self.timeLabel.center = CGPointMake(self.timeLabel.center.x, self.containerView.center.y);
}

@end
