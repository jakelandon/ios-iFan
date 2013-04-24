//
//  iFanViewController.m
//  iFan
//
//  Created by Jake Schwartz on 5/21/09.
//  Copyright DIGITAS 2009. All rights reserved.
//

#import "iFanViewController.h"

@implementation iFanViewController




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];

	[self.view setBackgroundColor:[UIColor whiteColor]];
	
	curFanSpeed = 0;
	fanRotation = 0;
	fanSpeed = 0;
	fanStopped = NO;
	
	CGImageRef bladeImg  = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blade" ofType:@"png"]] CGImage];
	blade = [CALayer layer];
	[blade setFrame:CGRectMake( (320 - CGImageGetWidth(bladeImg)) / 2, (420 - CGImageGetHeight(bladeImg)) / 2, CGImageGetWidth(bladeImg), CGImageGetHeight(bladeImg))];
	[blade setContents:(id)bladeImg];
	[self.view.layer addSublayer:blade];
	
	offBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[offBtn setFrame:CGRectMake( 6, 445, 71, 30 )];
	[offBtn setTitle:@"OFF" forState:UIControlStateNormal];
	[offBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[offBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
	[offBtn addTarget:self action:@selector(offBtnPressed) forControlEvents:UIControlEventTouchUpInside];
	[offBtn setEnabled:NO];
	[self.view addSubview:offBtn];
	
	slowBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[slowBtn setFrame:CGRectMake( 83, 445, 71, 30 )];
	[slowBtn setTitle:@"SLOW" forState:UIControlStateNormal];
	[slowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[slowBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
	[slowBtn addTarget:self action:@selector(slowBtnPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:slowBtn];
	
	mediumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[mediumBtn setFrame:CGRectMake( 160, 445, 71, 30 )];
	[mediumBtn setTitle:@"MEDIUM" forState:UIControlStateNormal];
	[mediumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[mediumBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
	[mediumBtn addTarget:self action:@selector(mediumBtnPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:mediumBtn];
	
	fastBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[fastBtn setFrame:CGRectMake( 237, 445, 71, 30 )];
	[fastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[fastBtn setTitle:@"FAST" forState:UIControlStateNormal];
	[fastBtn addTarget:self action:@selector(fastBtnPressed) forControlEvents:UIControlEventTouchUpInside];
	[fastBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
	[self.view addSubview:fastBtn];
	
	animationTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0f/30.0f target:self selector:@selector(animate) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:animationTimer forMode:NSDefaultRunLoopMode];
}

-(void)animate
{
	if( !fanStopped )
	{
		if( curFanSpeed < fanSpeed )
		{
			curFanSpeed += .1;
		}
		if( curFanSpeed > fanSpeed )
		{
			curFanSpeed -= .1;
		}
		
		if( curFanSpeed < 0 )
		{
			curFanSpeed = 0;
		}
		
		//fanRotation += fanSpeed * 3;
		float newFanRotation = fanRotation - curFanSpeed * 3;
		float fanDX;
		float fanVX;
		fanDX = ( newFanRotation - fanRotation);
		fanVX = fanDX; 
		fanRotation -= fanVX;
		
		[CATransaction begin]; 
		[CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions]; 
		
		[blade setAffineTransform:CGAffineTransformMakeRotation( fanRotation * ( 3.14 / 180 ))];
		
		[CATransaction commit];
	}
}

-(void)offBtnPressed
{
	fanSpeed = 0;
	
	[offBtn setEnabled:NO];
	[slowBtn setEnabled:YES];
	[mediumBtn setEnabled:YES];
	[fastBtn setEnabled:YES];
	
}

-(void)slowBtnPressed
{
	fanSpeed = 4;
	
	[offBtn setEnabled:YES];
	[slowBtn setEnabled:NO];
	[mediumBtn setEnabled:YES];
	[fastBtn setEnabled:YES];
}

-(void)mediumBtnPressed
{
	fanSpeed = 7;
	
	[offBtn setEnabled:YES];
	[slowBtn setEnabled:YES];
	[mediumBtn setEnabled:NO];
	[fastBtn setEnabled:YES];
}

-(void)fastBtnPressed
{
	fanSpeed = 10;	
	
	[offBtn setEnabled:YES];
	[slowBtn setEnabled:YES];
	[mediumBtn setEnabled:YES];
	[fastBtn setEnabled:NO];
}

- (void)touchPoint:(CGPoint)pt
{
	
	if( hypot( pt.x - blade.position.x, pt.y - blade.position.y ) > blade.frame.size.width / 2 )
	{
	//	NSLog( @"blade touched");
		
	//	curFanSpeed = .1;
	}
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	CGPoint pointInView = [[touches anyObject] locationInView:self.view];
	
	// Clip our pointInView to within 5 pixels of any edge, so we can't position objects near or beyond 
	// the edge of the sound stage
	pointInView = CGPointWithinBounds(pointInView, CGRectInset([self.view bounds], 5., 5.));
	
	// Convert the view point to our layer / sound stage coordinate system, which is centered at (0,0)
	//CGPoint pointInLayer = CGPointMake(pointInView.x - [self.view frame].size.width / 2., pointInView.y - [self.view frame].size.height / 2.);
	CGPoint pointInLayer = CGPointMake(pointInView.x , pointInView.y );
	
	// Find out if the distance between the touch is within the tolerance threshhold for moving
	// the source object or the listener object
	/*if (hypot( _pinPos.x - pointInLayer.x, _pinPos.y - pointInLayer.y ) < kTouchDistanceThreshhold )
	{
		_draggingLayer = _pinLayer;
	}
	else
	{
		_draggingLayer = nil;
	}*/
	
	if( hypot( pointInLayer.x - blade.position.x, pointInLayer.y - blade.position.y ) < blade.frame.size.width / 2 )
	{
		fanStopped = YES;
		curFanSpeed = 0;
	}
	
	[self touchPoint:pointInLayer];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	// Called repeatedly as the touch moves
	
	CGPoint pointInView = [[touches anyObject] locationInView:self.view];
	pointInView = CGPointWithinBounds(pointInView, CGRectInset([self.view bounds], 5., 5.));
	CGPoint pointInLayer = CGPointMake( pointInView.x, pointInView.y );	[self touchPoint:pointInLayer];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{

	CGPoint pointInView = [[touches anyObject] locationInView:self.view];
	
	// Clip our pointInView to within 5 pixels of any edge, so we can't position objects near or beyond 
	// the edge of the sound stage
	pointInView = CGPointWithinBounds(pointInView, CGRectInset([self.view bounds], 5., 5.));
	
	// Convert the view point to our layer / sound stage coordinate system, which is centered at (0,0)
	//CGPoint pointInLayer = CGPointMake(pointInView.x - [self.view frame].size.width / 2., pointInView.y - [self.view frame].size.height / 2.);
	CGPoint pointInLayer = CGPointMake(pointInView.x , pointInView.y );
	
	
	if( hypot( pointInLayer.x - blade.position.x, pointInLayer.y - blade.position.y ) < blade.frame.size.width / 2 )
	{
		fanStopped = NO;
		curFanSpeed = .1;
	}
	/*if( hypot( _pinPos.x - _pinHolePos.x, _pinPos.y - _pinHolePos.y ) > kPinPulledDistanceThreshholder )
	{
		if( isPinPulled == YES && isPinDropped == NO )
		{
			[self dropPin];
		}
	}
	 
	 
	
	_draggingLayer = nil;
	 */
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
