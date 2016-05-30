//
//  HEFTFirstViewController.h
//  LaboratorySixSigma
//
//  Created by Craig Webster on 27/06/2013.
//  Copyright (c) 2013 Craig Webster. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HEFTSpecificationsViewController;

@interface HEFTFirstViewController : UIViewController 

@property (strong) IBOutlet UITableView *resultsTable;
@property (weak, nonatomic) IBOutlet UITextField *intraIndividualVarationField;
@property (weak, nonatomic) IBOutlet UITextField *interIndividualVariationField;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (strong) NSMutableDictionary *resultsDictionary;
@property (strong) NSArray *myKeys;

- (IBAction)calculateSpecificationsButton:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
