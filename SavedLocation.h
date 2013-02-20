//
//  SavedLocation.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/6/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SavedLocation : NSManagedObject

@property (nonatomic, strong) NSNumber * longitude;
@property (nonatomic, strong) NSNumber * latitude;

@end
