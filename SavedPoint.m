//
//  SavedPoint.m
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/6/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import "SavedPoint.h"
#import "SavedField.h"
#import "SavedLocation.h"

@implementation SavedPoint

@dynamic time;
@dynamic fields;
@dynamic location;

-(id)proxyForJson {
    NSMutableArray *fields = [[NSMutableArray alloc] init];
    NSMutableArray *values = [[NSMutableArray alloc] init];
	for(SavedField *field in self.fields) {
		[fields addObject:field.name];
        [values addObject:field.value];
	}
    NSString *time;
    if(self.time) {
        time = [[NSString alloc] initWithFormat:@"%f",[self.time timeIntervalSince1970]];
    } else {
        time = @"none";
    }
    
    NSArray *loc;
    if (self.location) {
        NSString *lat = [[NSString alloc] initWithFormat:@"%g",
                         [self.location.latitude doubleValue]];
        NSString *lon = [[NSString alloc] initWithFormat:@"%g",
                         [self.location.longitude doubleValue]];
        loc = [[NSArray alloc] initWithObjects:lat, lon, nil];
        return [NSDictionary dictionaryWithObjectsAndKeys:
                fields, @"fields", values, @"values",
                time, @"time", loc, @"loc", @"phone", @"loc_type", nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                fields, @"fields", values, @"values",
                time, @"time", @"none", @"loc", @"none", @"loc_type", nil];
    }
}

@end
