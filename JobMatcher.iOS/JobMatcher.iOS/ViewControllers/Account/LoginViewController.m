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

@interface LoginViewController (){
     NSString* message;
}

@end

@implementation LoginViewController
static AccountService* service;
static Validator* validator;

NSString* const SegueFromLoginToRegister = @"segueFromLoginToRegister";
NSString* const SegueFromLoginToRecruiterHome = @"segueFromLoginToRecruiterHome";
NSString* const SegueFromLoginToJobSeekerHome = @"segueFromLoginToJobSeekerHome";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HelperMethods setPageTitle:self andTitle:AppName];
    [HelperMethods setSackBarButtonText:self andText:@""];

    validator = [[Validator alloc] init];
    service = [[AccountService alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonTap:(id)sender {
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
    //    NSLog(@"%@", error);
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
   // NSLog(@"%@", httpResponse);
    if (code == 200){
        message = @"Logged in successfully!";
        [HelperMethods addAlert:message];
    } else {
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
//    NSLog(@"test");
//    NSString* jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", jsonString);
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:nil];

    NSString* accessToken = [NSString stringWithFormat:@"%@ %@", @"bearer", [(NSDictionary*)json objectForKey:@"access_token"]];
    NSString* profileType = [NSString stringWithFormat:@"%@", [(NSDictionary*)json objectForKey:@"profileType"]];
    NSString* username = [NSString stringWithFormat:@"%@", [(NSDictionary*)json objectForKey:@"userName"]];

    if ([profileType isEqualToString:@"JobSeeker"]){
            [self performSegueWithIdentifier:SegueFromLoginToJobSeekerHome sender:self];
    } else if ([profileType isEqualToString:@"Recruiter"]){
            [self performSegueWithIdentifier:SegueFromLoginToRecruiterHome sender:self];
    }

    [KeychainUserPass save:KeyChainTokenKey data:accessToken];
    [KeychainUserPass save:KeyChainProfileTypeKey data:profileType];
    [KeychainUserPass save:KeyChainUsernameKey data:username];
    
    // TODO on logout
    //[KeychainUserPass delete:@"access_token"];
    
    // get token
    //    NSString* token = [KeychainUserPass load:@"access_token"];
    
   // NSLog(@"%@", token);
}

- (IBAction)registerButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueFromLoginToRegister sender:self];
}
@end
