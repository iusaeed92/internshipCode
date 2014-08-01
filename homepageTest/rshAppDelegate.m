//
//  rshAppDelegate.m
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/2/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "rshAppDelegate.h"

@implementation rshAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application { }
- (void)applicationDidEnterBackground:(UIApplication *)application { }
- (void)applicationWillEnterForeground:(UIApplication *)application { }
- (void)applicationDidBecomeActive:(UIApplication *)application { }
- (void)applicationWillTerminate:(UIApplication *)application { }

@end
