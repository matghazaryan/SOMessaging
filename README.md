SOMessaging
===========

Messaging library for iOS 7.x by <b> arturdev </b>.

<a href="https://www.youtube.com/watch?v=AIUhyK_a22U">
<img src="https://raw.githubusercontent.com/arturdev/SOMessaging/master/Screenshots/screen1.jpg" width=240>
<img src="https://raw.githubusercontent.com/arturdev/SOMessaging/master/Screenshots/screen2.jpg" width=240>
<img src="https://raw.githubusercontent.com/arturdev/SOMessaging/master/Screenshots/screen3.jpg" width=240>
</a>
<br>Click on screenshots to see video demo
<br>

This is a simple library to easily create a messaging app with smooth animations.<br>
Things that can be customized:<br>
• EVERYTHING!!!

### Requirements
Xcode 5 <br>
iOS 7.0 + <br>
ARC 

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries installation in your projects.

#### Podfile

```ruby
pod "SOMessaging", "~> 1.0.0"
```

USAGE
=====

Copy <b>SOMessaging</b> folder to your project.

Link <b>MediaPlayer.framework</b>, <b>QuartzCore.framework</b>.

Make a class that conforms to protocol SOMessage and synthesize all properties of that protocol. (In this demo it will be <b>Message</b>).

Make subclass of <b>SOMessagingViewController</b>

Override the following required methods of the SOMessagingDataSource protocol:
```ObjC
- (NSMutableArray *)messages
{
    //return array of id<SOMessage> objects
}

- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index
{
    id<SOMessage> message = self.dataSource[index];
    
    // Customize balloon as you wish
    if (message.fromMe) {

    } else {

    }
}
```

Override the following (required) methods for the SOMessagingDelegate protocol:
```ObjC
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
```

You are done! 

CUSTOMIZATION
=============

In the Demo project you can find out how you can use and customize this library!

See ```SOMessagingDataSource``` protocol

```ObjC
/**
 * Array of SOMessage objects.
 */
- (NSMutableArray *)messages;

/**
 * Override this method if you want to customize cell that will be shown.
 * This method is called after cell default adjustment on every reuse time
 */
- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index;

@optional

/**
 * Default implementation of this method for calculating the height of the cell for a message at given index.
 */
- (CGFloat)heightForMessageForIndex:(NSInteger)index;

/**
 * Messages will be grouped by a return time interval (in seconds).
 * return 0 if you don't want grouping.
 */
- (NSTimeInterval)intervalForMessagesGrouping;

/**
 * Returns a resizable image for the sending balloon's background
 */
- (UIImage *)balloonImageForSending;

/**
 * Returns a resizable image for the receiving balloon's background
 */
- (UIImage *)balloonImageForReceiving;

/**
 * Maximum width of message
 */
- (CGFloat)messageMaxWidth;

/**
 * Minimum height of balloon
 */
- (CGFloat)balloonMinHeight;

/**
 * Minimum width of balloon
 */
- (CGFloat)balloonMinWidth;

/**
 * Font for the message
 */
- (UIFont *)messageFont;

/**
 * Size of the photo or video thumbnail imageView
 */
- (CGSize)mediaThumbnailSize;

/**
 * Size of the user's imageview
 */
- (CGSize)userImageSize;
```
