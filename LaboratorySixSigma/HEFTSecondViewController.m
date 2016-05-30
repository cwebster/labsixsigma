//
//  HEFTSecondViewController.m
//  LaboratorySixSigma
//
//  Created by Craig Webster on 27/06/2013.
//  Copyright (c) 2013 Craig Webster. All rights reserved.
//

#import "HEFTSecondViewController.h"
#import "HEFTAppDelegate.h"
#import "HEFTFirstViewController.h"
#import "HEFTQualityCalculator.h"
#import <QuartzCore/QuartzCore.h>

@interface HEFTSecondViewController ()

@end

@implementation HEFTSecondViewController

@synthesize currentPicker = _currentPicker;
@synthesize myPickerView = _myPickerView;
@synthesize pickerViewArray = _pickerViewArray;
@synthesize label = _label;
@synthesize allowableBiasField = _allowableBiasField;
@synthesize allowableCVField = _allowableCVField;
@synthesize observedBIASField = _observedBIASField;
@synthesize observedCVField = _observedCVField;
@synthesize myAppDelegate = _myAppDelegate;
@synthesize rootViewController = _rootViewController;
@synthesize allowableTotalError = _allowableTotalError;
@synthesize observedTotalError = _observedTotalError;
@synthesize sigmaScoreLabel = _sigmaScoreLabel;
@synthesize specificationsEdited = _specificationsEdited;
@synthesize calculateButton = _calculateButton;


- (void)viewDidAppear:(BOOL)animated{
    [self pickerView:_myPickerView didSelectRow:1 inComponent:1];
    
}

-(void)loadValuesForSpecificaitonKey:(NSString *)specificationKey{
    
    NSDictionary *specification = [_rootViewController.resultsDictionary objectForKey:specificationKey];
    
    NSNumber *allowableBIAS = [specification objectForKey:@"BIAS"];
    NSNumber *allowableCV = [specification objectForKey:@"CV"];
    NSNumber *allowableTE = [specification objectForKey:@"TE"];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:YES];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setFormatWidth:2.0];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMaximumSignificantDigits:3];
    
    NSString *allowableBIASstr = [formatter stringFromNumber:allowableBIAS];
    NSString *allowableCVstr = [formatter stringFromNumber:allowableCV];
    NSString *allowableTEstr = [formatter stringFromNumber:allowableTE];

    
    [_allowableBiasField setText: allowableBIASstr];
    [_allowableCVField setText: allowableCVstr ];
    [_allowableTotalError setText:allowableTEstr];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _myAppDelegate = [[UIApplication sharedApplication] delegate];
    UITabBarController *tabController = (UITabBarController *)_myAppDelegate.window.rootViewController;
    
    _rootViewController = [[tabController viewControllers] objectAtIndex:0];
    
    
    [self createPicker];
    
    self.pickerViewArray = _rootViewController.myKeys;
    [self pickerView:_myPickerView didSelectRow:1 inComponent:1];
    
    [self loadValuesForSpecificaitonKey:@"Minimum Specifications"];
    
    //round some corners
    self.sigmaScoreLabel.layer.cornerRadius = 8;
    self.observedTotalError.layer.cornerRadius=8;
    
    // add a border to the calculate button
    
    [[_calculateButton layer] setCornerRadius:8.0f];
    
    [[_calculateButton layer] setMasksToBounds:YES];
    
    [[_calculateButton layer] setBorderWidth:1.0f];
    
    _calculateButton.layer.borderColor = [UIColor orangeColor].CGColor;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UIPickerView


// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
	CGRect pickerRect = CGRectMake(	0.0,
                                   screenRect.size.height - size.height+58.0,
                                   screenRect.size.width,
                                   162);
	return pickerRect;
}

