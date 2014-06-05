//
//  rshViewController.m
//  homepageTest
//
//  Created by Ibrahim Saeed on 6/2/14.
//  Copyright (c) 2014 Ibrahim Saeed. All rights reserved.
//

#import "rshViewController.h"

@interface rshViewController ()

@end

@implementation rshViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//code borrowed from stackoverflow to convert a hexstring to a color.
// http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor
//
//


//
//
//-(UIColor *) colorFromHexString:(NSString *)hexString {
//    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
//    if([cleanString length] == 3) {
//        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
//                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
//                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
//                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
//    }
//    if([cleanString length] == 6) {
//        cleanString = [cleanString stringByAppendingString:@"ff"];
//    }
//    
//    unsigned int baseValue;
//    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
//    
//    float red = ((baseValue >> 24) & 0xFF)/255.0f;
//    float green = ((baseValue >> 16) & 0xFF)/255.0f;
//    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
//    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
//    
//    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];



//}

//-------------------------------------------------------------
////////////*******This chunk provides the scroll up****------

#define kOFFSET_FOR_KEYBOARD 220.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
  //  if ([sender isEqual:mailTf])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}



//----------------------------------------------------------------------------------
////////////*******End of Scroll up block****---------------------------------------










- (IBAction)loginButton:(UIButton *)sender { //when login button is pressed, everything in this function will be implemented

    NSString *username = self.usernameTextfield.text;
    NSLog(@"%@", username);
    
    


}





- (IBAction)joinButton:(UIButton *)sender { //when join button is pressed, everything in this button is pressed.
}
@end








