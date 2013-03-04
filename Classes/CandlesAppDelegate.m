//
//  CandlesAppDelegate.m
//  Candles
//
//  Created by Sergey Kopanev on 2/16/11.
//  Copyright 2011 Knees & Toads. All rights reserved.
//

#import "CandlesAppDelegate.h"
#import <dlfcn.h>


@implementation CandlesAppDelegate

@synthesize window;



#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	srand(time(0));
//	NSLog(@"res %d", (int)a);
	
	
	/// LOAD FONT
	int newFontCount = 0;
	NSBundle *frameworkBundle = [NSBundle bundleWithIdentifier:@"com.apple.GraphicsServices"];
	const char *frameworkPath = [[frameworkBundle executablePath] UTF8String];
	if (frameworkPath) {
		void *graphicsServices = dlopen(frameworkPath, RTLD_NOLOAD | RTLD_LAZY);
		if (graphicsServices) {
			BOOL (*GSFontAddFromFile)(const char*);
			//(void*)GSFontAddFromFile = dlsym(graphicsServices, "GSFontAddFromFile");
            GSFontAddFromFile = dlsym(graphicsServices, "GSFontAddFromFile");
			if (GSFontAddFromFile)
				for (NSString *fontFile in [[NSBundle mainBundle] pathsForResourcesOfType:@"ttf" inDirectory:nil]) {
//					NSLog(@"%@",fontFile);
					newFontCount += GSFontAddFromFile([fontFile UTF8String]);
				}
		}
	}
//	NSLog(@"fonts loaded %d", newFontCount);
//	NSLog(@"%@",[UIFont familyNames]);	
	
	
    nav = [[UINavigationController alloc] init];

#ifdef _developer_version
	c = [[CandlesController alloc] init];
#else
	c = [[HomeController alloc] init];
#endif
	
	[nav initWithRootViewController:c];
	[nav setNavigationBarHidden:YES];
	[c release];
	[self.window addSubview:nav.view];
    [self.window makeKeyAndVisible];
    return YES;
}

/*
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	NSLog(@"url %@", url);
	return YES;
}
*/


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[nav release];
    [window release];
    [super dealloc];
}


@end