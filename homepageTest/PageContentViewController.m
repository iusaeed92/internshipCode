//
//  PageContentViewController.m
//  homepageTest
//
//  Created by ibs on 7/25/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIColor *myGreen = [UIColor colorWithRed:(57.0/255.0) green:(181.0/255.0) blue:(74.0/255.0) alpha:1.0];
    
    self.view.backgroundColor = myGreen;
    
    self.imageView.image = [UIImage imageNamed:self.imageFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)returnButton:(UIButton *)sender {
  [self performSegueWithIdentifier:@"backToChatAsView" sender:self];
}
@end
