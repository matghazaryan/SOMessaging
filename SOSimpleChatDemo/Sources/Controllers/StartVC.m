//
//  StartVC.m
//  SOSimpleChatDemo
//
//  Created by Artur Mkrtchyan on 4/23/14.
//  Copyright (c) 2014 SocialOjbects Software. All rights reserved.
//

#import "StartVC.h"
#import "SOMessage.h"
#import "SOMessageCell.h"

@interface StartVC ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation StartVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadMessages];
}

- (void)loadMessages
{
    self.dataSource = [NSMutableArray new];
    for (int i = 0; i < 14; i++) {
        SOMessage *message = [[SOMessage alloc] init];
        message.fromMe = i%2;
        
        message.text = [NSString stringWithFormat:@"Hello, how are you? %d Hello, how are you? Hello, how are you?",i];
        
        [self.dataSource addObject:message];
    }
    
    SOMessage *msg = [SOMessage new];
    msg.media = UIImageJPEGRepresentation([UIImage imageNamed:@"lion.jpg"], 1);

    msg.type = SOMessageTypePhoto;
    msg.fromMe = YES;
    [self.dataSource addObject:msg];
}

#pragma mark - SOMessaging data source
- (NSMutableArray *)messages
{
    return self.dataSource;
}

- (NSTimeInterval)intervalForMessagesGrouping
{
    return 0;
}

- (void) configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index
{
    SOMessage *message = self.dataSource[index];
    
    cell.userImageView.layer.cornerRadius = self.userImageSize.width/2;
    cell.userImageView.autoresizingMask = message.fromMe ? UIViewAutoresizingFlexibleTopMargin : UIViewAutoresizingFlexibleBottomMargin;
    cell.userImage = [UIImage imageNamed:@"lion.jpg"];
    
    if (!message.fromMe) {
        if (message.type == SOMessageTypePhoto || message.type == SOMessageTypeVideo) {
            CGRect frame = cell.mediaImageView.frame;
            frame.origin.x += 3.0f;
            cell.mediaImageView.frame = frame;
        } else {
            CGRect frame = cell.textView.frame;
            frame.origin.x += 3.0f;
            cell.textView.frame = frame;
        }
    } else {
        if (message.type == SOMessageTypePhoto || message.type == SOMessageTypeVideo) {
            CGRect frame = cell.mediaImageView.frame;
            frame.origin.x -= 3.0f;
            cell.mediaImageView.frame = frame;
        } else {
            CGRect frame = cell.textView.frame;
            frame.origin.x -= 3.0f;
            cell.textView.frame = frame;
        }
    }
}

- (CGFloat)messageMaxWidth
{
    return 200;
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
