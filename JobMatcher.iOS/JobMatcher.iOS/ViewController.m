//
//  ViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "ViewController.h"
#import "GlobalConstants.h"
#import "HelperMethods.h"

@interface ViewController ()

@end

@implementation ViewController

NSString* const SegueToLoginScene = @"segueToLoginScene";
NSString* const SegueToRegisterScene = @"segueToRegisterScene";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [HelperMethods setPageTitle:self andTitle:AppName];
    [HelperMethods setSackBarButtonText:self andText:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toLoginButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueToLoginScene sender:self];
};

- (IBAction)toRegisterButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueToRegisterScene sender:self];
}
@end
