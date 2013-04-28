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


- (void)setGamerDetails
{
    // Set UI to downloaded information
    [self.avatarTileImageView setImageWithURL:self.gamerStatus.AvatarTile];
    [self.avatarBodyImageView setImageWithURL:self.gamerStatus.AvatarBody];
    self.statusLabel.text =  [self.gamerStatus.OnlineStatus stringByDecodingHTMLEntities];
    self.gamertagLabel.text = self.gamerStatus.Gamertag;
    self.scoreLabel.text = [self.gamerStatus.GamerScore stringValue];
    //    self.reputationLabel.text = [self.gamerStatus.Reputation stringValue];

    
    // Name
    if (![self.gamerStatus.Name isEqualToString:@""])
        self.nameLabel.text = [self.gamerStatus.Name stringByDecodingHTMLEntities];
    else {
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:18];
        self.nameLabel.textColor = [UIColor lightGrayColor];
        self.nameLabel.text = @"Name not available";
    }
    
    // Location
    if (![self.gamerStatus.Location isEqualToString:@""])
        self.locationLabel.text = [self.gamerStatus.Location stringByDecodingHTMLEntities];
    else {
        self.locationLabel.textAlignment = NSTextAlignmentCenter;
        self.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:18];
        self.locationLabel.textColor = [UIColor lightGrayColor];
        self.locationLabel.text = @"Location not available";
    }
    
    // Motto
    if (![self.gamerStatus.Motto isEqualToString:@""])
        self.mottoLabel.text = [self.gamerStatus.Motto stringByDecodingHTMLEntities];
    else {
        self.mottoLabel.textAlignment = NSTextAlignmentCenter;
        self.mottoLabel.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:18];
        self.mottoLabel.textColor = [UIColor lightGrayColor];
        self.mottoLabel.text = @"Motto not available";
    }
    
    if (![self.gamerStatus.Bio isEqualToString:@""])
        self.bioTextView.text = [self.gamerStatus.Bio stringByDecodingHTMLEntities];
    else {
        self.bioTextView.textAlignment = NSTextAlignmentCenter;
        self.bioTextView.font = [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:18];
        self.bioTextView.textColor = [UIColor lightGrayColor];
        self.bioTextView.text = @"Bio not available";
    }
    
    if ([self.gamerStatus.Tier isEqualToString:@"gold"]) {
        self.tierImageView.image = [UIImage imageNamed:@"xboxGoldTier "];
    }
    
    // Create and set reputation star view
    // THIS DOES NOT WORK IN LANDSCAPE MODE
    DYRateView *reputationView = [[DYRateView alloc] initWithFrame:CGRectMake(245, 130, 70,20)];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setGamerDetails];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Updated %@", [formatter stringFromDate:now]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self setFavoriteUnfavoriteButtonImage];

}

- (void)setFavoriteUnfavoriteButtonImage
{
    // Set follow/UnFollow button title depending if gamer is alredy a favorite
    if ([self gamerTagExistsInFavorites:self.gamerStatus.Gamertag]) {
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"minus-64"] forState:UIControlStateNormal];
    }
    else {
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"plus-64"] forState:UIControlStateNormal];
    }
}

- (IBAction)followButtonPressed:(id)sender {
    
    if (![self gamerTagExistsInFavorites:self.gamerStatus.Gamertag]) {
        [self addGamerTagToFavorites:self.gamerStatus.Gamertag];
        WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:self.view title:@"Gamer Added!"];
        [notice show];
    }
    else {
        [self removeGamerTagFromFavorites:self.gamerStatus.Gamertag];
        WBSuccessNoticeView *notice = [WBSuccessNoticeView successNoticeInView:self.view title:@"Gamer Removed!"];
        [notice show];
    }
    
}


- (void)addGamerTagToFavorites:(NSString *)gamerTag {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *existingUsers = [[NSMutableArray alloc] init];
    [existingUsers addObjectsFromArray:[defaults objectForKey:FOLLOWED_GAMERS_ARRAY_KEY]];
    [existingUsers addObject:gamerTag];
    [defaults setObject:existingUsers forKey:FOLLOWED_GAMERS_ARRAY_KEY];
    [defaults synchronize];
//    NSLog(@"saving %@", self.gamerStatus.Gamertag);
    [self setFavoriteUnfavoriteButtonImage];
}

- (void)removeGamerTagFromFavorites:(NSString *)gamerTag {
    
    // Get defaults into existingUsers
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *existingGamers = [[NSMutableArray alloc] init];
    existingGamers = [[defaults objectForKey:FOLLOWED_GAMERS_ARRAY_KEY] mutableCopy];
    
    // Remove gamer gamerTag from existingGamers array
//    NSLog(@"remove at index %i", [existingGamers indexOfObject:gamerTag]);
    [existingGamers removeObjectAtIndex:[existingGamers indexOfObject:gamerTag]];
    [defaults setObject:existingGamers forKey:FOLLOWED_GAMERS_ARRAY_KEY];
    [defaults synchronize];
    
//    NSLog(@"removed %@", gamerTag);
    [self setFavoriteUnfavoriteButtonImage];

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
