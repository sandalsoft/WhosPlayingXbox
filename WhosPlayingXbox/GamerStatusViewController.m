//
//  GamerStatusViewController.m
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 4/22/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "GamerStatusViewController.h"
#import "DYRateView.h"

@interface GamerStatusViewController ()

@end

@implementation GamerStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    
    // Set UI to downloaded information
    [self.avatarTileImageView setImageWithURL:self.gamerStatus.AvatarTile];
    [self.avatarBodyImageView setImageWithURL:self.gamerStatus.AvatarBody];
    self.statusLabel.text =  [self.gamerStatus.OnlineStatus stringByDecodingHTMLEntities];
    self.gamertagLabel.text = self.gamerStatus.Gamertag;
    self.scoreLabel.text = [self.gamerStatus.GamerScore stringValue];
//    self.reputationLabel.text = [self.gamerStatus.Reputation stringValue];
    self.nameLabel.text = self.gamerStatus.Name;
    self.locationLabel.text = self.gamerStatus.Location;
    self.mottoLabel.text = self.gamerStatus.Motto;
    self.bioLabel.text = self.gamerStatus.Bio;
    
    if ([self.gamerStatus.Tier isEqualToString:@"gold"]) {
        self.tierImageView.image = [UIImage imageNamed:@"xboxGoldTier "];
    }
    
    // Create and set reputation star view
    // THIS DOES NOT WORK IN LANDSCAPE MODE
    DYRateView *reputationView = [[DYRateView alloc] initWithFrame:CGRectMake(245, 40, 70,20)];
    reputationView.rate = [self.gamerStatus.Reputation floatValue] / 4.0f;
    reputationView.alignment = RateViewAlignmentLeft;
    [self.view addSubview:reputationView];
    
    
    // add shadow and corner rounding to Avatar Tile at top
    [self.avatarTileImageView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.avatarTileImageView.layer setBorderWidth:1.0];
    self.avatarTileImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.avatarTileImageView.layer.shadowOffset = CGSizeMake(2, 2);
    self.avatarTileImageView.layer.shadowOpacity = 1;
    self.avatarTileImageView.layer.shadowRadius = 1;
    self.avatarTileImageView.clipsToBounds = NO;
    [self.avatarTileImageView.layer setMasksToBounds:NO];
    
    
    // Set follow/UnFollow button title depending if gamer is alredy a favorite
    if ([self gamerTagExistsInFavorites:self.gamerStatus.Gamertag]) {
        self.followButton.titleLabel.text = @"Unfollow";
        NSLog(@"button says UNfollow");
    }
    else {
        self.followButton.titleLabel.text = @"Follow";
        NSLog(@"button says Follow");
    }
}

- (IBAction)followButtonPressed:(id)sender {
    
    if (![self gamerTagExistsInFavorites:self.gamerStatus.Gamertag]) {
        [self addGamerTagToFavorites:self.gamerStatus.Gamertag];
    }
    else
        [self removeGamerTagFromFavorites:self.gamerStatus.Gamertag];
}


- (void)addGamerTagToFavorites:(NSString *)gamerTag {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *existingUsers = [[NSMutableArray alloc] init];
    [existingUsers addObjectsFromArray:[defaults objectForKey:FOLLOWED_GAMERS_ARRAY_KEY]];
    [existingUsers addObject:gamerTag];
    [defaults setObject:existingUsers forKey:FOLLOWED_GAMERS_ARRAY_KEY];
    [defaults synchronize];
    NSLog(@"saving %@", self.gamerStatus.Gamertag);
}

- (void)removeGamerTagFromFavorites:(NSString *)gamerTag {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *existingUsers = [[NSMutableArray alloc] init];
    [existingUsers removeObject:gamerTag];
    [defaults setObject:existingUsers forKey:FOLLOWED_GAMERS_ARRAY_KEY];
    [defaults synchronize];
    
    NSLog(@"removed %@", gamerTag);

}


- (BOOL)gamerTagExistsInFavorites:(NSString *) gamerTag {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *existingUsers = [[NSMutableArray alloc] init];
    [existingUsers addObjectsFromArray:[defaults objectForKey:FOLLOWED_GAMERS_ARRAY_KEY]];
    
    for (NSString *existingGamerTag in existingUsers) {
        if ([[gamerTag uppercaseString] isEqualToString:[existingGamerTag uppercaseString]]) {
            // Gamertag already exists
            return YES;
        }
    }
    return NO;
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^() { }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
