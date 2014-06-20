//
//  SOVideoMessageCell.m
//  SOMessaging
//
// Created by : mspensieri
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

#import "SOVideoMessageCell.h"

@interface SOVideoMessageCell()

@property UIView* dimmingView;
@property UIImageView *playButtonImageView;

@end

@implementation SOVideoMessageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier messageMaxWidth:messageMaxWidth];
    
    if (self) {
        [self initMediaOverlayView];
        [self initDimmingView];
        [self initPlayButton];
    }
    
    return self;
}

-(void)initMediaOverlayView
{
    self.mediaOverlayView = [[UIView alloc] init];
    
    self.mediaOverlayView.backgroundColor = [UIColor clearColor];
    [self.mediaImageView addSubview:self.mediaOverlayView];
}

-(void)initDimmingView
{
    self.dimmingView = [[UIView alloc] init];
    self.dimmingView.backgroundColor = [UIColor blackColor];
    self.dimmingView.alpha = 0.4f;
    [self.mediaOverlayView addSubview:self.dimmingView];
}

-(void)initPlayButton
{
    self.playButtonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play_button.png"]];
    self.playButtonImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.playButtonImageView.clipsToBounds = YES;
    self.playButtonImageView.backgroundColor = [UIColor clearColor];
    [self.mediaOverlayView addSubview:self.playButtonImageView];
}

-(void)layoutChatBalloon
{
    [super layoutChatBalloon];
    
    CGRect frame = self.mediaOverlayView.frame;
    frame.origin = CGPointZero;
    frame.size   = self.mediaImageView.frame.size;
    self.mediaOverlayView.frame = frame;
    
    self.dimmingView.frame = self.mediaImageView.bounds;
    
    CGRect playFrame = self.playButtonImageView.frame;
    playFrame.size   = CGSizeMake(20, 20);
    self.playButtonImageView.frame = playFrame;
    self.playButtonImageView.center = CGPointMake(self.mediaOverlayView.frame.size.width/2 + self.contentInsets.left - self.contentInsets.right, self.mediaOverlayView.frame.size.height/2);
}

@end
