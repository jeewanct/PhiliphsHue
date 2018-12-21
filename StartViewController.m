//
//  StartViewController.m
//  GymApp2
//
//  Created by JEEVAN TIWARI on 03/03/17.
//  Copyright © 2017 Clairvoyant. All rights reserved.
//

#define MAX_HUE 65535
#import "StartViewController.h"
#import "StartViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import <HueSDK_iOS/HueSDK.h>
#import <QuartzCore/QuartzCore.h>

@interface StartViewController ()<AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *timerLable;
@property (weak, nonatomic) IBOutlet UILabel *prepareLabel;
@property (nonatomic, strong) AVAudioPlayer *audioplayer;
@property (weak, nonatomic) IBOutlet UIView *view1;

@end

@implementation StartViewController{
    NSTimer *timer;
    int currMinute;
    int currSeconds;
    int flag;
    int stationChange;
    NSString *YourSound;
    int change;
   AVAudioPlayer *_audioPlayer1;

}
@synthesize lightColor;
- (void)viewDidLoad {
    [super viewDidLoad];
    currMinute=3;
    currSeconds=0;
    flag=0;
    stationChange=0;
    [[_backButton layer] setBorderWidth:3.0f];
    [[_backButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[_backButton layer] setCornerRadius:8.0f];
    
    
    [[_resumeButton layer] setBorderWidth:3.0f];
    [[_resumeButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[_resumeButton layer] setCornerRadius:8.0f];
    
    
    [[_pauseButton layer] setBorderWidth:3.0f];
    [[_pauseButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[_pauseButton layer] setCornerRadius:8.0f];
    
    
    
    
    
    _view1.layer.borderWidth = 10.0f;
    _view1.layer.borderColor = [[UIColor whiteColor] CGColor];
    _view1.layer.shadowOffset = CGSizeMake(50,50);
    
    _view1.layer.shadowOpacity = 500;
    _view1.layer.cornerRadius = _view1.bounds.size.width/2;
    _view1.layer.masksToBounds = YES;
    
    
    
    
    // Do any additional setup after loading the view.
    // Light work
    PHNotificationManager *notificationManager = [PHNotificationManager defaultManager];
    // Register for the local heartbeat notifications
    [notificationManager registerObject:self withSelector:@selector(localConnection) forNotification:LOCAL_CONNECTION_NOTIFICATION];
    [notificationManager registerObject:self withSelector:@selector(noLocalConnection) forNotification:NO_LOCAL_CONNECTION_NOTIFICATION];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Find bridge" style:UIBarButtonItemStylePlain target:self action:@selector(findNewBridgeButtonAction)];
    
    self.navigationItem.title = @"QuickStart";
    
    [self noLocalConnection];
    
    
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/Round_Start_Bell.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    

    //light off
//    if([lightColor isEqual: [NSNumber numberWithInt:1]]){
//        NSLog(@"the light state is =%@",lightColor);
//    [self offDelegate];
//    }
    
    
}
// No Local Connection
- (void)noLocalConnection{
  
    NSLog(@"No connection");
    //[self.randomLightsButton setEnabled:NO];
}

// Local Connection
- (void)localConnection{
    
    [self loadConnectedBridgeValues];
    
}

// Light the color

- (void)randomizeColoursOfConnectLights{
   // [self.randomLightsButton setEnabled:NO];
    
   
}


- (void)loadConnectedBridgeValues{
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    
    // Check if we have connected to a bridge before
    if (cache != nil && cache.bridgeConfiguration != nil && cache.bridgeConfiguration.ipaddress != nil){
        
        // Set the ip address of the bridge
     //   self.bridgeIpLabel.text = cache.bridgeConfiguration.ipaddress;
        
        // Set the identifier of the bridge
       // self.bridgeIdLabel.text = cache.bridgeConfiguration.bridgeId;
        
        // Check if we are connected to the bridge right now
        if (UIAppDelegate.phHueSDK.localConnected) {
            
            // Show current time as last successful heartbeat time when we are connected to a bridge
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterNoStyle];
            [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            
            NSLog( @"%@" ,  [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]]);
            
           // [self.randomLightsButton setEnabled:YES];
        } else {
           // self.bridgeLastHeartbeatLabel.text = @"Waiting...";
          //  [self.randomLightsButton setEnabled:NO];
        }
    }
}

//find new bridge




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startAndPauseButton:(id)sender {
    UIColor *tempColor;
    
    
 //   [self randomizeColoursOfConnectLights];
    
    _prepareLabel.text=@"Round";
    
    
    NSLog(@"value of pause button %@",_pauseButton.titleLabel);
    if([_pauseButton.titleLabel.text isEqual:@"Pause"]){
       
        
        if(currMinute<0){
            
        }else{
            
            
                tempColor=_view1.backgroundColor;
        //    _view1.layer.borderColor = [UIColor colorWithRed:37.0f/255.0f green:198.0f/255.0f blue:238.0f/255.0f alpha:1.0].CGColor;
            _prepareLabel.text=@"ROUND STOP";
            
         
       //     _view1.backgroundColor = [UIColor blueColor];
            
            
           _view1.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0].CGColor;
            _view1.backgroundColor = [UIColor whiteColor];
            _timerLable.textColor=[UIColor blackColor];
           
          
        [_timerLable setText:[NSString stringWithFormat:@"%02d:%02d",currMinute,currSeconds]];
          [timer invalidate];
        flag=0;
      //  [self nDelegate4];
            [self onDelegate1];
        
        [_pauseButton setTitle:@"Start" forState:UIControlStateNormal];
        }
        
    }else{
        if(flag==0){
            if(currMinute>=1 || currSeconds>30){
                
                    _prepareLabel.text=@"ROUND";
            
                _view1.layer.borderColor=[UIColor greenColor].CGColor;
                 _view1.backgroundColor = [UIColor colorWithRed:9.0f/255.0f green:151.0f/255.0f blue:29.0f/255.0f alpha:1.0];
                _timerLable.textColor=[UIColor whiteColor];
            }
            
            else if(stationChange ==1){
                
            
                
                _prepareLabel.text=@"STATION CHANGE";
              _view1.backgroundColor = [UIColor colorWithRed:159.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0];
                _view1.layer.borderColor = [UIColor redColor].CGColor;
         _timerLable.textColor=[UIColor whiteColor];

                
                
                
            }
                
            else{
                
                _prepareLabel.text=@"ROUND";
                _view1.layer.borderColor=[UIColor yellowColor].CGColor;
                _view1.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:216.0f/255.0f blue:0.0f/255.0f alpha:1.0];
           _timerLable.textColor=[UIColor blackColor];

                
            }
            if(stationChange ==1){
                
                
            }
            
            
            timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
            [self timerFired];
            flag=1;
        }
      if( currMinute==0 && currSeconds <30 && stationChange ==0){
            [self onDelegate2];
          _prepareLabel.text=@"30 SECOND WARNING";
        }else if(stationChange ==1){
           // [self onDelegate3];
            [self onDelegate1];
            _prepareLabel.text=@"STATION CHANGE";
        }else{
            
             [self onDelegate1];
            _prepareLabel.text=@"ROUND";
        }
        
        [_pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    }
    
    
   
    
}

-(void)timerFired
{

    
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        
        
        if(currMinute==3 && currSeconds==0){
            
            [self onDelegate1];
            YourSound=@"Round_Start_Bell.mp3";
            [self.audioplayer play];
        }
        
        if(currMinute==0 && currSeconds==30){
          
            if(stationChange ==1){
            
            
            }else{
       //     _view1.backgroundColor=[UIColor redColor];
            _prepareLabel.text=@"30 SECOND WARNING";
         //   _view1.layer.borderColor = [UIColor redColor].CGColor;
                
                _view1.layer.borderColor=[UIColor yellowColor].CGColor;
                _view1.backgroundColor = [UIColor colorWithRed:248.0f/255.0f green:216.0f/255.0f blue:0.0f/255.0f alpha:1.0];
                _timerLable.textColor=[UIColor blackColor];
            YourSound=@"30_Second_Warning.mp3";
                [self.audioplayer play];
                  [self onDelegate2];
            }
        }
        
        if(currMinute==0 && currSeconds==1){
           
            if(stationChange ==1 ){
                stationChange=0;
                _prepareLabel.text=@"ROUND";
                _view1.layer.borderColor=[UIColor greenColor].CGColor;
                _view1.backgroundColor = [UIColor colorWithRed:9.0f/255.0f green:151.0f/255.0f blue:29.0f/255.0f alpha:1.0];
                _timerLable.textColor=[UIColor whiteColor];
                currMinute=3;
                currSeconds=2;
                [_timerLable setText:@"03:00"];
                [self timerFired];
                
            }
            
            else{
                // Changes made
                YourSound =@"Round_Start_Bell.mp3";
                [self.audioplayer play];
                
                [_audioPlayer1 play];
                stationChange=1;
                
            _prepareLabel.text=@"STATION CHANGE";
               // [self onDelegate3];
                [self onDelegate1];
                 _view1.layer.backgroundColor = [UIColor colorWithRed:159.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0].CGColor;
                _view1.layer.borderColor = [UIColor redColor].CGColor;
                _timerLable.textColor=[UIColor whiteColor];
          currMinute=0;
            currSeconds=32;
            [_timerLable setText:@"00:30"];
            [self timerFired];
            }
            
            
            
            
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
            [_timerLable setText:[NSString stringWithFormat:@"%02d:%02d",currMinute,currSeconds]];
        
    }
    else
    {
        [timer invalidate];
        
    }
}


- (AVAudioPlayer *)audioplayer {
   
        NSURL *audioURL = [[NSBundle mainBundle] URLForResource:YourSound.stringByDeletingPathExtension withExtension:YourSound.pathExtension];
        NSData *audioData = [NSData dataWithContentsOfURL:audioURL];
        NSError *error = nil;
        // assing the audioplayer to a property so ARC won't release it immediately
        _audioplayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
        _audioplayer.delegate = self;
    
    return _audioplayer;
}
- (IBAction)backButton:(id)sender {
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)restartButton:(id)sender {
    
    if([_pauseButton.titleLabel.text isEqualToString:@"Start"]){
        stationChange=0;
        _prepareLabel.text=@"ROUND";
        currMinute=3;
        currSeconds=0;
        [_timerLable setText:@"03:00"];
        _view1.backgroundColor=[UIColor blackColor];
        _view1.layer.borderColor=[UIColor whiteColor].CGColor;
        _timerLable.textColor=[UIColor whiteColor];
        [timer invalidate];
        
        
    }else {
    
    
      [_pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    stationChange=0;
    _prepareLabel.text=@"ROUND";
        _view1.layer.borderColor=[UIColor greenColor].CGColor;
        _view1.backgroundColor = [UIColor colorWithRed:9.0f/255.0f green:151.0f/255.0f blue:29.0f/255.0f alpha:1.0];
        _timerLable.textColor=[UIColor whiteColor];
    currMinute=3;
    currSeconds=1;
    [_timerLable setText:@"03:00"];
    [self timerFired];
  

    }
    
    
    
   
}





-(void)offDelegate{
    
    //  [self.randomLightsButton setEnabled:NO];
    
    
    NSLog(@"////////////////////////////////LIGHT OFF ///////////////////////////////");
    
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        [lightState setOn:[NSNumber numberWithBool:false]];
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
            //   [self.randomLightsButton setEnabled:YES];
        }];
    }
    
    
    
    
}


