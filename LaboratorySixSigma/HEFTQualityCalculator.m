//
//  HEFTQualityCalculator.m
//  SixSigmaQualitySpecs
//
//  Created by Craig Webster on 26/06/2013.
//  Copyright (c) 2013 Craig Webster. All rights reserved.
//

#import "HEFTQualityCalculator.h"

@implementation HEFTQualityCalculator

-(NSMutableDictionary *)qualitySpecificationWithintraIndividualBiologicalVariation:(double)intraIndividualBiologicalVariation
    interIndividualBiologicalVariation:(double)interIndividualBiologicalVariation {
    
    NSNumber *minimumCV = [NSNumber numberWithDouble:0.75 * intraIndividualBiologicalVariation];
    NSNumber *minimumBias = [NSNumber numberWithDouble:0.375 * sqrt(pow(intraIndividualBiologicalVariation, 2) + pow(interIndividualBiologicalVariation, 2))];
    NSNumber *desirableCV = [NSNumber numberWithDouble:0.5 * intraIndividualBiologicalVariation];
    NSNumber *desirableBias =  [NSNumber numberWithDouble:0.250 * sqrt(pow(intraIndividualBiologicalVariation, 2) + pow(interIndividualBiologicalVariation, 2))];
    NSNumber *optimumCV = [NSNumber numberWithDouble:0.25 * intraIndividualBiologicalVariation];
    NSNumber *optimumBias = [NSNumber numberWithDouble:0.125 * sqrt(pow(intraIndividualBiologicalVariation, 2) + pow(interIndividualBiologicalVariation, 2))];
    NSNumber *minimumTE = [NSNumber numberWithDouble:minimumBias.doubleValue + 1.65 * minimumCV.doubleValue];
    NSNumber *desirableTE = [NSNumber numberWithDouble:desirableBias.doubleValue + 1.65 * desirableCV.doubleValue];
    NSNumber *optimumTE = [NSNumber numberWithDouble:optimumBias.doubleValue + 1.65 * optimumCV.doubleValue];
    
    NSMutableDictionary *specifications = [[NSMutableDictionary alloc]init];
    
    NSDictionary *minimumSpecifications = [[NSMutableDictionary alloc]initWithObjectsAndKeys:minimumCV, @"CV", minimumBias, @"BIAS",minimumTE, @"TE", nil];
    
    NSDictionary *desirableSpecifications = [[NSMutableDictionary alloc]initWithObjectsAndKeys:desirableCV, @"CV", desirableBias, @"BIAS",desirableTE, @"TE", nil];
    
    NSDictionary *optimumSpecifications = [[NSMutableDictionary alloc]initWithObjectsAndKeys:optimumCV, @"CV", optimumBias, @"BIAS",optimumTE, @"TE", nil];
    
    [specifications setObject:minimumSpecifications forKey:@"Minimum Specifications"];
    [specifications setObject:desirableSpecifications forKey:@"Desirable Specifications"];
    [specifications setObject:optimumSpecifications forKey:@"Optimum Specifications"];
    
    return specifications;
    
}

-(NSDictionary *) totalErrorAndSigmaCalculatorWithBias:(double)bias cv:(double)cv totalError:(double)totalError{
    
    NSNumber *te = [NSNumber numberWithDouble:bias + 1.65 * cv];

    NSNumber *sigmaScore = [NSNumber numberWithDouble:(totalError-bias)/cv];
    
    NSDictionary *qualitySpecifications = [[NSMutableDictionary alloc]initWithObjectsAndKeys:te, @"TE", sigmaScore, @"Sigma", nil];

    return qualitySpecifications;
    
}

-(NSNumber *) totalError:(double)bias cv:(double)cv {
    return [NSNumber numberWithDouble:bias + (2 * cv)];
}



@end
