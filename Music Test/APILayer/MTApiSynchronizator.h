//
//  MTApiSynchronizator.h
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

struct MTRestType{
    __unsafe_unretained NSString *string;
};

extern const struct MTRestTypes{
    struct MTRestType GET;
    struct MTRestType POST;
}MTRestTypes;

@class MTApiPoll, MTApiPollReport;
typedef void(^RequestErrorCallback)(NSError *error);
typedef void(^PollResultsCallback)(MTApiPollReport *report, NSError *error);

@interface MTApiSynchronizator : NSObject
+(void)submitPoll:(MTApiPoll*)poll withFinished:(RequestErrorCallback)finished;
+(void)receivePollResultsWithCompletion:(PollResultsCallback)completion;
@end
