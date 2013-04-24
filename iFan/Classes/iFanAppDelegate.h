//
//  iFanAppDelegate.h
//  iFan
//
//  Created by Jake Schwartz on 5/21/09.
//  Copyright DIGITAS 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iFanViewController;

@interface iFanAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iFanViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iFanViewController *viewController;

@end

