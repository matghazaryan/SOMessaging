//
//  SOPhotoMessageCell.m
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

#import "SOPhotoMessageCell.h"

@implementation SOPhotoMessageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier messageMaxWidth:messageMaxWidth];
    
    if (self) {
        [self initMediaImageView];
    }
    
    return self;
}

-(void)initMediaImageView
{
    self.mediaImageView = [[UIImageView alloc] init];
    
    if (!CGSizeEqualToSize(self.mediaImageViewSize, CGSizeZero)) {
        CGRect frame = self.mediaImageView.frame;
        frame.size = self.mediaImageViewSize;
        self.mediaImageView.frame = frame;
    }
    
    self.mediaImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mediaImageView.clipsToBounds = YES;
    self.mediaImageView.backgroundColor = [UIColor clearColor];
    self.mediaImageView.userInteractionEnabled = YES;
    //    self.mediaImageView.layer.cornerRadius = 10;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMediaTapped:)];
    [self.mediaImageView addGestureRecognizer:tap];
    
    [self.containerView addSubview:self.mediaImageView];
}

-(void)layoutChatBalloon
{
    UIImage *image = self.message.thumbnail;
    if (!image) {
        image = [[UIImage alloc] initWithData:self.message.media];
    }
    self.mediaImageView.image = image;
    
    CGRect frame = CGRectZero;
    frame.size = self.mediaImageViewSize;
    
    if (!self.message.fromMe && self.userImage) {
        frame.origin.x += userImageViewLeftMargin + self.userImageViewSize.width;
    }
    
    self.mediaImageView.frame = frame;
    
    self.balloonImageView.frame = frame;
    self.balloonImageView.backgroundColor = [UIColor clearColor];
    self.balloonImageView.image = self.balloonImage;
}

-(void)adjustCell
{
    [super adjustCell];
    
    //Masking mediaImageView with balloon image
    CALayer *layer = self.balloonImageView.layer;
    layer.frame    = (CGRect){{0,0},self.balloonImageView.layer.frame.size};
    self.mediaImageView.layer.mask = layer;
    [self.mediaImageView setNeedsDisplay];
}

#pragma mark -
- (void)handleMediaTapped:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCell:didTapMedia:)]) {
        [self.delegate messageCell:self didTapMedia:self.message.media];
    }
}

@end
