//
//  CoreLocationControllerDelegate.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/6/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoreLocationControllerDelegate 
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end