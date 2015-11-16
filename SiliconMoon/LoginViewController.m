//
//  LoginViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import "RegistrationViewController.h"

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
    
    if ([inputLabel  isEqual: @"Username"]) {
        self.username = textField;
    }
    else {
        self.password = textField;
    }
    
    // Adds the textField to the view.
    [self.view addSubview:textField];
}


- (void)buttonClicked: (UIButton*) sender
{
    switch (sender.tag) {
        case 1: {
            NSLog(@"Clicked on login");
            // need to check login information here
            UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:nil action:nil];
            
            self.navigationItem.backBarButtonItem = logout;
            NSString *post = [NSString stringWithFormat:@"user=%@&pass=%@",self.username.text,self.password.text];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/getUser.php"]];
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:jsonFileUrl];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setHTTPBody:postData];
            [NSURLConnection connectionWithRequest:urlRequest delegate:self];
            break;}
        case 2:{
            NSLog(@"Clicked on register");
            // get to register view controller here
            UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
            
            self.navigationItem.backBarButtonItem = back;
            UIViewController *vc = [[RegistrationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;}
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.webResopnse = [[NSMutableData alloc] init];
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [self.webResopnse appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *responseString = [[NSString alloc] initWithData:self.webResopnse encoding:NSUTF8StringEncoding];
    NSError *e = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"%@", JSON[@"success"]);
    if ([JSON[@"success"] isEqual: @"false"]) {
        UIAlertView * noSuchUserAlert = [[UIAlertView alloc] initWithTitle:@"User does not exist" message:@"This username password combination did not match our records please try again or register with a new account." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Understood", nil];
        [noSuchUserAlert show];
        return;
    }
    UIViewController *vc = [[WelcomeViewController alloc] initWithUserId:[((NSString*)JSON[@"id"]) integerValue]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
