//
//  ViewController.m
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 4/22/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "MainViewController.h"
#import "GamerStatus.h"
#import "GamerStatusViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.userSearchTextField.text = @"Retrominano";
    self.userSearchTextField.delegate = self;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *tits = [defaults objectForKey:@"gamerTags"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [[self userSearchTextField] resignFirstResponder];
    NSString *escapedSearchTest = [self.userSearchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"Escaped search string: %@", escapedSearchTest);
    [self fetchGamerStatus:escapedSearchTest];
    return YES;
}


- (void) fetchGamerStatus:(NSString *) gamerTag {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.xboxleaders.com"]];
    NSMutableURLRequest *request =  [client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"/api/profile/%@.json", gamerTag] parameters:nil];
    [request setHTTPShouldUsePipelining:YES];
    AFJSONRequestOperation *jsonOperation = [AFJSONRequestOperation
                                             JSONRequestOperationWithRequest:request
             success: ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                 GamerStatus *status = [[GamerStatus alloc] init];
                 if  ([JSON valueForKey:@"Data"]) {
                     [SVProgressHUD dismiss];
                     [status setValuesForKeysWithDictionary:[JSON valueForKey:@"Data"]];
                     self.searchedGamerStatus = status;
                     [self performSegueWithIdentifier:@"GamerDetailSegue" sender: self];
                     
                 }
                 else {
                     NSLog(@"ERROR: Gamertag not found");
                     [SVProgressHUD showErrorWithStatus:@"Gamertag not found"];
                 }
                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             }
            failure:
             ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                 NSLog(@"%@", [error description]);
                 [SVProgressHUD dismiss];
                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                 
             }];
    
    [jsonOperation start];
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"Searching for %@", self.userSearchTextField.text]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"GamerDetailSegue"]) {
        NSLog(@"my gamer: %@", self.searchedGamerStatus.OnlineStatus);
        [[segue destinationViewController] setGamerStatus:self.searchedGamerStatus];
    }
}

@end
