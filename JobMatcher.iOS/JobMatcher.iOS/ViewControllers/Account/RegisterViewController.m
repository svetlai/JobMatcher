//
//  RegisterViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "RegisterViewController.h"
#import "GlobalConstants.h"
#import "InternetConnectionChecker.h"
#import "AccountService.h"
#import "Validator.h"
#import "HelperMethods.h"

@interface RegisterViewController ()<NSURLConnectionDelegate>{
    long selectedAccountType;
    NSString* message;
}

@end

@implementation RegisterViewController

static InternetConnectionChecker *internetCheker;
static AccountService* service;
static Validator* validator;

NSString* const SegueToLoginFromRegister = @"segueToLoginFromRegister";

@synthesize accountTypePicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setPageTitle:self andTitle:AppName];
    [HelperMethods setSackBarButtonText:self andText:@""];

    internetCheker = [[InternetConnectionChecker alloc] init];
    validator = [[Validator alloc] init];
    service = [[AccountService alloc] init];
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
      return AccountTypes.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [AccountTypes objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedAccountType = row;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)registerButtonTap:(id)sender {
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:NotConnectedStatus]) {
        [HelperMethods addAlert:NotConnectedMessage];
        
        return;
    }
    
    NSString *accountEmail = self.accountEmail.text;
    NSString *accountPassword = self.accountPassword.text;
    NSString *accountConfirmPassword = self.accountConfirmPassword.text;
    NSString *accountType = [NSString stringWithFormat:@"%ld", selectedAccountType];
    
    BOOL isValidEmail = [validator isValidEmail:accountEmail];    
    if (!isValidEmail){
        message = [NSString stringWithFormat:@"Please enter a valid email!"];
        [HelperMethods addAlert:message];

        return;
    }
    
    BOOL isPasswordLengthValid = [validator isValidLength: 6 andParam:accountPassword];
    if (!isPasswordLengthValid){
        message = [NSString stringWithFormat:@"Password must be at least %i symbols.", 6];
        [HelperMethods addAlert:message];

        return;
    }
    
    BOOL arePasswordsEqual = [validator arePasswordsEqual:accountPassword andConfirmPassword:accountConfirmPassword];
    if (!arePasswordsEqual){
        message = [NSString stringWithFormat:@"Passwords do not match."];        
        [HelperMethods addAlert:message];
        
        return;
    }
    
    [service registerUserWithEmail:accountEmail andPassword:accountPassword andProfileType:accountType andTarget: self];
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
        NSString* type = AccountTypes[selectedAccountType];
        message = [NSString stringWithFormat:@"Successfully registered as %@", type];
       [HelperMethods addAlert:message];
        
       [self performSegueWithIdentifier:SegueToLoginFromRegister sender:self];
    } else {
        message = @"Email is already taken.";
        [HelperMethods addAlert:message];
    }
    
}

- (IBAction)loginButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueToLoginFromRegister sender:self];
}

@end