///blue light
-(void)nDelegate4{
    
    //  [self.randomLightsButton setEnabled:NO];
    
    
    NSLog(@"////////////////////////////////LIGHT blue ///////////////////////////////");
    
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        [lightState setOn:[NSNumber numberWithBool:true]];
        [lightState setHue:[NSNumber numberWithInt:43364]];
        [lightState setBrightness:[NSNumber numberWithInt:104]];
        [lightState setSaturation:[NSNumber numberWithInt:251]];
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
            //   [self.randomLightsButton setEnabled:YES];
        }];
    }
    
    
    
    
}



    //ON  LIGHT

-(void)onDelegate1{
      NSLog(@" ////////////////////////white light");
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        [lightState setOn:[NSNumber numberWithBool:true]];
        [lightState setHue:[NSNumber numberWithInt:43500]];
        [lightState setBrightness:[NSNumber numberWithInt:200]];
        [lightState setSaturation:[NSNumber numberWithInt:15]];
        
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
            //   [self.randomLightsButton setEnabled:YES];
        }];
    }
}


    //light 2

-(void)onDelegate2{
    
    
    NSLog(@" ////////////////////////red light");
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
           [lightState setOn:[NSNumber numberWithBool:true]];
        [lightState setHue:[NSNumber numberWithInt:65535]];
        [lightState setBrightness:[NSNumber numberWithInt:100]];
        [lightState setSaturation:[NSNumber numberWithInt:254]];
        
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
            //   [self.randomLightsButton setEnabled:YES];
        }];
    }
}

    //light 3

