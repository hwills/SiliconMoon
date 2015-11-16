//
//  RegistrationViewController.h
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController

@property (nonatomic, retain) NSMutableData *webResopnse;
@property (nonatomic, retain) UITextField *username;
@property (nonatomic, retain) UITextField *imageUrl;
@property (nonatomic, retain) UITextField *desc;
@property (nonatomic, retain) UITextField *password;

@end
