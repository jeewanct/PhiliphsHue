//
//  Setting.m
//  GymApp2
//
//  Created by JEEVAN TIWARI on 05/03/17.
//  Copyright © 2017 Clairvoyant. All rights reserved.
//

#import "Setting.h"
#import "VBColorPicker.h"
@interface Setting ()
@property (weak, nonatomic) IBOutlet UIView *colorLabel1;
@property (weak, nonatomic) IBOutlet UIView *colorLabel2;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *colorLabel3;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *color1Button;
@property (weak, nonatomic) IBOutlet UIButton *color2Button;
@property (weak, nonatomic) IBOutlet UIButton *color3Button;

@end

@implementation Setting{
    UIColor *color1;
    UIColor *color2;
    UIColor *color3;
    NSDictionary *dict;
}
@synthesize cPicker=_cPicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    color1=[UIColor whiteColor];
    color2=[UIColor redColor];
    color3=[UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:YES];
    [[_saveButton layer] setBorderWidth:1.3f];
    [[_saveButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[_saveButton layer] setCornerRadius:8.0f];
    
    //connect button
    [[_backButton layer] setBorderWidth:1.3f];
    [[_backButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[_backButton layer] setCornerRadius:8.0f];
    
    
    //start button
   
    color1=[UIColor whiteColor];
    color2=[UIColor redColor];
    color3=[UIColor whiteColor];
    
    
    // Do any additional setup after loading the view.
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
- (IBAction)color3Button:(id)sender {
    _color3Button.tag=3;
    if (self.cPicker == nil) {
        
        self.cPicker = [[VBColorPicker alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [_cPicker setCenter:self.view.center];
        [self.view addSubview:_cPicker];
        [_cPicker setDelegate:self];
        [_cPicker showPicker];
        
        // set default YES!
        [_cPicker setHideAfterSelection:NO];
    }
    
    
    
    
    else if([self.cPicker isHidden]){
        [_cPicker showPicker];
    }
    
    
}
- (IBAction)color2Button:(id)sender {
    _color2Button.tag=2;
    if (self.cPicker == nil) {
      
        self.cPicker = [[VBColorPicker alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [_cPicker setCenter:self.view.center];
        [self.view addSubview:_cPicker];
        [_cPicker setDelegate:self];
        [_cPicker showPicker];
        
        // set default YES!
        [_cPicker setHideAfterSelection:NO];
    }
    
    
    
    
    else if([self.cPicker isHidden]){
        [_cPicker showPicker];
    }
}
- (IBAction)color1Button:(id)sender {
    _color1Button.tag=1;
    if (self.cPicker == nil) {

        self.cPicker = [[VBColorPicker alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [_cPicker setCenter:self.view.center];
        [self.view addSubview:_cPicker];
        [_cPicker setDelegate:self];
        [_cPicker showPicker];
        
        // set default YES!
        [_cPicker setHideAfterSelection:NO];
    }
    else if([self.cPicker isHidden]){
        [_cPicker showPicker];
    }
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)saveButton:(id)sender {
    
    dict=@{@"color1":color1,@"color2":color2,@"color3":color3};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLabel" object:dict] ;
     [self.navigationController popViewControllerAnimated:YES];
}


- (void) pickedColor:(UIColor *)color {
    
    if(_color1Button.tag ==1){
        _color1Button.tag=0;
        [_colorLabel1 setBackgroundColor:color];
        color1 =color;
    }
    
    
   else if(_color2Button.tag==2){
        _color2Button.tag=0;
        [_colorLabel2 setBackgroundColor:color];
        color2=color;
        // color1 =color;
        
    }
   else  if(_color3Button.tag==3){
        _color3Button.tag=0;
        [_colorLabel3 setBackgroundColor:color];
        color3=color;
        // color1 =color;
        
    }
    
    NSLog(@"color 1=%@,color 1=%@,color 1=%@",color1,color2,color3);
    
    
    [_cPicker hidePicker];
    
}

//notification center
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // NSString *updateLabelString = @"Your Text Here";
    // Posting the notification back to our sending view controller with the updateLabelString being the posted object
    
   
    
    
    
    
}



@end
