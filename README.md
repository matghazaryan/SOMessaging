SOMessaging
===========

Messaging library for iOS 7.x by <b> arturdev </b>.

<img src="https://raw.githubusercontent.com/arturdev/SOMessaging/master/Screenshots/screen1.jpg" width=280>
<img src="https://raw.githubusercontent.com/arturdev/SOMessaging/master/Screenshots/screen2.jpg" width=280>
<img src="https://raw.githubusercontent.com/arturdev/SOMessaging/master/Screenshots/screen3.jpg" width=280>
<br>

This is a simple library to easily create a messaging app.
Fully customizable.

###Requierments
Xcode 5
iOS > 7.0
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
