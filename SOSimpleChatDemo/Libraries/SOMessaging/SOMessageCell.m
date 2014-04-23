//
//  SOMessageCell.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "SOMessageCell.h"

@implementation SOMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.userImageView = [[UIImageView alloc] init];
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, messageMaxWidth, 0)];
        self.label = [[UILabel alloc] init];
        self.mediaImageView = [[UIImageView alloc] init];
        self.balloonImageView = [[UIImageView alloc] init];
        
        self.textView.textColor = [UIColor whiteColor];
        self.textView.backgroundColor = [UIColor clearColor];
        [self.textView setTextContainerInset:UIEdgeInsetsZero];
        self.textView.textContainer.lineFragmentPadding = 0;
        
        [self hideSubViews];
        
        self.containerView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        self.containerView.autoresizingMask = self.containerView.autoresizingMask;
        
        [self.contentView addSubview:self.containerView];
        
        [self.containerView addSubview:self.balloonImageView];
        [self.containerView addSubview:self.userImageView];
        [self.containerView addSubview:self.textView];
        [self.containerView addSubview:self.label];
        [self.containerView addSubview:self.mediaImageView];
    }
    
    return self;
}

- (void)hideSubViews
{
    self.userImageView.hidden = YES;
    self.textView.hidden = YES;
    self.label.hidden = YES;
    self.mediaImageView.hidden = YES;
}

- (void)setMessage:(SOMessage *)message
{
    _message = message;
    
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
        
    } else if (self.message.type == SOMessageTypeVideo) {
        self.mediaImageView.hidden = NO;
        
    }
    
/* Not implemented
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
    self.textView.text = self.message.text;
    self.textView.font = self.messageFont;
    
    CGRect usedFrame = [self.textView.layoutManager usedRectForTextContainer:self.textView.textContainer];

    CGFloat margin = 20;
    
    CGRect frame = self.textView.frame;
    frame.size.width  = usedFrame.size.width;
    frame.size.height = usedFrame.size.height;
    frame.origin.y = margin/4;

    CGRect balloonFrame = self.balloonImageView.frame;
    balloonFrame.size.width = frame.size.width + margin;
    balloonFrame.size.height = frame.size.height + margin/2;
    
    frame.origin.x = self.message.fromMe ? margin/4 : (balloonFrame.size.width - frame.size.width - margin/4);
    
    self.textView.frame = frame;
    
    self.balloonImageView.frame = balloonFrame;
    self.balloonImageView.backgroundColor = [UIColor clearColor];
    self.balloonImageView.image = self.balloonImage;    
}

@end
