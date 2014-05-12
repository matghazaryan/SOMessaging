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

###Requierments
Xcode 5 <br>
iOS 7.0 + <br>
ARC 

USAGE
=====
Copy <b>SOMessaging</b> folder to your project.

Link <b>MediaPlayer.framework</b>, <b>QuartzCore.framework</b>.

Make subclass of <b>SOMessagingViewController</b>

Override following required methods of SOMessagingDataSource protocol:
```ObjC
- (NSMutableArray *)messages
{
    //return array of SOMessage objects
}

- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index
{
    SOMessage *message = self.dataSource[index];
    
    // Customize balloon as you wish
    if (message.fromMe) {

    } else {

    }
}
```

Override following required methods of SOMessagingDelegate protocol:
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

    SOMessage *msg = [[SOMessage alloc] init];
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

In Demo project you can find how to use this library and how to customize.

See ```SOMessagingDataSource``` protocol

```ObjC
/**
 * Array of SOMessage objects.
 */
- (NSMutableArray *)messages;

/**
 * Override this method if you want to customize cell that will be shown.
 * This method calls after cell default adjustment on every reuse time
 */
- (void)configureMessageCell:(SOMessageCell *)cell forMessageAtIndex:(NSInteger)index;

@optional

/**
 * Default implementation of this method is calculating height of the cell for message at given index.
 */
- (CGFloat)heightForMessageForIndex:(NSInteger)index;

/**
 * Messages will be grouped by returned time interval (in seconds).
 * return 0 if you don't want grouping.
 */
- (NSTimeInterval)intervalForMessagesGrouping;

/**
 * Return resizable image for sending balloon background image
 */
- (UIImage *)balloonImageForSending;

/**
 * Return resizable image for receiving balloon background image
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
 * Font of message
 */
- (UIFont *)messageFont;

/**
 * Size of photo or video thumbnail imageView
 */
- (CGSize)mediaThumbnailSize;

/**
 * Size user's imageview
 */
- (CGSize)userImageSize;
```
