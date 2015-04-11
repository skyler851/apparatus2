//
//  SummaryDetailViewController.h
//  Recruitment
//
//  Created by Nisha Nagarajan on 4/5/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SummaryDetailViewController : UIViewController

@property (nonatomic, strong) NSString *recruiterName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *lblRecruiterName;

@property (weak, nonatomic) IBOutlet UILabel *lblCandidateName;
@property (nonatomic, strong) id candidateName;

@property (weak, nonatomic) IBOutlet UILabel *lblNameSubHeader;
@property (nonatomic, strong) NSString *nameSubHeader;


@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (nonatomic, strong) NSString *email;

@property (weak, nonatomic) IBOutlet UILabel *lblGradDate;

@property (nonatomic, strong) NSString *gradDate;

@property (weak, nonatomic) IBOutlet UILabel *lblJobType;

@property (nonatomic, strong) NSString *jobType;

@property (weak, nonatomic) IBOutlet UILabel *lblArea;
@property (nonatomic, strong) NSString *areaOfInterest;

@property (weak, nonatomic) IBOutlet UILabel *lblSkills;
@property (nonatomic, strong) NSString *skills;

@property (weak, nonatomic) IBOutlet UILabel *lblNotes;
@property (nonatomic, strong) NSString *notes;

@property (weak, nonatomic) IBOutlet UILabel *lblCulture;
@property (nonatomic, strong) NSString *cultureFit;


@property (weak, nonatomic) IBOutlet UILabel *lblAptitude;
@property (nonatomic, strong) NSString *aptitude;


@property (weak, nonatomic) IBOutlet UILabel *lblTechSkill;
@property (nonatomic, strong) NSString *techSkills;

@property (weak, nonatomic) IBOutlet UILabel *lblFavorite;
@property (nonatomic, strong) NSString *favorite;

@property (weak, nonatomic) IBOutlet UILabel *lblDecision;
@property (nonatomic, strong) NSString *decision;

@property (nonatomic, strong) NSString *tempVar;

@end
