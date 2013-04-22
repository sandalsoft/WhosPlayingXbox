//
//  ViewController.m
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 4/22/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "ViewController.h"
#import "GamerStatus.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.userSearchTextField.delegate = self;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *tits = [defaults objectForKey:@"gamerTags"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) fetchGamerTagStatus:(NSString *)gamerTag {
    RKObjectMapping* gamerDataMapping = [RKObjectMapping mappingForClass:[GamerStatus class]];
    [gamerDataMapping addAttributeMappingsFromDictionary:@{@"Tier":@"Tier",
     @"IsValid":@"IsValid",
     @"IsCheater":@"IsCheater",
     @"IsOnline":@"IsOnline",
     @"OnlineStatus":@"OnlineStatus",
     @"XBLLaunchTeam":@"XBLLaunchTeam",
     @"NXELaunchTeam":@"NXELaunchTeam",
     @"KinectLaunchTeam":@"KinectLaunchTeam",
     @"AvatarTile":@"AvatarTile",
     @"AvatarSmall":@"AvatarSmall",
     @"AvatarLarge":@"AvatarLarge",
     @"AvatarBody":@"AvatarBody",
     @"AvatarTileSSL":@"AvatarTileSSL",
     @"AvatarSmallsSSL":@"AvatarSmallSSL",
     @"AvatarLargeSSL":@"AvatarLargeSSL",
     @"AvatarBodySSL":@"AvatarBodySSL",
     @"GamerTag":@"GamerTag",
     @"GamerScore":@"GamerScore",
     @"Reputation":@"Reputation",
     @"Name":@"Name",
     @"Motto":@"Motto",
     @"Location":@"Location",
     @"Bio":@"Bio"}];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:gamerDataMapping pathPattern:nil keyPath:@"Data" statusCodes:nil];
    NSURL *gamerStatusUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.xboxleaders.com/api/profile/%@.json", gamerTag]];
    NSURLRequest *request = [NSURLRequest requestWithURL:gamerStatusUrl];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        GamerStatus *status = [result firstObject];
        if ([status valueForKey:@"IsOnline"]) {
            NSLog(@"gamer status is: %@", status.OnlineStatus);
        }
        else {
            NSLog(@"ERROR RETRIEVING GAMERTAG");
        }
    } failure:nil];
    [operation start];
    
    
    
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"enteres: %@", self.userSearchTextField.text);
    [self fetchGamerTagStatus:self.userSearchTextField.text];
    [[self userSearchTextField] resignFirstResponder];
    
    
    return YES;
}

@end
