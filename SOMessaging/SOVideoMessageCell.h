//
//  SOVideoMessageCell.h
//  SupportKit
//
//  Created by Mike on 2014-06-17.
//  Copyright (c) 2014 Radialpoint. All rights reserved.
//

#import "SOPhotoMessageCell.h"

@interface SOVideoMessageCell : SOPhotoMessageCell

@property (strong, nonatomic) UIView *mediaOverlayView; // For video only

@end
