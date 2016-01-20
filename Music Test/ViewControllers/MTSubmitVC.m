//
//  MTSubmitVC.m
//  MusicTest
//
//  Created by Sergey on 1/19/16.
//  Copyright © 2016 Sergey. All rights reserved.
//

#import "MTSubmitVC.h"
#import "MTApiPoll.h"
#import "MTApiSynchronizator.h"
#import "MTResultsVC.h"

@interface MTSubmitVC ()
@property (nonatomic) MTApiPoll *poll;
@property (weak, nonatomic) IBOutlet UITextField *usernameTxtField;
@end

@implementation MTSubmitVC

#pragma mark - UI Actions
- (IBAction)bassSelected:(id)sender {
    [self updateGenreInstrument:MTInstrumentTypes.bass];
}

- (IBAction)electricSelected:(id)sender {
    [self updateGenreInstrument:MTInstrumentTypes.electric];
}

- (IBAction)guitarSelected:(id)sender {
    [self updateGenreInstrument:MTInstrumentTypes.guitar];
}

- (IBAction)banjoSelected:(id)sender {
    [self updateGenreInstrument:MTInstrumentTypes.banjo];
}
- (IBAction)endEditing:(UITextField *)sender {
    [self.view endEditing:YES];
    [self updateUserName:sender.text];
}

#pragma mark - Accessors
-(MTApiPoll *)poll{
    if(!_poll) _poll = [MTApiPoll new];
    return _poll;
}

#pragma mark - Service
-(void)updateGenreInstrument:(struct MTInstrumentType)instrument{
    [self.poll setInstrument:instrument];
    BOOL isSent = [self sendPoll];
    NSLog(@"Poll was %@ sent", isSent? @"":@"NOT");
}

-(void)updateUserName:(NSString*)username{
    [self.poll setUserName:(username.length>0)? username:@"John Doe"];
    BOOL isSent = [self sendPoll];
    NSLog(@"Poll was %@ sent", isSent? @"":@"NOT");
}

-(BOOL)sendPoll{
    BOOL retval = [self.poll isValid];
    do {
        if(!retval) break;
        [self startActivity];
        [MTApiSynchronizator submitPoll:self.poll withFinished:^(NSError *error) {
            [self stopActivity];
            [self performSegueWithIdentifier:@"resultDetailsVC" sender:self];
        }];
    } while (false);
    return retval;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isMemberOfClass:[MTResultsVC class]]){
        MTResultsVC *cntr = [segue destinationViewController];
        cntr.pollDetails = self.poll;
    }
}
@end




