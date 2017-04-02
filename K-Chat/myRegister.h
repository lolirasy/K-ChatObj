//
//  myRegister.h
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/16/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface myRegister : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *conPassword;

@end
