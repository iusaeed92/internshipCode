//
//  ViewController.h
//  homepageTest
//
//  Created by ibs on 7/25/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "PageContentViewController.h"




@interface ViewController : UIViewController <UIPageViewControllerDataSource>


- (IBAction)startButton:(UIButton *)sender;


@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;





@end
