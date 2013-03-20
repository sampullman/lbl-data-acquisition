//
//  SavedField.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/20/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SavedField : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSNumber * autoInc;

@end
