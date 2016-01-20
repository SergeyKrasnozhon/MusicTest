//
//  MTApiTypes.h
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

struct MTInstrumentType{
    __unsafe_unretained NSString *type;
};

extern const struct MTInstrumentTypes{
    struct MTInstrumentType banjo;
    struct MTInstrumentType bass;
    struct MTInstrumentType electric;
    struct MTInstrumentType guitar;
}MTInstrumentTypes;

#pragma mark - MTApiPoll
@interface MTApiPoll : NSObject
@property struct MTInstrumentType instrument;
@property (nonatomic) NSString *userName;
-(NSDictionary<NSString*, NSString*>*)toDictionary;
-(BOOL)isValid;
@end

#pragma mark - MTApiPollReport
@interface MTApiPollReport : NSObject
-(instancetype)initWithDictionary:(NSDictionary*)dict;
-(NSUInteger)percentageForInstrument:(struct MTInstrumentType)instrument;
@end


