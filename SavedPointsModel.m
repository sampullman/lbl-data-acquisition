//
//  SavedPointsModel.m
//  lbl-iphone-app
//
//  Created by John Peterson on 11/14/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "SavedPointsModel.h"


@implementation SavedPointsModel

@synthesize points;
@synthesize path;

static SavedPointsModel *SharedSavedPointsModel;

+ (SavedPointsModel *) getInstance {
	if(!SharedSavedPointsModel) {
		SharedSavedPointsModel = [[SavedPointsModel alloc] init];
	}
	return SharedSavedPointsModel;
}

+ (NSString *) savedPointsPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"saved_points.plist"];
}

- (id) init {
	self.path = [SavedPointsModel savedPointsPath];
	self.points = [[NSMutableArray alloc] initWithContentsOfFile:self.path];
	if(!self.points) {
		self.points = [[NSMutableArray alloc] init];
	}
	return [super init];
}

- (int) count {
	return [self.points count];
}

- (NSString *) get:(int)ind {
	return [self.points objectAtIndex:ind];
}

- (void) save {
	[self.points writeToFile:self.path atomically:YES];
}

- (void) addPoint:(NSString *)point {
	[self.points addObject:point];
	[self save];
}

@end