- (void)createPicker
{
	// note we are using CGRectZero for the dimensions of our picker view,
	// this is because picker views have a built in optimum size,
	// you just need to set the correct origin in your view.
	//
	// position the picker at the bottom
	
    _myPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	
	_myPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	
    CGSize pickerSize = [_myPickerView sizeThatFits:CGSizeZero];
	
    _myPickerView.frame = [self pickerFrameWithSize:pickerSize];
    
	_myPickerView.showsSelectionIndicator = YES;	// note this is default to NO
	
	// this view controller is the data source and delegate
	_myPickerView.delegate = self;
	_myPickerView.dataSource = self;
	
	// add this picker to our view controller, initially hidden
	_myPickerView.hidden = NO;
	[self.view addSubview:_myPickerView];
    
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
	if (pickerView == _myPickerView)	// don't show selection for the custom picker
	{
		// report the selection to the UI label
        
        NSString *specificaiton = [_pickerViewArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        
		_label.text = [NSString stringWithFormat:@"%@ ",
                      [_pickerViewArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
        [self loadValuesForSpecificaitonKey:specificaiton];
	}
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
	// note: custom picker doesn't care about titles, it uses custom views
	if (pickerView == _myPickerView)
	{
		if (component == 0)
		{
			returnStr = [_pickerViewArray objectAtIndex:row];
		}
	}
	
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
    
	if (component == 0)
		componentWidth = 280.0;	// first column size is wider to hold names
    
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 40.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [_pickerViewArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)calculate:(id)sender {
    
    if (![_observedCVField hasText] || ![_observedBIASField hasText]) {
        [self showErrorBox];
        return;
        
    }
    
    
    HEFTQualityCalculator *calculator = [[HEFTQualityCalculator alloc]init];
    
    NSDictionary *results = [calculator totalErrorAndSigmaCalculatorWithBias:[[_observedBIASField text]doubleValue]  cv:[[_observedCVField text]doubleValue]  totalError:[[_allowableTotalError text]doubleValue] ];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:YES];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setFormatWidth:2.0];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMaximumSignificantDigits:3];
    
    NSString *testr = [formatter stringFromNumber:[results objectForKey:@"TE"]];
    NSString *sigStr = [formatter stringFromNumber:[results objectForKey:@"Sigma"]];
    
    NSNumber *sigma = [results objectForKey:@"Sigma"];
    
    
    //if we've edited the specifications we need to calculate the total allowable error
    if (_specificationsEdited == true) {
        [self calculateTotalAllowableError];
    }
    
    
    // Highlight if in or out of specifications
    //sigma score
    if (sigma.doubleValue>=3) {
        [_sigmaScoreLabel setBackgroundColor:[UIColor greenColor]];
    } else{
        [_sigmaScoreLabel setBackgroundColor:[UIColor redColor]];
    }
    
    
    //total error
    if ([[_allowableTotalError text]doubleValue] > [[_observedTotalError text]doubleValue] ) {
        [_observedTotalError setBackgroundColor:[UIColor greenColor]];
    } else{
        [_observedTotalError setBackgroundColor:[UIColor redColor]];
    }
    
    //CV error
    if ([[_allowableCVField text]doubleValue] < [[_observedCVField text]doubleValue] ) {
        [_observedCVField setBackgroundColor:[UIColor redColor]];
    } else{
        [_observedCVField setBackgroundColor:[UIColor greenColor]];
    }
    
    //BIAS error
    if ([[_allowableBiasField text]doubleValue] < [[_observedBIASField text]doubleValue] ) {
        [_observedBIASField setBackgroundColor:[UIColor redColor]];
    } else{
        [_observedBIASField setBackgroundColor:[UIColor greenColor]];
    }
    
    [_observedTotalError setText:testr];
    [_sigmaScoreLabel setText:sigStr];
    
}


-(IBAction)hidePicker:(id)sender {
    
    [_myPickerView setHidden:true];
    _specificationsEdited = true;
    
    _label.text = [NSString stringWithFormat:@"%s ", "Self Calculated"];
    
}

-(void)calculateTotalAllowableError {
    HEFTQualityCalculator *calculator = [[HEFTQualityCalculator alloc]init];
    
    NSNumber *te = [calculator totalError:[[_allowableBiasField text] doubleValue] cv:[[_allowableCVField text] doubleValue]];
    
    [_allowableTotalError setText:[te stringValue]];
    
}

-(void)showErrorBox {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Experimental Data"
                                                                   message:@"Enter your observed %Bias and %CV"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
