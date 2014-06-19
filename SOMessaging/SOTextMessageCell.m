//
//  SOTextMessageCell.m
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

#import "SOTextMessageCell.h"


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

-(void)layoutChatBalloon
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
    
    if (!CGSizeEqualToSize(self.userImageViewSize, CGSizeZero) && self.userImage) {
        if (balloonFrame.size.height < self.userImageViewSize.height) {
            balloonFrame.size.height = self.userImageViewSize.height;
        }
    }
    
    self.balloonImageView.frame = balloonFrame;
    self.balloonImageView.backgroundColor = [UIColor clearColor];
    self.balloonImageView.image = self.balloonImage;
}

@end
