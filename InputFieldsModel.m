//
//  InputFieldsModel.m
//  lbl-iphone-app
//
//  Created by John Peterson on 11/19/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "InputFieldsModel.h"


@implementation InputFieldsModel

@synthesize fieldNames;
@synthesize path;

static InputFieldsModel *SharedInputFieldsModel;

+ (InputFieldsModel *) getInstance {
	if(!SharedInputFieldsModel) {
		SharedInputFieldsModel = [[InputFieldsModel alloc] init];
	}
	return SharedInputFieldsModel;
}

- (id) init {
	self.path = [InputFieldsModel savedFieldsPath];
	self.fieldNames = [[NSMutableArray alloc] initWithContentsOfFile:self.path];
	if(!self.fieldNames) {
		self.fieldNames = [[NSMutableArray alloc] init];
	}
	return [super init];
}

+ (NSString *) removeNormalPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ex.png"];
}

+ (NSString *) savedFieldsPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"saved_fields.plist"];
}

- (int) count {
	return [self.fieldNames count];
}

- (NSString *) get:(int)ind {
	return [self.fieldNames objectAtIndex:ind];
}

- (void) removeField:(int)ind {
	[self.fieldNames removeObjectAtIndex:ind];
	[self save];
}

- (void) save {
	[self.fieldNames writeToFile:self.path atomically:YES];
}

- (void) addField:(NSString *)name {
	[self.fieldNames addObject:name];
	[self save];
}

@end
