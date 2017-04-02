//
//  ChatViewController.m
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/17/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import "ChatViewController.h"

@implementation ChatViewController
-(void)viewDidLoad{
  //  [self.navigationController setNavigationBarHidden:NO animated:YES];

    [super viewDidLoad];
    self.ref = [[Firebase alloc] initWithUrl:@"https://rasy.firebaseio.com"];
    self.title = @"K-Chat";
    self.senderId = self.user.lowercaseString;
    self.senderDisplayName = self.user.lowercaseString;
    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    _messages = [[NSMutableArray alloc]init];
    [self setupBubbles];
   
    
}
- (IBAction)back:(id)sender {
    
    
     self.tabBarController.selectedViewController=[self.tabBarController.viewControllers objectAtIndex:1];
    [self performSegueWithIdentifier:@"rewindToChat" sender:nil];
    
    }
-(void) setupBubbles{
    JSQMessagesBubbleImageFactory *factory = [[JSQMessagesBubbleImageFactory alloc] init];
    self.outgoingBubbleImageView = [factory outgoingMessagesBubbleImageWithColor:UIColor.jsq_messageBubbleBlueColor];
    self.incomingBubbleImageView = [factory incomingMessagesBubbleImageWithColor:UIColor.jsq_messageBubbleLightGrayColor];
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    JSQMessage *msg = self.messages[indexPath.item];
    
    if ([msg.senderId isEqualToString: self.senderId]) {
        cell.textView.textColor = [UIColor blackColor];
    } else {
        cell.textView.textColor = [UIColor blackColor];
    }
    
    
    
    return cell;
}


-(id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


-(void)observeMessage{
    NSString *k= [[self.user stringByAppendingString:@"With"]stringByAppendingString:self.partner.lowercaseString];
    Firebase *initRef = [_ref childByAppendingPath:@"Chat"];
    Firebase *messageRef = [[initRef childByAppendingPath:k.lowercaseString] queryLimitedToLast:25];
    [messageRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSString*id =snapshot.value[@"senderID"];
        NSString*text = snapshot.value[@"senderText"];
        [self addMessage:id Text:text];
        
        [self.collectionView reloadData];
        [self finishReceivingMessage];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self observeMessage];
    [self finishReceivingMessage];
    
}
-(void)didPressSendButton:(UIButton *)button withMessageText:(NSString *)text senderId:(NSString *)senderId senderDisplayName:(NSString *)senderDisplayName date:(NSDate *)date{
    NSString *k = [[self.user stringByAppendingString:@"With"] stringByAppendingString:self.partner];
    NSString *l = [[self.partner stringByAppendingString:@"With"] stringByAppendingString:self.user];
    
    Firebase *msgRef = [[self.ref childByAppendingPath:@"Chat"] childByAppendingPath:k.lowercaseString];
    Firebase *msgRef2 = [[self.ref childByAppendingPath:@"Chat"] childByAppendingPath:l.lowercaseString];
    Firebase *itemRef = [msgRef childByAutoId];
    Firebase *itemRef2 = [msgRef2 childByAutoId];
    NSDictionary *msgItem = @{
                              @"senderID": self.user.lowercaseString,
                              @"senderText": text
    };
    
    [itemRef setValue:msgItem];
    [itemRef2 setValue:msgItem];
    NSLog(@"Success");
    
    [self finishSendingMessage];
}



-(id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath{
    JSQMessage* msg = _messages[indexPath.item];
    if([msg.senderId isEqualToString:self.senderId.lowercaseString]){
    
        return self.outgoingBubbleImageView;
        
    }
    else {
        
        return self.incomingBubbleImageView;
    }
}



-(void)textViewDidChange:(UITextView *)textView{
    [super textViewDidChange:textView];
}

- (void)addMessage :(NSString *)id Text:(NSString *)text{
    JSQMessage* msg = [JSQMessage messageWithSenderId:(NSString *)id
displayName:(NSString *)@""
text:(NSString *)text];
    [self.messages addObject:msg];
}
- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.messages[indexPath.item];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.messages.count;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([[segue identifier] isEqualToString:@"rewindToChat"]) {
       
            
            UITabBarController *tabController = (UITabBarController *)segue.destinationViewController;
            UINavigationController *navigationController = [tabController.viewControllers objectAtIndex:1];
            homeChatViewController *destination  = [[navigationController viewControllers]lastObject];
        

                destination.user = self.user;
    }

    
}
@end
