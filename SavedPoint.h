//
//  SavedPoint.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/20/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SavedField, SavedLocation;

@interface SavedPoint : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSSet *fields;
@property (nonatomic, retain) SavedLocation *location;
@end

@interface SavedPoint (CoreDataGeneratedAccessors)

- (void)addFieldsObject:(SavedField *)value;
- (void)removeFieldsObject:(SavedField *)value;
- (void)addFields:(NSSet *)values;
- (void)removeFields:(NSSet *)values;
@end
