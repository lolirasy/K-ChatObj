//
//  myLogin.h
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/9/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeChatViewController.h"
#import "TabBarChatController.h"
#import <Firebase/Firebase.h>

@interface myLogin : UITableViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end
