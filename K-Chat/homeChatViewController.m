//
//  homeChatViewController.m
//  K-Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 6/16/16.
//  Copyright © 2016 KosalPen. All rights reserved.
//

#import "homeChatViewController.h"
@interface homeChatViewController()<UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property(strong,nonatomic) Firebase *ref;
@property(strong,nonatomic) NSMutableArray *items;


@end

@implementation homeChatViewController
    NSInteger x;

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}


- (void)viewDidLoad{
    
//    UIEdgeInsets adjustForTabbarInsets = UIEdgeInsetsMake(CGRectGetHeight(self.navigationController.navigationBar.frame) + 20, 0, CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
//    self.collectionView.contentInset = adjustForTabbarInsets;
//    self.collectionView.scrollIndicatorInsets = adjustForTabbarInsets;
//    
    
    self.items = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
    UISearchBar *search = [[UISearchBar alloc] init];
    search.frame = CGRectMake(5 ,5, 300,45);
    search.delegate = self;
    search.showsBookmarkButton = NO;
    search.placeholder = @"Search for Oppai";
    search.barTintColor = [UIColor blackColor];
    self.navigationItem.titleView = search;
    
    
    self.ref = [[Firebase alloc] initWithUrl:@"https://rasy.firebaseio.com"];
    [[ self.ref childByAppendingPath:@"User"] observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        if ([self.user.lowercaseString isEqualToString:snapshot.key]){
       
        }else{
            [self.items addObject: snapshot.key];
            [self.collectionView reloadData];
            
        }
    }];
    //NSLog(@"the user login is%@",self.user);

}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    x = indexPath.item;
    [self performSegueWithIdentifier:@"chatSegue" sender:self];


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier]isEqualToString:@"chatSegue"]){
        
//        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
//        ChatViewController *destination  = [[navigationController viewControllers]lastObject];
        ChatViewController *destination = segue.destinationViewController;
        destination.user = self.user;
        destination.partner = self.items[x];
        [destination.navigationItem setHidesBackButton:false];
        
        

    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    homeChatViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    CALayer* layer = cell.layer;
    [layer setCornerRadius:40];
    [layer setBorderColor:[[UIColor grayColor] CGColor]];
    [layer setBorderWidth:4.0f];
    cell.myLabel.text = self.items[indexPath.item];
    return cell;
}









@end
