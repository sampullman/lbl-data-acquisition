//
//  InputFieldsModel.h
//  lbl-iphone-app
//
//  Created by John Peterson on 11/19/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InputFieldsModel : NSObject {
	NSMutableArray *fieldNames;
	NSString *path;
}
@property (nonatomic, strong) NSMutableArray *fieldNames;
@property (nonatomic, strong) NSString *path;

+ (InputFieldsModel *) getInstance;
+ (NSString *) savedFieldsPath;

- (int) count;
- (NSString *) get:(int)ind;
- (void) removeField:(int)ind;
- (void) addField:(NSString *)name;
- (void) save;

@end
