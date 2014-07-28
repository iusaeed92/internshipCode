//
//  conversationTableViewCell.h
//  homepageTest
//
//  Created by ibs on 6/30/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface conversationTableViewCell : UITableViewCell


//conversation cell

@property (strong, nonatomic) IBOutlet UILabel *customTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *customImageView;
@property (strong, nonatomic) IBOutlet UILabel *customStoryTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *customTextLabelView;
@property (strong, nonatomic) IBOutlet UILabel *customAgentNameLabel;
@property (nonatomic) int customCellCountdown;


@end
