//
//  ViewController.h
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 4/22/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamerStatus.h"

@interface MainViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userSearchTextField;
@property (weak, nonatomic) IBOutlet UITableView *favoritesTableView;
@property (weak, nonatomic) GamerStatus *searchedGamerStatus;
@property (strong, nonatomic) NSMutableArray *followedGamers;

- (void) fetchGamerStatus:(NSString *) gamerTag;

@end
