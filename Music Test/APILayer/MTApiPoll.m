//
//  MTApiTypes.m
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTApiPoll.h"

const struct MTInstrumentTypes MTInstrumentTypes ={
    .banjo      = {.type = @"banjo"},
    .bass       = {.type = @"bass"},
    .electric   = {.type = @"electric"},
    .guitar     = {.type = @"guitar"}
};

#pragma mark - MTApiPoll
@implementation MTApiPoll
-(BOOL)isValid{
    BOOL isValid = (self.instrument.type.length > 0);
    isValid &= (self.userName.length > 0);
    return isValid;
}

-(NSDictionary<NSString*, NSString*>*)toDictionary{
    NSDictionary<NSString*, NSString*> *retval = @{};
    if([self isValid]) retval = @{@"genre":self.instrument.type,
                                  @"username":self.userName};
    return retval;
}
@end

#pragma mark - MTApiPollReport
@interface MTApiPollReport()
@property (nonatomic, copy) NSDictionary *initialDict;
@end

@implementation MTApiPollReport
-(instancetype)initWithDictionary:(NSDictionary*)dict{
    if(self = [super init]){
        self.initialDict = dict;
        if(dict.count == 0) self = nil;
        [self percentageForInstrument:MTInstrumentTypes.bass];
    }
    return self;
}

-(NSUInteger)percentageForInstrument:(struct MTInstrumentType)instrument{
    NSUInteger total = [self totalSumm];
    NSUInteger instrumentSumm = [[self.initialDict objectForKey:instrument.type] unsignedIntegerValue];
    NSUInteger percentage = instrumentSumm*100/total;
    return percentage;
}

#pragma mark - Service
-(NSUInteger)totalSumm{
    NSUInteger retval = [[self.initialDict.allValues valueForKeyPath:@"@sum.self"] unsignedIntegerValue];
    return retval;
}
@end



