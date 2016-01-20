//
//  MTApiSynchronizator.m
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTApiSynchronizator.h"
#import "MTApiPoll.h"

static NSString *const kSubmitPollEndpoint = @"submit-poll";
static NSString *const kResultsPollEndpoint = @"poll-results";

NSString * const kBaseUrlPath = API_BASE_URL_STRING;

const struct MTRestTypes MTRestTypes ={
    .GET = {.string = @"GET"},
    .POST = {.string = @"POST"}
};

@interface MTApiSynchronizator ()
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (readwrite, strong, nonatomic) void(^responseCallback) (NSData *data, NSURLResponse *response, NSError *error);
@end

@implementation MTApiSynchronizator

+(void)submitPoll:(MTApiPoll*)poll  withFinished:(RequestErrorCallback)finished{
    MTApiSynchronizator *syncer = [self new];
    
    syncer.responseCallback =^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSError *resultError = nil;
        if([(NSHTTPURLResponse*)response statusCode] != 200){
            resultError = [NSError errorWithDomain:response.URL.host
                                              code:[(NSHTTPURLResponse*)response statusCode]
                                          userInfo:@{}];
        }
        if (!resultError)
        {
            id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&resultError];
            if(!result) resultError = [[NSError alloc] initWithDomain:resultError.domain
                                                                 code:resultError.code
                                                             userInfo:@{NSLocalizedDescriptionKey:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]}];
        }
        finished(resultError);
    };
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSMutableURLRequest *request = [syncer prepareGeneralRequestWithDictionary:[poll toDictionary]
                                                                         URLString:[syncer destUrlStringFromRelativPath:kSubmitPollEndpoint]
                                                                            method:MTRestTypes.POST];
        [syncer sendRequest:request];
    });
}

+(void)receivePollResultsWithCompletion:(PollResultsCallback)completion{
    MTApiSynchronizator *syncer = [self new];
    
    syncer.responseCallback =^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSError *resultError = nil;
        if([(NSHTTPURLResponse*)response statusCode] != 200){
            resultError = [NSError errorWithDomain:response.URL.host
                                              code:[(NSHTTPURLResponse*)response statusCode]
                                          userInfo:@{}];
        }
        MTApiPollReport *report = nil;
        if (!resultError)
        {
            id result = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&resultError];
            if([result isKindOfClass:[NSDictionary class]]){
                [result removeObjectForKey:@"status"];
                report = [[MTApiPollReport alloc] initWithDictionary:result];
            }
            if(!result) resultError = [[NSError alloc] initWithDomain:resultError.domain
                                                                 code:resultError.code
                                                             userInfo:@{NSLocalizedDescriptionKey:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]}];
        }
        completion(report, resultError);
    };
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSMutableURLRequest *request = [syncer prepareGeneralRequestWithDictionary:@{}
                                                                         URLString:[syncer destUrlStringFromRelativPath:kResultsPollEndpoint]
                                                                            method:MTRestTypes.GET];
        [syncer sendRequest:request];
    });
}


#pragma mark - Accessors
- (NSURLSession *)session {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setAllowsCellularAccess:YES];
        session = [NSURLSession sessionWithConfiguration:config];
    });
    return session;
}

#pragma mark - Service
-(NSString*)destUrlStringFromRelativPath:(NSString*)relativePath{
    return [kBaseUrlPath stringByAppendingString:relativePath];
}

-(void)sendRequest:(NSURLRequest*)request
{
    self.dataTask = [[self session] dataTaskWithRequest:request
                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              if (self.responseCallback) {
                                                  self.responseCallback(data, response, error);
                                                  return;
                                              }
                                          });
                                      }];
    [self.dataTask resume];
}

-(NSMutableURLRequest*)prepareGeneralRequestWithDictionary:(NSDictionary *)sendDic
                                                 URLString:(NSString *)urlString
                                                    method:(struct MTRestType)method
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:method.string];
    if([request.HTTPMethod isEqualToString:MTRestTypes.GET.string])
    {
//no settings needed
    }
    else if([request.HTTPMethod isEqualToString:MTRestTypes.POST.string])
    {
        if(sendDic.count > 0){
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sendDic options:0 error:nil];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)jsonData.length] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:jsonData];
        }
    }
    else
    {
        NSLog(@"Unknown HTTP method");
        kill(getpid(), SIGSTOP);
    }
    return request;
}

@end








