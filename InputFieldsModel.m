//
//  InputFieldsModel.m
//  lbl-iphone-app
//
//  Created by John Peterson on 11/19/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "InputFieldsModel.h"
#import "SavedField.h"

@implementation InputFieldsModel

@synthesize fields;
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
	self.fields = [[NSMutableArray alloc] initWithContentsOfFile:self.path];
	if(!self.fields) {
		self.fields = [[NSMutableArray alloc] init];
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
	return [self.fields count] / 3;
}

- (NSString *) getName:(int)ind {
	return [self.fields objectAtIndex:ind*3];
}

- (NSString *) getValue:(int)ind {
	return [self.fields objectAtIndex:ind*3 + 1];
}

- (NSString *) getAutoInc:(int)ind {
	return [self.fields objectAtIndex:ind*3 + 2];
}

- (void) removeField:(int)ind {
	[self.fields removeObjectAtIndex:ind];
	[self.fields removeObjectAtIndex:ind];
	[self.fields removeObjectAtIndex:ind];
	[self save];
}

- (void) setToArray:(NSMutableArray *)array {
    [self.fields removeAllObjects];
    for(int i=0;i<[array count];i+=1) {
        SavedField *field = [array objectAtIndex:i];
        [self.fields addObject:field.name];
        [self.fields addObject:field.value];
        [self.fields addObject:field.autoInc];
    }
    [self save];
}

- (void) save {
	[self.fields writeToFile:self.path atomically:YES];
}

- (void) addSavedField:(SavedField *)field {
    [self addField:field.name value:field.value autoInc:field.autoInc];
}

- (void) addField:(NSString *)name value:(NSString *)value autoInc:(NSNumber *)autoInc {
	[self.fields addObject:name];
    [self.fields addObject:value];
    [self.fields addObject:autoInc];
	[self save];
}

@end
