//
//  PageContentViewController.h
//  homepageTest
//
//  Created by ibs on 7/21/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController <UIPageViewControllerDataSource>



@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;


@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;



@end
