//
//  lbl_iphone_appAppDelegate.m
//  lbl-iphone-app
//
//  Created by John Peterson on 11/13/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "lbl_iphone_appAppDelegate.h"
#import "lbl_iphone_appViewController.h"

@implementation lbl_iphone_appAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize mainViewController;
@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	// Set the view controller as the window's root view controller and display.
    //self.window.rootViewController = self.navigationController;
    [self.window addSubview: self.mainViewController.view];
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
	self.mainViewController.managedObjectContext = self.managedObjectContext;
	AppManager *appManager = [AppManager getInstance];
	[appManager registerCoreData:self.managedObjectModel context:self.managedObjectContext
				 storeCoordinator:self.persistentStoreCoordinator];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (NSManagedObjectContext *) managedObjectContext {
	if (managedObjectContext != nil) {
		return managedObjectContext;
	}
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[managedObjectContext setPersistentStoreCoordinator: coordinator];
	}
	
	return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
	if (managedObjectModel != nil) {
		return managedObjectModel;
	}
	managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
	
	return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	if (persistentStoreCoordinator != nil) {
		return persistentStoreCoordinator;
	}
	NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
											   stringByAppendingPathComponent: @"<Project Name>.sqlite"]];
	NSError *error = nil;
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
								  initWithManagedObjectModel:[self managedObjectModel]];
	if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
												 configuration:nil URL:storeUrl options:nil error:&error]) {
		/*Error for store creation should be handled in here*/
	}
	
	return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}




@end
