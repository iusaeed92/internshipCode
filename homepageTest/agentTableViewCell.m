//
//  agentTableViewCell.m
//  homepageTest
//
//  Created by ibs on 7/16/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "agentTableViewCell.h"

@implementation agentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
