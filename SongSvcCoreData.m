//
//  SongSvcCoreData.m
//  I-transpose_TableView
//
//  Created by Phuong Nguyen on 2/17/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "SongSvcCoreData.h"

@implementation SongSvcCoreData

NSManagedObjectModel *model = nil;
NSPersistentStoreCoordinator *psc = nil;
NSManagedObjectContext *moc = nil;


- (id) init {
    if (self = [super init]) {
        [self initializeCoreData];
        return self;
    }
    
    return nil;
}



- (Song *) createManagedSong {
    
    Song *song = [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:moc];
    
    return song;
}

- (Song *) createSong: (Song *) song {
    Song *managedSong = [self createManagedSong];
    managedSong.title = song.title;
    managedSong.key = song.key;
    managedSong.lyric = song.lyric;
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"createSong ERROR: %@", [error localizedDescription]);
        
    }
    return managedSong;
}

- (NSArray *) retrieveAllSongs {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Song" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

- (Song *) updateSong: (Song *) song {
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"updateSong ERROR: %@", [error localizedDescription]);
        
    }
    return song;
}

- (Song *) deleteSong: (Song *) song {
    [moc deleteObject:song];
    return song;
}


- (void) initializeCoreData
{
    // initialize (load) the schema model
    NSURL *modelURL = [[NSBundle mainBundle]
                       URLForResource:@"Model" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc]
             initWithContentsOfURL:modelURL];
    // initialize the persistent store coordinator with the model
    NSURL *applicationDocumentsDirectory =
    [[[NSFileManager defaultManager]
      URLsForDirectory:NSDocumentDirectory
      inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [applicationDocumentsDirectory
                       URLByAppendingPathComponent:@"Song.sqlite"];
    NSError *error = nil;
    psc = [[NSPersistentStoreCoordinator alloc]
           initWithManagedObjectModel:model];
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                    URL:storeURL options:nil error:&error]) {
        // initialize the managed object context
        moc = [[NSManagedObjectContext alloc]
               initWithConcurrencyType:NSMainQueueConcurrencyType];
        [moc setPersistentStoreCoordinator:psc];
    } else {
        NSLog(@"initializeCoreData FAILED with error: %@", error);
    }
}



@end
