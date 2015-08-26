/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The application delegate class used for setting up our data model and state restoration.
 */

#import "APLAppDelegate.h"
#import "APLProduct.h"
#import "APLMainTableViewController.h"
#import <CouchbaseLite/CouchbaseLite.h>

static NSString * const kDefaultDatabaseName = @"appleproduct";//DB name cannot have capital letters
static NSString * const kDidSaveInitialData = @"kDidSaveInitialData";

@implementation APLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


	NSError *dbCreationError;
	self.database = [[CBLManager sharedInstance] databaseNamed:kDefaultDatabaseName error:&dbCreationError];
	NSAssert(dbCreationError == nil, @"Failure creating database. Error = %@",dbCreationError.localizedDescription);

	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	if (![prefs boolForKey:kDidSaveInitialData]) {
		[self setupInitialData];
	}

	UINavigationController *navigationController = (UINavigationController *)[self.window rootViewController];
	// note we want the first view controller (not the visibleViewController) in case
	// we are being store from UIStateRestoration
	//
	APLMainTableViewController *viewController = (APLMainTableViewController *)navigationController.viewControllers[0];
	viewController.database = self.database;

	return YES;
}

- (void)setupInitialData {
	// load our data source and hand it over to APLMainTableViewController
	//
	NSArray *products = @[[APLProduct productWithType:[APLProduct deviceTypeTitle]
												 name:@"iPhone"
												 year:@2007
												price:@599.00],
						  [APLProduct productWithType:[APLProduct deviceTypeTitle]
												 name:@"iPod"
												 year:@2001
												price:@399.00],
						  [APLProduct productWithType:[APLProduct deviceTypeTitle]
												 name:@"iPod touch"
												 year:@2007
												price:@210.00],
						  [APLProduct productWithType:[APLProduct deviceTypeTitle]
												 name:@"iPad"
												 year:@2010
												price:@499.00],
						  [APLProduct productWithType:[APLProduct deviceTypeTitle]
												 name:@"iPad mini"
												 year:@2012
												price:@659.00],
						  [APLProduct productWithType:[APLProduct deviceTypeTitle]
												 name:@"iMac"
												 year:@1997
												price:@1299.00],
						  [APLProduct productWithType:[APLProduct deviceTypeTitle]
												 name:@"Mac Pro"
												 year:@2006
												price:@2499.00],
						  [APLProduct productWithType:[APLProduct portableTypeTitle]
												 name:@"MacBook Air"
												 year:@2008
												price:@1799.00],
						  [APLProduct productWithType:[APLProduct portableTypeTitle]
												 name:@"MacBook Pro"
												 year:@2006
												price:@1499.00]
						  ];

	for (APLProduct *product in products) {
		CBLDocument* document = [self.database documentWithID: product.title];
		NSError* saveError;
		NSDictionary *properties = [MTLJSONAdapter JSONDictionaryFromModel:product error:nil];
		if (![document putProperties: properties error: &saveError]) {
			NSLog(@"document putProperties FAILED!!!!\nDocument ID = %@\nError =%@",document.documentID,saveError);
		}
	}
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setValue:@(YES) forKey:kDidSaveInitialData];
}

#pragma mark - UIStateRestoration

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}

@end
