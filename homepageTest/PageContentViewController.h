//
//  PageContentViewController.h
//  homepageTest
//
//  Created by ibs on 7/25/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController



@property NSUInteger pageIndex;
@property NSString *imageFile;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)returnButton:(UIButton *)sender;


@end
