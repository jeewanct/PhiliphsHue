//
//  ViewController.m
//  demo
//
//  Created by JEEVAN TIWARI on 08/03/17.
//  Copyright © 2017 JEEVAN TIWARI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *lightOnStatus;

@property (weak, nonatomic) IBOutlet UILabel *lightOffStatus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
 

}

- (IBAction)userRegister:(id)sender {
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSDictionary *dictionary =  @{@"devicetype":@"my_hue_app#iphone peter"};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                    
                                                   options:0
                    
                                                     error:nil];
    
    NSLog(@"self.dictParameters Fill %@",dictionary);
    NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    strData = [NSString stringWithFormat:@"%@",strData];
    NSLog(@"Login Request Fill %@",strData);
    
    NSData *dataa = [strData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Dtata is:%@",dataa);
    
    
    NSURL *url_request = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://192.168.5.213/api"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_request
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    
    
    // HEADER...STARTS HERE .
    [request setHTTPMethod:@"POST"];
    
    
    [request setHTTPBody:dataa];
    ///// HEADER ENDS HERE .
    NSLog(@"Request body Fill %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    NSLog(@"Request Header %@", [request allHTTPHeaderFields]);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse * response, NSError * error) {
        NSLog(@"data Fill=%@",error);
        if (error == nil) {  // success....
            
            NSError *jsonError;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&jsonError];
            
            
            // get object after successful retrieving data !!!!
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSLog(@"the ressponse of bridge is %@",response);
                
                _userName.text=[NSString stringWithFormat:@"%@",response];
                
                
            });
            
        }else {
            // fail....
            NSLog(@"Error: %@",error);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"No connection" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //No network connectivity - This App requires an internet connection. Please enable the same to proceed
                
                
            });
        }
    }];
    
    [postDataTask resume];
    
}
- (IBAction)onLight:(id)sender {
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSDictionary *dictionary =  @{@"on":@"true", @"sat":@"254", @"bri":@"254",@"hue":@"10000"};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                    
                                                   options:0
                    
                                                     error:nil];
    
    NSLog(@"self.dictParameters Fill %@",dictionary);
    NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    strData = [NSString stringWithFormat:@"%@",strData];
    NSLog(@"Login Request Fill %@",strData);
    
    NSData *dataa = [strData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Dtata is:%@",dataa);
    
    
    NSURL *url_request = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://192.168.5.213/api/Rk3zQZERPrrVG6NRLfsKZKVw3NoqpuTP3k7F23tj/lights/1/state"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_request
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    
    
    // HEADER...STARTS HERE .
    [request setHTTPMethod:@"PUT"];
    
    
    [request setHTTPBody:dataa];
    ///// HEADER ENDS HERE .
    NSLog(@"Request body Fill %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    NSLog(@"Request Header %@", [request allHTTPHeaderFields]);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse * response, NSError * error) {
        NSLog(@"data Fill=%@",error);
        if (error == nil) {  // success....
            
            NSError *jsonError;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&jsonError];
            
            
            // get object after successful retrieving data !!!!
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                _lightOnStatus.text=[NSString stringWithFormat:@"%@",response];
                
                
                
            });
            
        }else {
            // fail....
            NSLog(@"Error: %@",error);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"No connection" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //No network connectivity - This App requires an internet connection. Please enable the same to proceed
                
                
            });
        }
    }];
    
    [postDataTask resume];
}
- (IBAction)offLight:(id)sender {
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSDictionary *dictionary = @{ ""on"":false}"
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                    
                                                   options:0
                    
                                                     error:nil];
    
    NSLog(@"self.dictParameters Fill %@",dictionary);
    NSString *strData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    strData = [NSString stringWithFormat:@"data=%@",strData];
    NSLog(@"Login Request Fill %@",strData);
    
    NSData *dataa = [strData dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"Dtata is:%@",dataa);
    
    
    NSURL *url_request = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"http://192.168.5.213/api/Kv1BSA-USDPjbfi3fOjatuYDVmGnXw6ovu24zv7J/lights/1/state"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_request
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    
    
    // HEADER...STARTS HERE .
    [request setHTTPMethod:@"PUT"];
    
    
    [request setHTTPBody:dataa];
    ///// HEADER ENDS HERE .
    NSLog(@"Request body Fill %@", [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding]);
    NSLog(@"Request Header %@", [request allHTTPHeaderFields]);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *  data, NSURLResponse * response, NSError * error) {
        NSLog(@"data Fill=%@",error);
        if (error == nil) {  // success....
            
            NSError *jsonError;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:&jsonError];
            
            
            // get object after successful retrieving data !!!!
            dispatch_async(dispatch_get_main_queue(), ^{
                
            
                
                
                NSLog(@"off state is =%@",response);
                _lightOffStatus.text=[NSString stringWithFormat:@"%@",response];
                
                
                
            });
            
        }else {
            // fail....
            NSLog(@"Error: %@",error);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"No connection" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //No network connectivity - This App requires an internet connection. Please enable the same to proceed
                
                
            });
        }
    }];
    
    [postDataTask resume];
}






-(void)registerUser{
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
