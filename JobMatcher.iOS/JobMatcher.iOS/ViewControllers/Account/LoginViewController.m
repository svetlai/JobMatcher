//
//  LoginViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "LoginViewController.h"
#import "GlobalConstants.h"
#import "AccountService.h"
#import "Validator.h"
#import "HelperMethods.h"
#import "KeychainUserPass.h"
#import "UserDataModel.h"
#import "InternetConnectionChecker.h"

@interface LoginViewController (){
     NSString* message;
}

@end

@implementation LoginViewController
static AccountService* service;
static Validator* validator;
static InternetConnectionChecker *internetCheker;

NSString* const SegueFromLoginToRegister = @"segueFromLoginToRegister";
NSString* const SegueFromLoginToRecruiterHome = @"segueFromLoginToRecruiterHome";
NSString* const SegueFromLoginToJobSeekerHome = @"segueFromLoginToJobSeekerHome";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setPageTitle:self andTitle:AppName];
    [HelperMethods setSackBarButtonText:self andText:@""];

    validator = [[Validator alloc] init];
    service = [[AccountService alloc] init];
    internetCheker = [[InternetConnectionChecker alloc] init];
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)loginButtonTap:(id)sender {
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:NotConnectedStatus]) {
      [HelperMethods addAlert:NotConnectedMessage];
        
        return;
    }
    
    NSString *accountEmail = self.accountEmail.text;
    NSString *accountPassword = self.accountPassword.text;
    
    BOOL isValidEmail = [validator isValidEmail:accountEmail]; 
    if (!isValidEmail){
        message = [NSString stringWithFormat:@"Please enter a valid email!"];
        [HelperMethods addAlert:message];
        
        return;
    }
    
        [service loginUserWithEmail:accountEmail andPassword:accountPassword andTarget:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    if (code == 200){
        message = @"Logged in successfully!";
        [HelperMethods addAlert:message];
    } else {
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:nil];

    NSString* accessToken = [NSString stringWithFormat:@"%@ %@", @"bearer", [(NSDictionary*)json objectForKey:@"access_token"]];
    NSString* profileType = [NSString stringWithFormat:@"%@", [(NSDictionary*)json objectForKey:@"profileType"]];
    NSString* username = [NSString stringWithFormat:@"%@", [(NSDictionary*)json objectForKey:@"userName"]];
    NSString* profileId = [NSString stringWithFormat:@"%@", [(NSDictionary*)json objectForKey:@"profileId"]];
    
    if ([profileType isEqualToString:@"JobSeeker"]){
            [self performSegueWithIdentifier:SegueFromLoginToJobSeekerHome sender:self];
    } else if ([profileType isEqualToString:@"Recruiter"]){
            [self performSegueWithIdentifier:SegueFromLoginToRecruiterHome sender:self];
    }

    [KeychainUserPass save:KeyChainTokenKey data:accessToken];
    [KeychainUserPass save:KeyChainProfileTypeKey data:profileType];
    [KeychainUserPass save:KeyChainUsernameKey data:username];
    [KeychainUserPass save:KeyChainProfileIdKey data:profileId];
}

- (IBAction)registerButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueFromLoginToRegister sender:self];
}
@end
