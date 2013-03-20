//
//  SavedLocation.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/20/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SavedLocation : NSManagedObject

@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;

@end
