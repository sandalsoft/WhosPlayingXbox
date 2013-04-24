//
//  UserStatus.m
//  WhosPlayingXbox
//
//  Created by Eric Nelson on 3/25/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "GamerStatus.h"

@implementation GamerStatus



- (void)setAvatarBody:(NSString *)stringInput  {
    _AvatarTile = [NSURL URLWithString:stringInput];
}

- (void)setAvatarBodySSL:(NSString *)stringInput  {
    _AvatarBodySSL = [NSURL URLWithString:stringInput];
}

- (void)setAvatarLarge:(NSString *)stringInput  {
    _AvatarLarge = [NSURL URLWithString:stringInput];
}

- (void)setAvatarLargeSSL:(NSString *)stringInput  {
    _AvatarLargeSSL = [NSURL URLWithString:stringInput];
}

- (void)setAvatarSmall:(NSString *)stringInput  {
    _AvatarSmall = [NSURL URLWithString:stringInput];
}

- (void)setAvatarSmallSSL:(NSString *)stringInput  {
    _AvatarSmallSSL = [NSURL URLWithString:stringInput];
}

- (void)setAvatarTile:(NSString *)stringInput  {
    _AvatarTile = [NSURL URLWithString:stringInput];
}

- (void)setAvatarTileSSL:(NSString *)stringInput  {
    _AvatarTileSSL = [NSURL URLWithString:stringInput];
}


@end
