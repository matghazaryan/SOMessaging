//
//  SOPictureMessageCell.m
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

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

-(void)adjustCell
{
    [super adjustCell];
    
    [self adjustForPhotoOnly];
}

- (void)adjustForPhotoOnly
{
    CGFloat userImageViewLeftMargin = 3;
    
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
    
    CGRect userRect = self.userImageView.frame;
    
    if (self.userImageView.autoresizingMask & UIViewAutoresizingFlexibleTopMargin) {
        userRect.origin.y = frame.origin.y + frame.size.height - userRect.size.height;
    } else {
        userRect.origin.y = 0;
    }
    
    if (self.message.fromMe) {
        userRect.origin.x = frame.origin.x + userImageViewLeftMargin + frame.size.width;
    } else {
        userRect.origin.x = frame.origin.x - userImageViewLeftMargin - userRect.size.width;
    }
    self.userImageView.frame = userRect;
    self.userImageView.image = self.userImage;
    
    CGRect frm = self.containerView.frame;
    frm.origin.x = self.message.fromMe ? self.contentView.frame.size.width - frame.size.width - kBubbleRightMargin : kBubbleLeftMargin;
    frm.origin.y = kBubbleTopMargin;
    frm.size.width = frame.size.width;
    if (!CGSizeEqualToSize(userRect.size, CGSizeZero) && self.userImage) {
        self.userImageView.hidden = NO;
        frm.size.width += userImageViewLeftMargin + userRect.size.width;
        if (self.message.fromMe) {
            frm.origin.x -= userImageViewLeftMargin + userRect.size.width;
        }
    }
    
    frm.size.height = frame.size.height;
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
    
    //Masking mediaImageView with balloon image
    CALayer *layer = self.balloonImageView.layer;
    layer.frame    = (CGRect){{0,0},self.balloonImageView.layer.frame.size};
    self.mediaImageView.layer.mask = layer;
    [self.mediaImageView setNeedsDisplay];
    
    
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

- (void)setMediaImageViewSize:(CGSize)size
{
    [super setMediaImageViewSize:size];
    CGRect frame = self.mediaImageView.frame;
    frame.size = size;
    self.mediaImageView.frame = frame;
}

#pragma mark -
- (void)handleMediaTapped:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCell:didTapMedia:)]) {
        [self.delegate messageCell:self didTapMedia:self.message.media];
    }
}

@end
