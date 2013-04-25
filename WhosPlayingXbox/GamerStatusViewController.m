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
	// Do any additional setup after loading the view.
   
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
    
    DYRateView *reputationView = [[DYRateView alloc] initWithFrame:CGRectMake(245, 40, 70,20)];
    reputationView.rate = [self.gamerStatus.Reputation floatValue] / 4.0f;
    reputationView.alignment = RateViewAlignmentLeft;
    [self.view addSubview:reputationView];
    
    
    // Get thumbnail image in background thread
    [self.avatarTileImageView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.avatarTileImageView.layer setBorderWidth:1.0];
    self.avatarTileImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.avatarTileImageView.layer.shadowOffset = CGSizeMake(2, 2);
    self.avatarTileImageView.layer.shadowOpacity = 1;
    self.avatarTileImageView.layer.shadowRadius = 1;
    self.avatarTileImageView.clipsToBounds = NO;
    [self.avatarTileImageView.layer setMasksToBounds:NO];

    




    
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
