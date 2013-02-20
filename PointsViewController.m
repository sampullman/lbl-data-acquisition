//
//  PointsViewController.m
//  lbl-iphone-app
//
//  Created by John Peterson on 11/14/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "PointsViewController.h"
#import "PointEditController.h"

@implementation PointsViewController

@synthesize savedPoints;
@synthesize pointsView;
@synthesize appManager;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.savedPoints count];
}

- (IBAction)sendPoints {
    [self.appManager sendPoints];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PointCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									     reuseIdentifier:cellIdentifier];
    }
	SavedPoint *point = (SavedPoint *)[self.savedPoints objectAtIndex:[indexPath row]];
	NSString *dateString = [self.appManager dateToString:point.time];
	cell.textLabel.text = dateString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	PointEditController *pointEdit = [[PointEditController alloc] initWithNibName:@"PointEditController" bundle:nil];
	SavedPoint *point = (SavedPoint *)[self.savedPoints objectAtIndex:[indexPath row]];
	pointEdit.point = point;
	[[self navigationController] pushViewController:pointEdit animated:YES];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


- (void)viewWillAppear:(BOOL)animated	{
	self.appManager = [AppManager getInstance];
	NSArray *points = [self.appManager getPoints];
    self.savedPoints = [NSMutableArray arrayWithCapacity:[points count]];
	for(int i=0;i<[points count];i+=1) {
		[self.savedPoints addObject:[points objectAtIndex:i]];
	}
    [self.pointsView reloadData];
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"Saved Points";
}

- (void) viewDidAppear:(BOOL)animated {
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
