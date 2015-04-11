//
//  EditSummaryViewController.h
//  Recruitment
//
//  Created by Stephanie Kyler on 4/8/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface EditSummaryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *lblRecruiterName;
@property (nonatomic, strong) NSString *recruiterName;

@property (weak, nonatomic) IBOutlet UILabel *lblCandidateName;
@property (nonatomic, strong) NSString *candidateName;

@property (weak, nonatomic) IBOutlet UILabel *lblCandidateInfo;
@property (nonatomic, strong) NSString *candidateInfo;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;


@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (nonatomic, strong) NSString *email;

@property (weak, nonatomic) IBOutlet UITextField *txtGradDate;
@property (nonatomic, strong) NSString *gradDate;

@property (weak, nonatomic) IBOutlet UITextField *txtJobType;
@property (nonatomic, strong) NSString *jobType;

@property (weak, nonatomic) IBOutlet UITextField *txtArea;
@property (nonatomic, strong) NSString *area;

@property (weak, nonatomic) IBOutlet UITextField *txtSkills;
@property (nonatomic, strong) NSString *skills;

@property (weak, nonatomic) IBOutlet UITextField *txtCultureFit;
@property (nonatomic, strong) NSString *cultureFit;

@property (weak, nonatomic) IBOutlet UITextField *txtAptitude;
@property (nonatomic, strong) NSString *aptitude;

@property (weak, nonatomic) IBOutlet UITextField *txtTechSkill;
@property (nonatomic, strong) NSString *techSkill;

@property (weak, nonatomic) IBOutlet UITextField *txtFavorite;
@property (nonatomic, strong) NSString *favorite;

@property (weak, nonatomic) IBOutlet UITextField *txtNotes;
@property (nonatomic, strong) NSString *notes;

@property (weak, nonatomic) IBOutlet UITextField *txtDecision;
@property (nonatomic, strong) NSString *decision;
@end
