//
//  TutorialViewController.m
//  GymApp2
//
//  Created by Clairvoyant on 01/03/17.
//  Copyright © 2017 Clairvoyant. All rights reserved.
//

#import "TutorialViewController.h"
#import "StartViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <HueSDK_iOS/HueSDK.h>


@interface TutorialViewController ()<UIGestureRecognizerDelegate,UIPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation TutorialViewController{
     NSDictionary *colorDictionary;
    int onOff;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //setting Buttong
    //on off light
    PHNotificationManager *notificationManager = [PHNotificationManager defaultManager];
    // Register for the local heartbeat notifications
    [notificationManager registerObject:self withSelector:@selector(localConnection) forNotification:LOCAL_CONNECTION_NOTIFICATION];
    [notificationManager registerObject:self withSelector:@selector(noLocalConnection) forNotification:NO_LOCAL_CONNECTION_NOTIFICATION];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Find bridge" style:UIBarButtonItemStylePlain target:self action:@selector(findNewBridgeButtonAction)];
    
    [self noLocalConnection];
    

    
    onOff=0;
    [self.navigationController.navigationBar setHidden:YES];
   
    
    //connect button
    [[_connectButton layer] setBorderWidth:1.3f];
    [[_connectButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[_connectButton layer] setCornerRadius:8.0f];
    
    
    //start button
    
    [[_startButton layer] setBorderWidth:1.3f];
    [[_startButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[_startButton layer] setCornerRadius:8.0f];



    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabel:) name:@"UpdateLabel" object:nil];
    
    //color dictionary by default
    
    
   
    // Do any additional setup after loading the view.
}


- (void)localConnection{
    
    [self loadConnectedBridgeValues];
    
}
- (IBAction)startButton:(id)sender {
    
    UIStoryboard *story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    StartViewController *start=[story instantiateViewControllerWithIdentifier:@"StartViewController"];
    StartViewController *y=(StartViewController *)start;
    y.lightColor=[NSNumber numberWithInt:onOff];
    [self.navigationController pushViewController:start animated:YES];
}

- (void)noLocalConnection{
   
}
- (void)loadConnectedBridgeValues{
    PHBridgeResourcesCache *cache = [PHBridgeResourcesReader readBridgeResourcesCache];
    
    // Check if we have connected to a bridge before
    if (cache != nil && cache.bridgeConfiguration != nil && cache.bridgeConfiguration.ipaddress != nil){
        
        // Set the ip address of the bridge
       // self.bridgeIpLabel.text = cache.bridgeConfiguration.ipaddress;
        
        // Set the identifier of the bridge
       // self.bridgeIdLabel.text = cache.bridgeConfiguration.bridgeId;
        
        // Check if we are connected to the bridge right now
        if (UIAppDelegate.phHueSDK.localConnected) {
            
            // Show current time as last successful heartbeat time when we are connected to a bridge
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterNoStyle];
            [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
            
         //   self.bridgeLastHeartbeatLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
            
          //  [self.randomLightsButton setEnabled:YES];
        } else {
          //  self.bridgeLastHeartbeatLabel.text = @"Waiting...";
          //  [self.randomLightsButton setEnabled:NO];
        }
    }
}



- (IBAction)connectButton:(id)sender {
    
    
    switch (onOff) {
        case 0:
            onOff=1;
            [_connectButton setTitle:@"Lights OFF" forState:UIControlStateNormal];
            [self onDelegate];
            break;
        case 1:
            onOff=0;
              [_connectButton setTitle:@"Lights ON" forState:UIControlStateNormal];
            [self offDelegate];
        default:
            break;
    }
    
    
}

-(void)offDelegate{
    
  //  [self.randomLightsButton setEnabled:NO];
    
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
-(void)onDelegate{
    
    NSLog(@"white lightt //////////////////////////////");
    
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

-(void)viewWillAppear:(BOOL)animated{
    
    if(onOff ==1){
        
        [self onDelegate];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    
    NSLog(@"the color Dictionary is %@",colorDictionary);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
