//
//  GamerStatusViewController.m
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 4/22/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "GamerStatusViewController.h"

@interface GamerStatusViewController ()

@end

@implementation GamerStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    self.gamertagLabel.text = self.gamerStatus.Gamertag;
    self.scoreLabel.text = [self.gamerStatus.GamerScore stringValue];
    self.reputationLabel.text = [self.gamerStatus.Reputation stringValue];
    self.nameLabel.text = self.gamerStatus.Name;
    [self.avatarTileImageView setImageWithURL:self.gamerStatus.AvatarTile];
    [self.avatarBodyImageView setImageWithURL:self.gamerStatus.AvatarBody];
    self.locationLabel.text = self.gamerStatus.Location;
    self.mottoLabel.text = self.gamerStatus.Motto;
    self.bioLabel.text = self.gamerStatus.Bio;
    
    if ([self.gamerStatus.Tier isEqualToString:@"gold"]) {
        self.tierImageView.image = [UIImage imageNamed:@"xboxGoldTier "];
    }
    
    
    NSLog(@"in VCdetail status: %@", self.gamerStatus.OnlineStatus);



    
    NSLog(@"in VCdetail status: %@", self.gamerStatus.OnlineStatus);

    
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SaveGamerButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^() {
           }];
    
    
}

@end
