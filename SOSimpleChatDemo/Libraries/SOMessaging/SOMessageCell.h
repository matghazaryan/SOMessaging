//
//  SOMessageCell.h
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOMessage.h"

@interface SOMessageCell : UITableViewCell

@property (weak, nonatomic) SOMessage *message;
@property (weak, nonatomic) UIImage *balloonImage;
@property (strong, nonatomic) UIFont *messageFont;


@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *mediaImageView;

@property (strong, nonatomic) UIImageView *balloonImageView;

@property (nonatomic) CGFloat messageMaxWidth;

@property (strong, nonatomic) UIView *containerView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageMaxWidth:(CGFloat)messageMaxWidth;

- (void)adjustCell;

@end
