//
//  SOVideoMessageCell.m
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

#import "SOVideoMessageCell.h"

@implementation SOVideoMessageCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier messageMaxWidth:messageMaxWidth];
    
    if (self) {
        [self initMediaOverlayView];
    }
    
    return self;
}

-(void)initMediaOverlayView
{
    self.mediaOverlayView = [[UIView alloc] init];
    
    self.mediaOverlayView.backgroundColor = [UIColor clearColor];
    [self.mediaImageView addSubview:self.mediaOverlayView];
}

-(void)adjustCell
{
    [super adjustCell];
    
    [self adjustForVideoOnly];
}

- (void)adjustForVideoOnly
{
    CGRect frame = self.mediaOverlayView.frame;
    frame.origin = CGPointZero;
    frame.size   = self.mediaImageView.frame.size;
    self.mediaOverlayView.frame = frame;
    
    [self.mediaOverlayView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = self.mediaImageView.bounds;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.4f;
    [self.mediaOverlayView addSubview:bgView];
    
    UIImageView *playButtonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play_button.png"]];
    playButtonImageView.contentMode = UIViewContentModeScaleAspectFit;
    playButtonImageView.clipsToBounds = YES;
    playButtonImageView.backgroundColor = [UIColor clearColor];
    CGRect playFrame = playButtonImageView.frame;
    playFrame.size   = CGSizeMake(20, 20);
    playButtonImageView.frame = playFrame;
    playButtonImageView.center = CGPointMake(self.mediaOverlayView.frame.size.width/2 + self.contentInsets.left - self.contentInsets.right, self.mediaOverlayView.frame.size.height/2);
    [self.mediaOverlayView addSubview:playButtonImageView];
}

@end
