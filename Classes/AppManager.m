//
//  DataManager.m
//  lbl-iphone-app
//
//  Created by John Peterson on 12/2/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "AppManager.h"
#import "SBJson.h"

@implementation AppManager

@synthesize locMgr, locDelegate;
@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;
@synthesize dateFormatter;

static float FIELD_Y_INIT = 60.0;
static AppManager *SharedAppManager;

+ (AppManager *) getInstance {
	if(!SharedAppManager) {
		SharedAppManager = [[AppManager alloc] init];
	}
	return SharedAppManager;
}

+ (float) getFieldYInit {
    return FIELD_Y_INIT;
}

- (id)init {
    self = [super init];
    if(self) {
        jsonParser = [[SBJsonParser alloc] init];
        jsonWriter = [[SBJsonWriter alloc] init];
        self.locMgr = [[CLLocationManager alloc] init];
        self.locMgr.delegate = self;
        //self.locMgr.distanceFilter = kCLDistanceFilterNone;
        //self.locMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.dateFormatter = [[NSDateFormatter alloc] init];
        NSLog(@"enabled: %@", (self.locMgr.locationServicesEnabled == YES)? @"YES" : @"NO");
    }
    return self;
}

- (void) registerCoreData:(NSManagedObjectModel *)model 
		 context:(NSManagedObjectContext *)context
		 storeCoordinator:(NSPersistentStoreCoordinator *)storeCoordinator {
	self.managedObjectContext = context;
	self.managedObjectModel = model;
	self.persistentStoreCoordinator = storeCoordinator;
}

- (NSArray *) getPoints {
	NSError *error;
	NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SavedPoint" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	return fetchedObjects;
}

- (NSString *) dateToString:(NSDate *)date {
	[dateFormatter setDateFormat:@"MMMM d, YYYY"];
	return [dateFormatter stringFromDate:date];
}

- (void) setLocationDelegate:(id)delegate {
    self.locDelegate = delegate;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if([self.locDelegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
		[self.locDelegate locationUpdate:newLocation];
        NSLog(@"got manager loc update");
	} else {
        NSLog(@"got manager loc update no delegate");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"got manager loc error: %@", error);
	if([self.locDelegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
		[self.locDelegate locationError:error];
	}
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
}
    
- (NSString *) getLocationString:(SavedLocation *)location {
    return [[NSString alloc] initWithFormat:@"%g, %g",
            [location.latitude doubleValue], [location.longitude doubleValue]];
}

- (NSDictionary *)savePointsJson:(NSArray *)points {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            points, @"points", @"save_points", @"query", nil];
}

NSMutableData *responseData;
- (void) sendPoints {
    NSArray *points = [self getPoints];
    //jsonWriter.humanReadable = true;
    NSString *json = [jsonWriter stringWithObject:[self savePointsJson:points]];
    //id object = [jsonParser objectWithString:json];
    //NSLog(@"Data: %@ %@", json, jsonWriter.error);
    //NSData *postData = [json dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSURL *url = [NSURL URLWithString:@"http://www.sampullman.com/lbl_app/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                    cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSData *requestData = [NSData dataWithBytes:[json UTF8String] length:[json length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        responseData = [NSMutableData data];
        //NSLog(@"%@", json);
        //receivedData = [[NSMutableData data] retain];
    } else {
        NSLog(@"Connection unsuccesful");
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"Received response: %@", response.URL.path);
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //NSLog(@"Received data");
    [responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonString);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)dealloc {
}	


@end
