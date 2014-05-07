//
//  WithUserImagesVC.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 5/7/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "Type3VC.h"
#import "ContentManager.h"

@interface Type3VC ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIImage *myImage;
@property (strong, nonatomic) UIImage *partnerImage;

@end

@implementation Type3VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myImage      = [UIImage imageNamed:@"arturdev.jpg"];
    self.partnerImage = [UIImage imageNamed:@"jobs.jpg"];
    
//    [SOMessageCell setMessageTopMargin:5.5f];
//    [SOMessageCell setMessageBottomMargin:5.5f];
    
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
    return 0;
}

- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index
{
    SOMessage *message = self.dataSource[index];
    
    // Adjusting content for 3pt. (In this demo the width of bubble's tail is 3pt)
    if (!message.fromMe) {
        cell.contentInsets = UIEdgeInsetsMake(0, 4.0f, 0, 0); //Move content for 3 pt. to right
    } else {
        cell.contentInsets = UIEdgeInsetsMake(0, 0, 0, 4.0f); //Move content for 3 pt. to left
    }
    
    cell.textView.textColor = [UIColor blackColor];
    
    cell.userImageView.layer.cornerRadius = 3;
    
    // Fix user image position on top or bottom.
    cell.userImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    // Setting user images
    cell.userImage = message.fromMe ? self.myImage : self.partnerImage;
    
    // Disabling left drag functionality
    cell.panGesture.enabled = NO;
}

- (UIImage *)balloonImageForSending
{
    UIImage *img = [UIImage imageNamed:@"bubble_rect_sending.png"];
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 24, 11)];
}

- (UIImage *)balloonImageForReceiving
{
    UIImage *img = [UIImage imageNamed:@"bubble_rect_receiving.png"];
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(3, 11, 24, 3)];
}

- (CGFloat)messageMaxWidth
{
    return 140;
}

- (CGSize)userImageSize
{
    return CGSizeMake(60, 60);
}

- (CGFloat)balloonMinHeight
{
    return 60;
}

- (CGFloat)balloonMinWidth
{
    return 243;
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
    
    SOMessage *msg = [[SOMessage alloc] init];
    msg.text = message;
    msg.fromMe = YES;
    
    [self sendMessage:msg];
}

- (void)messageInputViewDidSelectMediaButton:(SOMessageInputView *)inputView
{
    
}

@end
