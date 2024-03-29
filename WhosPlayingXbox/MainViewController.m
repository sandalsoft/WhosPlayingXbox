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

    // UITableView Delegates
    self.favoritesTableView.dataSource = self;
    self.favoritesTableView.delegate = self;
    [self.favoritesTableView setAllowsSelection:YES];
    // UITextFiled Delegate
    self.GamerTagSearchTextField.delegate = self;
    
    // Set default search value
    self.GamerTagSearchTextField.text = @"";

    // Get saved gamertags from defaults and load into property
    [self loadFavoritesFromNSUserDefaults];
    
    // Add to default
//    [tits addObject:@"theholyboot"];
//    [defaults setObject:tits forKey:FOLLOWED_GAMERS_ARRAY_KEY];
//    [defaults synchronize];

       [self.favoritesTableView reloadData];
    
    // Setup gesture recognizer to dismiss keyboard when touched outside of keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}



- (void)loadFavoritesFromNSUserDefaults {
    // Reload defaults into array property and refresh table data when view appears
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.followedGamers = [defaults objectForKey:FOLLOWED_GAMERS_ARRAY_KEY];
//    NSLog(@"saved gamertags: %@", self.followedGamers);
}

- (void) viewWillAppear:(BOOL)animated {
    [self loadFavoritesFromNSUserDefaults];
    [self.favoritesTableView reloadData];
    self.GamerTagSearchTextField.text = @"";
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
                                                 NSLog(@"ERROR: %@", [error description]);
                                                 [SVProgressHUD dismiss];
                                                 [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                             }];
    [jsonOperation start];
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"Searching for %@", gamerTag]];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"GamerDetailSegue"]) {
        [[segue destinationViewController] setGamerStatus:self.searchedGamerStatus];
    }

}

#pragma mark TableView delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [self fetchGamerStatus:[self.followedGamers objectAtIndex:[self.favoritesTableView indexPathForSelectedRow].row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.followedGamers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GamerCell"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GamerCell"];
    
    cell.textLabel.text = [self.followedGamers objectAtIndex:[indexPath row]];
//    NSLog(@"Cell is %@", [self.followedGamers objectAtIndex:indexPath.row]);
    return cell;
}



#pragma mark TextField delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [[self GamerTagSearchTextField] resignFirstResponder];
    NSString *escapedSearchTest = [self.GamerTagSearchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self fetchGamerStatus:escapedSearchTest];
    return YES;
}

-(void)dismissKeyboard {
    [self.GamerTagSearchTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
