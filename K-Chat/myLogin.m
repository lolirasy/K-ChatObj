//
//  myLogin.m
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/9/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import "myLogin.h"
@interface myLogin()
@property(nonatomic, strong) Firebase *ref;

@end

@implementation myLogin
int existUser=0;

-(void) viewDidLoad{
    self.passWord.delegate = self;
    self.userName.delegate = self;
    self.ref = [[Firebase alloc] initWithUrl:@"https://rasy.firebaseio.com"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    existUser = 0;
    [self checkFirebase];
}
-(void) checkFirebase{
   [[[self.ref childByAppendingPath:@"User"]childByAppendingPath:@"1" ] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSLog(@"D: %@",snapshot.value);
        
    } withCancelBlock:^(NSError *error) {
        NSLog(@":P");
    }];
}
- (void)checkUser{
    existUser = 0;

    [[self.ref childByAppendingPath:@"User"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
      
        if ([self.userName.text.lowercaseString isEqualToString:snapshot.key]){
            existUser = 1;
            
            NSLog(@"fk %d",existUser);
            return ;
            
        }
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ( textField == _userName){
        [_userName resignFirstResponder];
        [_passWord becomeFirstResponder];
    }else if(textField == _passWord){
      //  [self asyncLogin];
        [self OperationQueue];
        
    }
    return YES;
}

-(void) loginUser{
    if( existUser == 1){
        [[[ self.ref childByAppendingPath:@"User"] childByAppendingPath: self.userName.text.lowercaseString] observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            
            if([self.passWord.text isEqual:snapshot.value[@"Password"]]){
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                    [self performSegueWithIdentifier:@"loginChat" sender:self];
                    
                }];
                
            }else{
                [self showMessage:@"Your password is not Correct" withTitle:@"Oops! Sorry"];
                _passWord.text = @"";
                [_userName becomeFirstResponder];
            }
        }];
    }else{
        [self showMessage:@"Your Ussername is wrong" withTitle:@"Oops! Sorry"];
        
        _passWord.text = @"";
        [_userName becomeFirstResponder];
    }

}
-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}
- (IBAction)loginClicked:(id)sender {
    
    [self OperationQueue];
  //  [self checkUser];
    }
-(void)OperationQueue{
    NSOperationQueue *queue = [NSOperationQueue new];
    
    queue.maxConcurrentOperationCount = 1;
    
    [queue  addOperationWithBlock:^{
        [self checkUser];
    }];
    
    [queue  addOperationWithBlock:^{
      [NSThread sleepForTimeInterval:5.0];
        [self loginUser];
    }];
}

- (void)asynchronousTaskWithCompletion:(void (^)(BOOL))completion;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Some long running task you want on another thread
        [self checkUser];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(YES);
            }
        });
    });
}
-(void)dismissKeyboard {
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     if ([[segue identifier] isEqualToString:@"loginChat"]) {
        
         UITabBarController *tabController = (UITabBarController *)segue.destinationViewController;
         UINavigationController *navigationController = [tabController.viewControllers objectAtIndex:1];
         homeChatViewController *destination  = [[navigationController viewControllers]lastObject];
         [destination.navigationItem setHidesBackButton:TRUE];
         destination.user = self.userName.text;
     }
}

@end

