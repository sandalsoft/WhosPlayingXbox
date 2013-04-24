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

@property (weak, nonatomic) GamerStatus *gamerStatus;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIButton *SaveToFavesButton;

@end
