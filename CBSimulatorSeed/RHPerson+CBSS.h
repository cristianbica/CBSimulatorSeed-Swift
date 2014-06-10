//
//  RHPerson+CBSS.h
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

#import "RHPerson.h"

@interface RHPerson (CBSS)
- (void)addEmail:(NSString *)email label:(NSString *)label;
- (void)addPhone:(NSString *)email label:(NSString *)label;
@end

