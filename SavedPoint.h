//
//  SavedPoint.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/6/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SavedField, SavedLocation;

@interface SavedPoint : NSManagedObject

@property (nonatomic, strong) NSDate * time;
@property (nonatomic, strong) NSSet *fields;
@property (nonatomic, strong) SavedLocation *location;
@end

@interface SavedPoint (CoreDataGeneratedAccessors)

- (void)addFieldsObject:(SavedField *)value;
- (void)removeFieldsObject:(SavedField *)value;
- (void)addFields:(NSSet *)values;
- (void)removeFields:(NSSet *)values;
- (id)proxyForJson;
@end
