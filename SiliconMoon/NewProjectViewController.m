//
//  NewProjectViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 12/1/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "NewProjectViewController.h"

@implementation NewProjectViewController

-(id) initWithUserId:(NSInteger)userId
{
    self= [super init];
    self.userId = userId;
    [self addTextField:@"Project Name" :CGRectMake(100, 100, 200, 30)];
    [self addTextField:@"Project Description" :CGRectMake(100, 150, 200, 300)];
    
    // register button has tag 2
    [self addButton:@"Create!" :CGRectMake(100, 550, 200, 50) :2];
    
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
    
    if ([inputLabel  isEqual: @"Project Name"]) {
        // This allocates the textfield and sets its frame
        UITextField *textField = [[UITextField  alloc] initWithFrame:textFrame];
        
        // This sets the border style of the text field
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [textField setFont:[UIFont boldSystemFontOfSize:12]];
        
        //Placeholder text is displayed when no text is typed
        textField.placeholder = inputLabel;
        self.name = textField;
        textField.contentVerticalAlignment =
        UIControlContentVerticalAlignmentCenter;
        // Adds the textField to the view.
        [self.view addSubview:textField];
    }
    else if ([inputLabel  isEqual: @"Project Description"]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:textFrame];
        [textView setFont:[UIFont boldSystemFontOfSize:12]];
        self.desc = textView;
        [textView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
        [textView.layer setBorderColor: [[UIColor grayColor] CGColor]];
        [textView.layer setBorderWidth: 1.0];
        [textView.layer setCornerRadius:8.0f];
        [textView.layer setMasksToBounds:YES];
        textView.text = inputLabel;
        [self.view addSubview:textView];
    }
}

- (void)buttonClicked: (UIButton*) sender
{
    switch (sender.tag) {
        case 1:
            NSLog(@"Clicked to get back to login");
            // get back to login view controller here
            break;
        case 2:{
            NSLog(@"Clicked on register");
            // need to create user here
            NSString *post = [NSString stringWithFormat:@"userid=%ld&name=%@&desc=%@", (long)self.userId, self.name.text, self.desc.text];
            NSLog(@"Post query: %@", post);
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/createProject.php"]];
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:jsonFileUrl];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setHTTPBody:postData];
            [NSURLConnection connectionWithRequest:urlRequest delegate:self];
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
        NSLog(@"%@", JSON[@"message"]);
        UIAlertView * failedCreationAlert = [[UIAlertView alloc] initWithTitle:@"Creation Failed" message:@"We appologize, but your project could not be created." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Understood", nil];
        [failedCreationAlert show];
        return;
    }
    UIAlertView * successAlert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your project has been created!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Thanks!", nil];
    [successAlert show];
}

@end
