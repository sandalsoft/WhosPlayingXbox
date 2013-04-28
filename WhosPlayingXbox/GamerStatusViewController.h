//
//  GamerStatusViewController.h
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 4/22/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "GamerStatus.h"


@interface GamerStatusViewController : UIViewController

@property (strong, nonatomic) GamerStatus *gamerStatus;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarTileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tierImageView;

@property (weak, nonatomic) IBOutlet UILabel *gamertagLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarBodyImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *mottoLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;



- (BOOL)gamerTagExistsInFavorites:(NSString *) gamerTag;
- (void)addGamerTagToFavorites:(NSString *)gamerTag;
- (void)removeGamerTagFromFavorites:(NSString *)gamerTag;

@end
