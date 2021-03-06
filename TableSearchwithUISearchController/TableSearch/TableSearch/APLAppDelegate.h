/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The application delegate class used for setting up our data model and state restoration.
 */

@import UIKit;
@class CBLDatabase;

@interface APLAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) CBLDatabase *database;

@end
