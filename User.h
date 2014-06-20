//
//  User.h
//  homepageTest
//
//  Created by ibs on 6/20/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject


@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *accessToken;
@property (nonatomic) int tokenExpTime;







@end
