//
//  RHPerson+CBSS.m
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

#import "RHPerson+CBSS.h"

@implementation RHPerson (CBSS)

- (void)addEmail:(NSString *)email label:(NSString *)label {
  RHMultiStringValue *values = [self emails];
  RHMutableMultiStringValue *mutableValues = [values mutableCopy];
  if (! mutableValues) mutableValues = [[RHMutableMultiStringValue alloc] initWithType:kABMultiStringPropertyType];
  if (label==nil) {
    label = [@[RHWorkLabel, RHHomeLabel, RHOtherLabel] objectAtIndex:arc4random()%3];
  }
  [mutableValues addValue:email withLabel:label];
  self.emails = mutableValues;
}

- (void)addPhone:(NSString *)phone label:(NSString *)label {
  RHMultiStringValue *values = [self phoneNumbers];
  RHMutableMultiStringValue *mutableValues = [values mutableCopy];
  if (! mutableValues) mutableValues = [[RHMutableMultiStringValue alloc] initWithType:kABMultiStringPropertyType];
  if (label==nil) {
    label = [@[RHPersonPhoneMobileLabel,
               RHPersonPhoneIPhoneLabel,
               RHPersonPhoneMainLabel,
               RHPersonPhoneHomeFAXLabel,
               RHPersonPhoneWorkFAXLabel,
               RHPersonPhoneOtherFAXLabel,
               RHPersonPhonePagerLabel] objectAtIndex:arc4random()%7];
  }
  [mutableValues addValue:phone withLabel:label];
  self.phoneNumbers = mutableValues;
}

@end
