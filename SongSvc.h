//
//  SongSvc.h
//  I-transpose_TableView
//
//  Created by Phuong Nguyen on 1/24/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@protocol SongSvc <NSObject>

- (Song *) createSong: (Song *) song;

- (NSArray *) retrieveAllSongs;

- (Song *) updateSong: (Song *) song;

- (Song *) deleteSong: (Song *) song;

@end