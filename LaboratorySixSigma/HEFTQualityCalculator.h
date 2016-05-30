//
//  HEFTQualityCalculator.h
//  SixSigmaQualitySpecs
//
//  Created by Craig Webster on 26/06/2013.
//  Copyright (c) 2013 Craig Webster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEFTQualityCalculator : NSObject

-(NSMutableDictionary *)qualitySpecificationWithintraIndividualBiologicalVariation:(double)intraIndividualBiologicalVariation
                                         interIndividualBiologicalVariation:(double)interIndividualBiologicalVariation;

-(NSDictionary *) totalErrorAndSigmaCalculatorWithBias:(double)bias cv:(double)cv totalError:(double)totalError;

-(NSNumber *) totalError:(double)bias cv:(double)cv;

@end
