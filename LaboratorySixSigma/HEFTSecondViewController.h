//
//  HEFTSecondViewController.h
//  LaboratorySixSigma
//
//  Created by Craig Webster on 27/06/2013.
//  Copyright (c) 2013 Craig Webster. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HEFTAppDelegate;
@class HEFTFirstViewController;

@interface HEFTSecondViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, retain) UIPickerView *myPickerView;
@property (nonatomic, retain) NSArray *pickerViewArray;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) UIView *currentPicker;
@property (weak, nonatomic) IBOutlet UITextField *allowableBiasField;
@property (weak, nonatomic) IBOutlet UITextField *observedBIASField;
@property (weak, nonatomic) IBOutlet UITextField *allowableCVField;
@property (weak, nonatomic) IBOutlet UITextField *observedCVField;
@property (weak, nonatomic) IBOutlet UILabel *sigmaScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *allowableTotalError;
@property (weak, nonatomic) IBOutlet UILabel *observedTotalError;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (nonatomic, retain) HEFTAppDelegate *myAppDelegate;
@property (nonatomic, retain) HEFTFirstViewController *rootViewController;
@property (nonatomic) BOOL specificationsEdited;


- (IBAction)calculate:(id)sender;
- (IBAction)hidePicker:(id)sender;

@end
