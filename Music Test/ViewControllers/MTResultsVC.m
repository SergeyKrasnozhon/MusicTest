//
//  MTResultsVC.m
//  Music Test
//
//  Created by Sergey on 1/20/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTResultsVC.h"
#import "MTApiPoll.h"
#import "MTApiSynchronizator.h"
#import "MTProgressView.h"

@interface MTResultsVC ()
@property (weak, nonatomic) IBOutlet MTProgressView *guitareProgressView;
@property (weak, nonatomic) IBOutlet MTProgressView *electricProgressView;
@property (weak, nonatomic) IBOutlet MTProgressView *bassProgressView;
@property (weak, nonatomic) IBOutlet MTProgressView *banjoProgressView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *message;
@end

@implementation MTResultsVC

-(void)viewDidLoad{
    [super viewDidLoad];
    [self prepareViews];
    [self startActivity];
    [MTApiSynchronizator receivePollResultsWithCompletion:^(MTApiPollReport *report, NSError *error) {
        [self stopActivity];
        [self updateViewsWithReport:report];
    }];
}

-(void)updateViewsWithReport:(MTApiPollReport*)report{
    self.guitareProgressView.progress = [report percentageForInstrument:MTInstrumentTypes.guitar];
    self.electricProgressView.progress = [report percentageForInstrument:MTInstrumentTypes.electric];
    self.bassProgressView.progress = [report percentageForInstrument:MTInstrumentTypes.bass];
    self.banjoProgressView.progress = [report percentageForInstrument:MTInstrumentTypes.banjo];
    self.username.hidden = NO;
    self.message.hidden = NO;
    NSUInteger selectedPercents = [report percentageForInstrument:self.pollDetails.instrument];
    self.message.text = [NSString stringWithFormat:@"%zd%% also like \"%@\"",
                         selectedPercents, self.pollDetails.instrument.type];
}

-(void)prepareViews{
    self.guitareProgressView.progress = 0;
    self.electricProgressView.progress = 0;
    self.bassProgressView.progress = 0;
    self.banjoProgressView.progress = 0;
    
    self.username.text = [NSString stringWithFormat:@"%@,", self.pollDetails.userName];
    self.username.hidden = YES;
    self.message.hidden = YES;
}
@end
