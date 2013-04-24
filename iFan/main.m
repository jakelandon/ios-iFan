//
//  main.m
//  iFan
//
//  Created by Jake Schwartz on 5/21/09.
//  Copyright DIGITAS 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"iFanAppDelegate");
    [pool release];
    return retVal;
}
