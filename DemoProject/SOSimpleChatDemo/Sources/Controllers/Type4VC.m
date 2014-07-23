//
//  Type4VC.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 7/21/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "Type4VC.h"
#import "ContentManager.h"
#import "Message.h"

@interface Type4VC ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIImage *myImage;
@property (strong, nonatomic) UIImage *partnerImage;


@end

@implementation Type4VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myImage      = [UIImage imageNamed:@"arturdev.jpg"];
    self.partnerImage = [UIImage imageNamed:@"jobs.jpg"];
    
    
    [self loadMessages];
}

- (void)loadMessages
{
    self.dataSource = [[[ContentManager sharedManager] generateConversation] mutableCopy];
}

#pragma mark - SOMessaging data source
- (NSMutableArray *)messages
{
    return self.dataSource;
}

- (NSTimeInterval)intervalForMessagesGrouping
{
    // Return 0 for disableing grouping
    return 2 * 24 * 3600;
}

- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index
{
    Message *message = self.dataSource[index];
    
    // Adjusting content for 3pt. (In this demo the width of bubble's tail is 3pt)
    if (!message.fromMe) {
        cell.contentInsets = UIEdgeInsetsMake(0, 3.0f, 0, 0); //Move content for 3 pt. to right
        cell.textView.textColor = [UIColor blackColor];
    } else {
        cell.contentInsets = UIEdgeInsetsMake(0, 0, 0, 3.0f); //Move content for 3 pt. to left
        cell.textView.textColor = [UIColor whiteColor];
    }
    
    cell.userImageView.layer.cornerRadius = self.userImageSize.width/2;
    
    // Fix user image position on top or bottom.
    cell.userImageView.autoresizingMask = message.fromMe ? UIViewAutoresizingFlexibleTopMargin : UIViewAutoresizingFlexibleBottomMargin;
    
    // Setting user images
    cell.userImage = message.fromMe ? self.myImage : self.partnerImage;
    
    [self generateUsernameLabelForCell:cell];
}

- (void)generateUsernameLabelForCell:(SOMessageCell *)cell
{
    static NSInteger labelTag = 666;

    Message *message = (Message *)cell.message;
    UILabel *label = (UILabel *)[cell.containerView viewWithTag:labelTag];
    if (!label) {
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:8];
        label.textColor = [UIColor grayColor];
        label.tag = labelTag;
        [cell.containerView addSubview:label];
    }
    label.text = message.fromMe ? @"Me" : @"Steve Jobs";
    [label sizeToFit];

    CGRect frame = label.frame;
    
    CGFloat topMargin = 2.0f;
    if (message.fromMe) {
        frame.origin.x = cell.userImageView.frame.origin.x + cell.userImageView.frame.size.width/2 - frame.size.width/2;
        frame.origin.y = cell.containerView.frame.size.height + topMargin;

    } else {
        frame.origin.x = cell.userImageView.frame.origin.x + cell.userImageView.frame.size.width/2 - frame.size.width/2;
        frame.origin.y = cell.userImageView.frame.origin.y + cell.userImageView.frame.size.height + topMargin;
    }
    label.frame = frame;
}

- (CGFloat)messageMaxWidth
{
    return 140;
}

- (CGSize)userImageSize
{
    return CGSizeMake(40, 40);
}

- (CGFloat)messageMinHeight
{
    return 0;
}

#pragma mark - SOMessaging delegate

- (void)didSelectMedia:(NSData *)media inMessageCell:(SOMessageCell *)cell
{
    // Show selected media in fullscreen
    [super didSelectMedia:media inMessageCell:cell];
}

- (void)messageInputView:(SOMessageInputView *)inputView didSendMessage:(NSString *)message
{
    if (![[message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return;
    }
    
    Message *msg = [[Message alloc] init];
    msg.text = message;
    msg.fromMe = YES;
    
    [self sendMessage:msg];
}

- (void)messageInputViewDidSelectMediaButton:(SOMessageInputView *)inputView
{
    // Take a photo/video or choose from gallery
}

@end
