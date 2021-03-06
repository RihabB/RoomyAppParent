//
//  ViewController.h
//  RobotJoystick
//
//  Created by ljlin on 14-9-5.
//  Copyright (c) 2014年 ljlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>


@interface ViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *HostTxtField;
@property (weak, nonatomic) IBOutlet UITextField *PortTxtField;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (nonatomic) BOOL connected;
@property (strong, nonatomic) NSArray *ButtonList;

@property (weak, nonatomic) IBOutlet UILabel *x;
@property (weak, nonatomic) IBOutlet UILabel *y;
@property (weak, nonatomic) IBOutlet UILabel *direction;


@end
