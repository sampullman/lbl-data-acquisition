//
//  InputFieldsModel.h
//  lbl-iphone-app
//
//  Created by John Peterson on 11/19/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SavedField;

@interface InputFieldsModel : NSObject {
	NSMutableArray *fields;
	NSString *path;
}
@property (nonatomic, strong) NSMutableArray *fields;
@property (nonatomic, strong) NSString *path;

+ (InputFieldsModel *) getInstance;
+ (NSString *) savedFieldsPath;

- (int) count;
- (NSString *) getName:(int)ind;
- (NSString *) getValue:(int)ind;
- (NSString *) getAutoInc:(int)ind;
- (void) removeField:(int)ind;
- (void) addSavedField:(SavedField *)field;
- (void) addField:(NSString *)name value:(NSString *)value autoInc:(NSNumber *)autoInc;
- (void) setToArray:(NSMutableArray *)array;
- (void) save;

@end
