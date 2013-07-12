//
//  HEFTFirstViewController.m
//  LaboratorySixSigma
//
//  Created by Craig Webster on 27/06/2013.
//  Copyright (c) 2013 Craig Webster. All rights reserved.
//

#import "HEFTFirstViewController.h"
#import "HEFTQualityCalculator.h"


@interface HEFTFirstViewController ()

@end

@implementation HEFTFirstViewController

@synthesize resultsTable = _resultsTable;
@synthesize resultsDictionary = _resultsDictionary;
@synthesize interIndividualVariationField = _interIndividualVariationField;
@synthesize intraIndividualVarationField = _intraIndividualVarationField;
@synthesize myKeys = _myKeys;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSNumber *cv = [NSNumber numberWithDouble:0.0];
    NSNumber *bias = [NSNumber numberWithDouble:0.0];
    
    _resultsDictionary = [[NSMutableDictionary alloc]init];
    NSDictionary *minimumSpecifications = [[NSMutableDictionary alloc]initWithObjectsAndKeys:cv, @"CV", bias, @"BIAS",nil];
    NSDictionary *desirableSpecifications = [[NSMutableDictionary alloc]initWithObjectsAndKeys:cv, @"CV", bias, @"BIAS",nil];
    NSDictionary *optimumSpecifications = [[NSMutableDictionary alloc]initWithObjectsAndKeys:cv, @"CV", bias, @"BIAS",nil];
    
    [_resultsDictionary setObject:minimumSpecifications forKey:@"Minimum Specifications"];
    [_resultsDictionary setObject:desirableSpecifications forKey:@"Desirable Specifications"];
    [_resultsDictionary setObject:optimumSpecifications forKey:@"Optimum Specifications"];
    
    _myKeys = [_resultsDictionary allKeys];
    _resultsTable.bounces = YES;
    _resultsTable.scrollEnabled = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return [_myKeys count];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [_myKeys objectAtIndex:section];
    
    return title;
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray * sortedKeys = [_resultsDictionary objectForKey:[_myKeys objectAtIndex:section]];
    
   // NSArray * sortedKeys = [[[_resultsDictionary allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]objectAtIndex:section];
    
   return [sortedKeys count];
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//     return _myKeys;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier1 = @"CV";
    static NSString *CellIdentifier2 = @"BIAS";
    static NSString *CellIdentifier3 = @"TE";
    static NSString *CellIdentifier4 = @"ERROR";
    UIFont *myFont = [ UIFont fontWithName: @"Helvetica neue" size: 12.0 ];
    UIFont *myFont2 = [ UIFont fontWithName: @"Helvetica neue" size: 10.0 ];
    
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
   
    
    NSDictionary *specification = [ _resultsDictionary objectForKey:[_myKeys objectAtIndex:indexPath.section]];
    
    int resultsIndex = [indexPath indexAtPosition:[indexPath length] - 1];
    
    if(resultsIndex == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1];
        }
    
    
    
    NSNumber *cv = [specification objectForKey:@"CV"] ;
    
    NSString *cvStr = [formatter stringFromNumber:cv];
        
    cell.textLabel.text = @"Allowable %CV";
    cell.detailTextLabel.text = cvStr;
    
    cell.textLabel.font  = myFont;
    cell.detailTextLabel.font  = myFont2;
        
    return cell;
    }
    else if (resultsIndex == 1){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2];
        }
        
        NSNumber *bias = [specification objectForKey:@"BIAS"];
        NSString *biasStr = [formatter stringFromNumber:bias];
        
        cell.textLabel.text = @"Allowable %BIAS";
        cell.detailTextLabel.text = biasStr;
        cell.textLabel.font  = myFont;
        cell.detailTextLabel.font  = myFont2;
        
        return cell;
        
    }
    else if (resultsIndex == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier3];
        }
        
        NSNumber *te = [specification objectForKey:@"TE"];
        
        NSString *teStr = [formatter stringFromNumber:te];
        
        cell.textLabel.text = @"Allowable %Total Error";
        cell.detailTextLabel.text = teStr;
        cell.textLabel.font  = myFont;
        cell.detailTextLabel.font  = myFont2;
        cell.textLabel.adjustsFontSizeToFitWidth = YES;

        
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier4];
        }
        cell.textLabel.text = @"Calculation Error";
        cell.textLabel.font  = myFont;
        cell.detailTextLabel.font  = myFont2;
        cell.textLabel.numberOfLines = 2;
        
        return cell;
        
    }
}


- (IBAction)calculateSpecificationsButton:(id)sender {
    
    HEFTQualityCalculator *calculator = [[HEFTQualityCalculator alloc]init];
    NSMutableDictionary *results = [calculator qualitySpecificationWithintraIndividualBiologicalVariation:[[_intraIndividualVarationField text] doubleValue] interIndividualBiologicalVariation:[[_interIndividualVariationField text] doubleValue]];
    
    _resultsDictionary = results;
    
    [self.view endEditing:YES];
    [_resultsTable reloadData];
    
}
@end
