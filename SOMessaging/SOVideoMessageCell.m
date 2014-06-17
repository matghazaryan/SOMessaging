//
//  SOVideoMessageCell.m
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

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
    
    self.dimmingView.frame = self.mediaImageView.bounds;
    
    CGRect playFrame = self.playButtonImageView.frame;
    playFrame.size   = CGSizeMake(20, 20);
    self.playButtonImageView.frame = playFrame;
    self.playButtonImageView.center = CGPointMake(self.mediaOverlayView.frame.size.width/2 + self.contentInsets.left - self.contentInsets.right, self.mediaOverlayView.frame.size.height/2);
}

@end
