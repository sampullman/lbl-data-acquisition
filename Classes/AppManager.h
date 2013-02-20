//
//  DataManager.h
//  lbl-iphone-app
//
//  Created by John Peterson on 12/2/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "CoreLocationControllerDelegate.h"
#import "SavedLocation.h"

@class SBJsonParser;
@class SBJsonWriter;

@interface AppManager : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locMgr;
	id __unsafe_unretained locDelegate;
	NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *managedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
	NSDateFormatter *dateFormatter;
    SBJsonParser *jsonParser;
    SBJsonWriter *jsonWriter;
}
//@property (nonatomic, retain) SBJsonParser *jsonParser;
//@property (nonatomic, retain) SBJsonWriter *jsonWriter;
@property (nonatomic, strong) CLLocationManager *locMgr;
@property (nonatomic, unsafe_unretained) id locDelegate;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic ,strong) NSDateFormatter *dateFormatter;

+ (AppManager *) getInstance;
+ (float) getFieldYInit;
- (void) registerCoreData:(NSManagedObjectModel *)model 
				context:(NSManagedObjectContext *)context
				storeCoordinator:(NSPersistentStoreCoordinator *)storeCoordinator;	
- (NSString *)dateToString:(NSDate *)date;
- (NSMutableArray *) getPoints;
- (void) setLocationDelegate:(id)delegate;
- (NSString *) getLocationString:(SavedLocation *)location;
- (void) sendPoints;

@end
