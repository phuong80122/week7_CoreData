//
//  Song.h
//  I-transpose_TableView
//
//  Created by Phuong Nguyen on 2/17/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Song : NSManagedObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *lyric;

@end
