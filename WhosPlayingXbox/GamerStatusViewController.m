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

}

- (void) viewWillAppear:(BOOL)animated {
    self.label1.text = @"hi dick";
    self.label2.text = self.gamerStatus.OnlineStatus;
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
