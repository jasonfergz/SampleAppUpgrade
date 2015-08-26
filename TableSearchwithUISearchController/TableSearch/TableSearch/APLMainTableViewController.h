/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The application's primary table view controller showing a list of products.
 */

#import "APLBaseTableViewController.h"
@class CBLDatabase;

@interface APLMainTableViewController : APLBaseTableViewController

@property (nonatomic, copy) NSArray *products;
@property (nonatomic, strong) CBLDatabase *database;

@end
