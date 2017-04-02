//
//  ChatViewController.h
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/17/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSQMessagesViewController/JSQMessages.h>
#import <Firebase/Firebase.h>
#import "homeChatViewController.h"


@interface ChatViewController : JSQMessagesViewController
@property(strong,nonatomic) NSString *user,*partner;
@property(strong,nonatomic) NSMutableArray* messages;
@property(strong,nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageView,*incomingBubbleImageView;
@property(strong,nonatomic) Firebase *ref;
@end
