//
//  SavedField.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/6/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SavedField : NSManagedObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * value;

@end
