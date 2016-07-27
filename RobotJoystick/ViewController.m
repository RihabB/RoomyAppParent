//
//  ViewController.m
//  RobotJoystick
//
//  Created by ljlin on 14-9-5.
//  Copyright (c) 2014年 ljlin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver: self
                           selector: @selector (onStickChanged:)
                               name: @"StickChanged"
                             object: nil];
    //[self startExamine];
}
- (NSArray*)ButtonList
{
    if (!_ButtonList) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ButtonOrder" ofType:@"plist"];
        _ButtonList = [[NSArray alloc]initWithContentsOfFile:plistPath];
    }
    return _ButtonList;
}
- (void)startExamine
{
    self.motionManager = [[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval = 0.01;
    if ([self.motionManager isAccelerometerAvailable]){
        NSLog(@"Accelerometer is available.");
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        CMAccelerometerHandler handler = ^(CMAccelerometerData *accelerometerData, NSError *error){
            float dx = accelerometerData.acceleration.x,
                  dy = accelerometerData.acceleration.y,
                  dz = accelerometerData.acceleration.z;
            NSLog(@"x:%g y:%g z:%g",dx,dy,dz);
            self.textView.text = [NSString stringWithFormat:@"x:%g y:%g z:%g",dx,dy,dz];
        };
        [self.motionManager startAccelerometerUpdatesToQueue: queue
                                                 withHandler: handler];
    }
}



- (void)onStickChanged:(id)notification
{
    NSDictionary *dict = [notification userInfo];
    NSValue *vdir = [dict valueForKey:@"dir"];
    CGPoint dir = [vdir CGPointValue];
    NSLog(@"%g %g",dir.x,dir.y);
    _x.text =[NSString stringWithFormat:@"%f",dir.x];
    _y.text =[NSString stringWithFormat:@"%f",dir.y];
    if ((dir.x>0)&&(dir.y>0))
    {_direction.text=@"Down";}
    else if ((dir.x<0)&&(dir.y>0))
    {_direction.text=@"Left";}
    else if ((dir.x<0)&&(dir.y<0))
    {_direction.text=@"up";}
    else
    {_direction.text=@"Right";}
}

- (IBAction)buttonTouchEnd:(UIButton*)sender forEvent:(UIEvent *)event
{
    
}

- (IBAction)buttonClick:(UIButton*)sender
{
    if (sender.tag==3) {
        if (self.connected==0){
            self.connected = 1;
        }
        else{
            //
            self.connected = 0;
        }
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
