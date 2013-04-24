//
//  iFanAppDelegate.m
//  iFan
//
//  Created by Jake Schwartz on 5/21/09.
//  Copyright DIGITAS 2009. All rights reserved.
//

#import "iFanAppDelegate.h"
#import "iFanViewController.h"

@implementation iFanAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	UIWindow *localWindow;
	CGRect windowFrame = [[UIScreen mainScreen] bounds];
	localWindow = [[UIWindow alloc] initWithFrame:windowFrame];
	self.window = localWindow;
	[localWindow release];
	
	viewController = [[iFanViewController alloc] init];
	
	// Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
