//
//  AddJobOfferViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddJobOfferViewController.h"
#import "GlobalConstants.h"
#import "AddJobOfferViewModel.h"
#import "UserDataModel.h"
#import "Validator.h"
#import "HelperMethods.h"
#import "JobOfferService.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationProvider.h"
#import "HelperMethods.h"

@interface AddJobOfferViewController (){
    long selectedIndustry;
    long selectedWorkHours;
    UserDataModel* userData;
    Validator* validator;
    JobOfferService* jobOfferService;
    LocationProvider* locationProvider;
    double currentLatitude;
    double currentLongitude;
    NSString* message;
}

@end

@implementation AddJobOfferViewController
   NSString* const SegueFromAddJobOfferToRecruiter = @"segueFromAddJobOfferToRecruiter";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setPageTitle:self andTitle:@"Job Offer"];
    [HelperMethods setSackBarButtonText:self andText:@""];
    
    userData = [[UserDataModel alloc] init];
    validator = [[Validator alloc] init];
    jobOfferService = [[JobOfferService alloc] init];
    locationProvider = [[LocationProvider alloc] init];
    
    [locationProvider getLocationWithTarget:self
                                  andAction:@selector(locationUpdated:)];
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) locationUpdated: (CLLocation*) location{
    currentLatitude = location.coordinate.latitude;
    currentLongitude = location.coordinate.longitude;
    
    self.addJobOfferLatitude.text = [NSString stringWithFormat:@"%f", currentLatitude];
    self.addJobOfferLongitude.text = [NSString stringWithFormat:@"%f", currentLongitude];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.addJobOfferIndustryPickerView){
          return Industries.count;
    } else if (pickerView == self.addJobOfferWorkHoursPickerView){
        return WorkHours.count;
    }
    
    return 0;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.addJobOfferIndustryPickerView){
        return [Industries objectAtIndex:row];
    }else if (pickerView == self.addJobOfferWorkHoursPickerView){
        return [WorkHours objectAtIndex:row];
    }
    
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.addJobOfferIndustryPickerView){
        selectedIndustry = row;
    }else if (pickerView == self.addJobOfferWorkHoursPickerView){
        selectedWorkHours = row;
    }
}

- (IBAction)addJobOfferButtonTap:(id)sender {
    NSString* title = self.addJobOfferTitleLabel.text;
    NSString* description = self.addJobOfferDescriptionTextView.text;
    double salary = [self.addJobOfferSalaryLabel.text integerValue];
    if (![validator isValidLength:3 andParam:title]){
        [HelperMethods addAlert:@"Title must be at least 3 symbols."];
        return;
    }
    
    if (![validator isValidLength:3 andParam:description]){
        [HelperMethods addAlert:@"Description must be at least 3 symbols."];
        return;
    }
    
    if (self.addJobOfferSalaryLabel.text.length > 0 && isnan(salary)){
        [HelperMethods addAlert:@"Salary must be a number."];
        return;
    }
    
    
    AddJobOfferViewModel* addJobOfferModel = [AddJobOfferViewModel offerWithTitle:title andDescription:description andIndusry:selectedIndustry andWorkHours:selectedWorkHours andSalary:self.addJobOfferSalaryLabel.text andRecruiterProfileId:userData.profileId andLatitude:currentLatitude andLongitude:currentLongitude];
    
    [jobOfferService addOfferWithModel:addJobOfferModel andTarget:self];

}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    if (code == 200){
        message = @"Job offer added successfully!";
        [HelperMethods addAlert:message];
       [self performSegueWithIdentifier:SegueFromAddJobOfferToRecruiter sender:self];
    }else{
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}
@end
