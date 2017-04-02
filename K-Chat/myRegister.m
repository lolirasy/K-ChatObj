//
//  myRegister.m
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/16/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import "myRegister.h"

@interface myRegister()
@property Firebase *ref;

@end

@implementation myRegister


- (IBAction)registerClicked:(id)sender {
    if ([self.passWord.text isEqualToString: self.conPassword.text]){
    NSDictionary *info = @{
                           @"Password" : self.passWord.text
                           
                           };
    Firebase* userRef = [[self.ref childByAppendingPath:@"User"] childByAppendingPath:self.userName.text.lowercaseString];
    [userRef setValue:info ];
    self.conPassword.text = @"";
    self.passWord.text = @"";
    self.userName.text = @"";
        
    }
    else NSLog(@"XD");
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.ref = [[Firebase alloc] initWithUrl:@"https://rasy.firebaseio.com"];
    
}

- (void)didReceiveMemoryWarning{
    
}

@end