-(void)onDelegate3{
    
    
    
     NSLog(@" ////////////////////////green light");
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        [lightState setOn:[NSNumber numberWithBool:true]];
        [lightState setHue:[NSNumber numberWithInt:24308]];
        [lightState setBrightness:[NSNumber numberWithInt:115]];
        [lightState setSaturation:[NSNumber numberWithInt:254]];
        
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
            //   [self.randomLightsButton setEnabled:YES];
        }];
    }
}

//on delegate
-(void)onDelegate{
    
    
    
    NSLog(@" ////////////////////////light on by default color");
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    PHBridgeSendAPI *bridgeSendAPI = [[PHBridgeSendAPI alloc] init];
    
    for (PHLight *light in cache.lights.allValues) {
        
        PHLightState *lightState = [[PHLightState alloc] init];
        [lightState setOn:[NSNumber numberWithBool:true]];
        
        // Send lightstate to light
        [bridgeSendAPI updateLightStateForId:light.identifier withLightState:lightState completionHandler:^(NSArray *errors) {
            if (errors != nil) {
                NSString *message = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Errors", @""), errors != nil ? errors : NSLocalizedString(@"none", @"")];
                
                NSLog(@"Response: %@",message);
            }
            
            //   [self.randomLightsButton setEnabled:YES];
        }];
    }
}
- (void)dealloc
{
    // Clean up; make sure to add this
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


    //


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
