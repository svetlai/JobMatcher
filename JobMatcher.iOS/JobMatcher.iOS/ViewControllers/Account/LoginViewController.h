//
//  LoginViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *accountEmail;
@property (weak, nonatomic) IBOutlet UITextField *accountPassword;
- (IBAction)loginButtonTap:(id)sender;
- (IBAction)registerButtonTap:(id)sender;

@end
