//
//  iFanViewController.h
//  iFan
//
//  Created by Jake Schwartz on 5/21/09.
//  Copyright DIGITAS 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

static inline CGPoint CGPointWithinBounds(CGPoint point, CGRect bounds)
{
	CGPoint ret = point;
	if (ret.x < CGRectGetMinX(bounds)) ret.x = CGRectGetMinX(bounds);
	else if (ret.x > CGRectGetMaxX(bounds)) ret.x = CGRectGetMaxX(bounds);
	if (ret.y < CGRectGetMinY(bounds)) ret.y = CGRectGetMinY(bounds);
	else if (ret.y > CGRectGetMaxY(bounds)) ret.y = CGRectGetMaxY(bounds);
	return ret;
}


@interface iFanViewController : UIViewController 
{
	CALayer *blade;
	CALayer *fan;
	NSTimer *animationTimer;
	UIButton *offBtn;
	UIButton *slowBtn;
	UIButton *mediumBtn;
	UIButton *fastBtn;
	
	BOOL fanStopped;
	
	float curFanSpeed;
	float fanRotation;
	float fanSpeed;
}

@end

