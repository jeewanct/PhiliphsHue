//
//  ViewController.m
//  GymApp2
//
//  Created by Clairvoyant on 01/03/17.
//  Copyright © 2017 Clairvoyant. All rights reserved.
//
#define YourSound @"beep-01a.mp3"
#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

//import of philips hue
#import "AppDelegate.h"
#import <HueSDK_iOS/HueSDK.h>
#define MAX_HUE 65535
@interface ViewController ()<UIGestureRecognizerDelegate,AVAudioPlayerDelegate>{
    NSTimer *timer;
    int currMinute;
    int currSeconds;
}
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic, strong) AVAudioPlayer *audioplayer;
@property (weak, nonatomic) IBOutlet UILabel *bridgeIpLabel;
@property (weak, nonatomic) IBOutlet UILabel *bridgeIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *bridgeLastHeartBeatLabel;
@property (weak, nonatomic) IBOutlet UIButton *randomLightButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currMinute=3;
    currSeconds=00;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    UIColor *topColor = [UIColor colorWithRed:73.0/255.0 green:232.0/255.0 blue:191.0/255.0 alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithRed:76.0/255.0 green:191.0/255.0 blue:245.0/255.0 alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    
    
    
    //philips hue
    PHNotificationManager *notificationManager = [PHNotificationManager defaultManager];
    // Register for the local heartbeat notifications
    [notificationManager registerObject:self withSelector:@selector(localConnection) forNotification:LOCAL_CONNECTION_NOTIFICATION];
    [notificationManager registerObject:self withSelector:@selector(noLocalConnection) forNotification:NO_LOCAL_CONNECTION_NOTIFICATION];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Find bridge" style:UIBarButtonItemStylePlain target:self action:@selector(findNewBridgeButtonAction)];
    
    self.navigationItem.title = @"QuickStart";
    
    [self noLocalConnection];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startButton:(id)sender {
     timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}


-(void)timerFired
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currMinute==2 && currSeconds==30){
            NSLog(@"2:55");
            [self.audioplayer play];
        }
        
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
            [_timerLabel setText:[NSString stringWithFormat:@"00:%02d:%02d",currMinute,currSeconds]];
      
    }
    else
    {
        [timer invalidate];
    }
}


- (AVAudioPlayer *)audioplayer {
    if(!_audioplayer) {
        NSURL *audioURL = [[NSBundle mainBundle] URLForResource:YourSound.stringByDeletingPathExtension withExtension:YourSound.pathExtension];
        NSData *audioData = [NSData dataWithContentsOfURL:audioURL];
        NSError *error = nil;
        // assing the audioplayer to a property so ARC won't release it immediately
        _audioplayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
        _audioplayer.delegate = self;
    }
    return _audioplayer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


//Philips Hue files

- (void)findNewBridgeButtonAction{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [app searchForBridgeLocal];
}
- (void)noLocalConnection{
   
        self.bridgeLastHeartBeatLabel.text = @"Not connected";
        [self.bridgeLastHeartBeatLabel setEnabled:NO];
        self.bridgeIpLabel.text = @"Not connected";
        [self.bridgeIpLabel setEnabled:NO];
        self.bridgeIdLabel.text = @"Not connected";
        [self.bridgeIdLabel setEnabled:NO];
    
        [self.randomLightButton setEnabled:NO];
}
- (void)localConnection{
    
    [self loadConnectedBridgeValues];
    
}
- (void)loadConnectedBridgeValues{
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    
    // Check if we have connected to a bridge before
    if (cache != nil && cache.bridgeConfiguration != nil && cache.bridgeConfiguration.ipaddress != nil){
        
        // Set the ip address of the bridge
        self.bridgeIpLabel.text = cache.bridgeConfiguration.ipaddress;
        
        // Set the identifier of the bridge
        self.bridgeIdLabel.text = cache.bridgeConfiguration.bridgeId;
        
        // Check if we are connected to the bridge right now
        if (app.phHueSDK.localConnected) {
            
            // Show current time as last successful heartbeat time when we are connected to a bridge
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterNoStyle];
            [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            
            self.bridgeLastHeartBeatLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
            
            [self.randomLightButton setEnabled:YES];
        } else {
            self.bridgeLastHeartBeatLabel.text = @"Waiting...";
            [self.randomLightButton setEnabled:NO];
        }
    }
}
- (IBAction)randomizeColoursOfConnectLights:(id)sender{
    [self.randomLightButton setEnabled:NO];
    
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        
        [lightState setHue:[NSNumber numberWithInt:arc4random() % MAX_HUE]];
        [lightState setBrightness:[NSNumber numberWithInt:254]];
        [lightState setSaturation:[NSNumber numberWithInt:254]];
        
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
            [self.randomLightButton setEnabled:YES];
        }];
    }
}


@end
