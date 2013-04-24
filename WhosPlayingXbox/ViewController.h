//
//  ViewController.h
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 4/22/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userSearchTextField;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;


- (void) fetchGamerStatus:(NSString *) gamerTag;

@end
