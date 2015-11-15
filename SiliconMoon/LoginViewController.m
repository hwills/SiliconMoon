//
//  LoginViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

-(id)init
{
    self= [super init];
    [self addTextField:@"Username" :CGRectMake(100, 300, 200, 30)];
    [self addTextField:@"Password" :CGRectMake(100, 350, 200, 30)];
    
    // login button has tag 1
    [self addButton:@"Login" :CGRectMake(100, 400, 200, 50) :1];
    
    // register button has tag 2
    [self addButton:@"Register" :CGRectMake(100, 450, 200, 50) :2];
    
    return self;
}

-(void)addButton: (NSString*)buttonLabel : (CGRect)buttonFrame :(int)buttonTag{
    // This creates a round button and set its frame
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame= buttonFrame;
    
    // This sets the title of the button
    [button setTitle:buttonLabel forState:UIControlStateNormal];
    
    // This sets the tag of the button
    button.tag= buttonTag;
    
    // This add a listener to the button handled in buttonClicked function
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:button];
}

-(void)addTextField: (NSString*)inputLabel :(CGRect)textFrame {
    // This allocates the textfield and sets its frame
    UITextField *textField = [[UITextField  alloc] initWithFrame:textFrame];
    
    // This sets the border style of the text field
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment =
    UIControlContentVerticalAlignmentCenter;
    [textField setFont:[UIFont boldSystemFontOfSize:12]];
    
    //Placeholder text is displayed when no text is typed
    textField.placeholder = inputLabel;
    
    // Adds the textField to the view.
    [self.view addSubview:textField];
}


- (void)buttonClicked: (UIButton*) sender
{
    switch (sender.tag) {
        case 1:
            NSLog(@"Clicked on login");
            // need to check login information here
//            NSURL *jsonFileUrl = [NSURL URLWithString:@"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/getUser.php?user=demoUser1"];
//            NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
//            [NSURLConnection connectionWithRequest:urlRequest delegate:self];
            break;
        case 2:
            NSLog(@"Clicked on register");
            // get to register view controller here
            break;
        default:
            break;
    }
}

@end
