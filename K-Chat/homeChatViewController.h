//
//  homeChatViewController.h
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/16/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import "homeChatViewCell.h"
#import "ChatViewController.h"

@interface homeChatViewController : UICollectionViewController
@property(strong,nonatomic) NSString *user;
@end
