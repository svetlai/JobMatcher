//
//  GlobalConstants.h
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    AccountancyBankingFinance = 0,
    BusinessConsultingAndManagement = 1,
    CharityAndVoluntaryWork = 2,
    CreativeArtsAndDesign = 3,
    EnergyAndUtilities = 4,
    EngineeringAndManufacturing = 5,
    EnvironmentAndAgriculture = 6,
    Healthcare = 7,
    Hospitality = 8,
    InformationTechnology = 9,
    Law = 10,
    LawEnforcementAndSecurity = 11,
    LeisureSportsAndTourism = 12,
    MarketingAdvertisingAndPr = 13,
    MediaAndInternet = 14,
    PropertyAndConstruction = 15,
    PublicServicesAndAdmin = 16,
    RecruitmentAndHr = 17,
    Retail = 18,
    Sales = 19,
    ScienceAndPharmaceuticals = 20,
    SocialCare = 21,
    TeachingAndEducation = 22,
    TransportAndLogistics = 23
} Industry;

@interface GlobalConstants : NSObject

extern NSString* const AppName;
extern NSString* const BaseUrl;
extern NSArray* AccountTypes;
extern NSArray* Industries;
extern NSArray* WorkHours;
extern NSArray* Degree;
extern NSArray* Level;

+(void)fillArrays;

@end
