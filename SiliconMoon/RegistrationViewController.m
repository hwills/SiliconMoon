//
//  RegistrationViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "RegistrationViewController.h"
#import "LoginViewController.h"

@implementation RegistrationViewController
@synthesize client, midnightBlue, blazeOrange, niceGrey;

-(id) init
{
    self= [super init];
    midnightBlue= [UIColor colorWithRed:0 green:51.0f/255.0f blue:102.0f/255.0f alpha:1];
    blazeOrange= [UIColor colorWithRed:1 green:122.0f/255.0f blue:0 alpha:1];
    niceGrey= [UIColor colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:1];
    
    [self addTextField:@"Username" :CGRectMake(80, 200, 200, 30)];
    [self addTextField:@"Image Url" :CGRectMake(80, 250, 200, 30)];
    [self addTextField:@"Description" :CGRectMake(80, 300, 200, 30)];
    [self addTextField:@"Password" :CGRectMake(80, 350, 200, 30)];
    
    // register button has tag 2
    [self addButton:@"Register" :CGRectMake(80, 400, 200, 30) :2];
    [self addButton:@"Register with Linkedin" :CGRectMake(80, 450, 200, 30) :3];
    
    UILabel *label = [[UILabel alloc] init];
    
    [label setText:@"Silicon Moon"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Times" size:40]];
    [label setTextColor:[UIColor blackColor]];
    label.numberOfLines = 2;
    label.frame = CGRectMake(60, 100, 250, 100);
    label.textColor= niceGrey;
    [self.view addSubview:label];
    
    self.client= [self initialize_Client];
    
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
    
    // set button background color
    [button setBackgroundColor:blazeOrange];
    
    // set button text color
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
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
    else if ([inputLabel  isEqual: @"Image Url"]) {
        self.imageUrl = textField;
    }
    else if ([inputLabel  isEqual: @"Description"]) {
        self.desc = textField;
    }
    else if ([inputLabel  isEqual: @"Password"]) {
        self.password = textField;
    }
    
    // Adds the textField to the view.
    [self.view addSubview:textField];
}

- (void)buttonClicked: (UIButton*) sender
{
    switch (sender.tag) {
        case 1:
        {
            NSLog(@"Clicked to get back to login");
            // get back to login view controller here
            break;
        }
        case 2:
        {
            NSLog(@"Clicked on register");
            // need to create user here
            NSString *post = [NSString stringWithFormat:@"user=%@&url=%@&desc=%@&pass=%@",self.username.text, self.imageUrl.text, self.desc.text, self.password.text];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/registerUser.php"]];
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:jsonFileUrl];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setHTTPBody:postData];
            [NSURLConnection connectionWithRequest:urlRequest delegate:self];
            break;
        }
        case 3:{
            [self.client getAuthorizationCode:^(NSString *code) {
                [self.client getAccessToken:code success:^(NSDictionary *accessTokenData) {
                    NSString *accessToken = [accessTokenData objectForKey:@"access_token"];
                    [self requestMeWithToken:accessToken];
                }                   failure:^(NSError *error) {
                    NSLog(@"Quering accessToken failed %@", error);
                }];
            }                      cancel:^{
                NSLog(@"Authorization was cancelled by user");
            }                     failure:^(NSError *error) {
                NSLog(@"Authorization failed %@", error);
            }];
        }
        default:
            break;
    }
}

- (void)requestMeWithToken:(NSString *)accessToken {
    [self.client GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(summary,num-connections)?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
        NSLog(@"current user %@", result);
        NSString *post = [NSString stringWithFormat:@"user=%@&url=%@&desc=%@&pass=%@&sum=%@&con=%ld",self.username.text, self.imageUrl.text, self.desc.text, self.password.text, result[@"summary"], (long)[result[@"numConnections"] integerValue]];
        NSLog(@"Post Request %@", post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/registerUser.php"]];
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
        [urlRequest setURL:jsonFileUrl];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [urlRequest setHTTPBody:postData];
        [NSURLConnection connectionWithRequest:urlRequest delegate:self];
        
    }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to fetch current user %@", error);
    }];
}

- (LIALinkedInHttpClient *)initialize_Client {
    NSString *LINKEDIN_CLIENT_ID= @"772t0igruo1tig";
    NSString *LINKEDIN_CLIENT_SECRET= @"lWNHomkHd19RaVFE";
    LIALinkedInApplication *application = [LIALinkedInApplication applicationWithRedirectURL:@"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/"
                                                                                    clientId:LINKEDIN_CLIENT_ID
                                                                                clientSecret:LINKEDIN_CLIENT_SECRET
                                                                                       state:@"DCEEFWF45453sdffef424"
                                                                               grantedAccess:@[@"r_basicprofile"]];
    return [LIALinkedInHttpClient clientForApplication:application presentingViewController:nil];
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
        UIAlertView * failedRegistrationAlert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"We appologize, but your registration did not succeed." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Understood", nil];
        [failedRegistrationAlert show];
        return;
    }
    UIAlertView * successAlert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You have been registered!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Thanks!", nil];
    [successAlert show];
}


@end
