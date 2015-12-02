//
//  ProjectDescriptionViewController.m
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import "ProjectDescriptionViewController.h"

@implementation ProjectDescriptionViewController
@synthesize isRequested;
@synthesize projectName, projectDescription;

-(id) initWithProjectNameDescriptionRequestIdAndUserId: (NSString *) name projectDesctiption: (NSString *) desc projectRequest: (NSInteger) req projectId: (NSInteger) pid userId: (NSInteger) uid
{
    self= [super init];
    self.title= @"Messages";
    
    // populate information from database
    self.isRequested= (req==1);
    self.projectName= name;
    self.projectDescription= desc;
    self.projectId = pid;
    self.userId = uid;
    
    [self addLabel:self.projectName :CGRectMake(140, 50, 200, 50)];
    [self addLabel:self.projectDescription :CGRectMake(30, 100, 200, 50)];
    
    if (self.isRequested) {
        [self addLabel:@"You have been requested to collaborate in this project" :CGRectMake(30, 200, 300, 50)];
        
        //Accept has tag= 1
        [self addButton:@"Accept" :CGRectMake(30, 250, 100, 50) :1];
        
        //Deny has tag= 2
        [self addButton:@"Deny" :CGRectMake(160, 250, 100, 50) :1];
    }
    
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

-(void)addLabel: (NSString *)labelText : (CGRect)labelFrame {
    UILabel *label= [[UILabel alloc]init];
    label.frame= labelFrame;
    label.text= labelText;
    [self.view addSubview:label];
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
        case 1:{
            NSLog(@"Clicked on Accept");
            NSString *post = [NSString stringWithFormat:@"userid=%ld&projectid=%ld",(long)self.userId,(long)self.projectId];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
            NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/acceptUser.php"]];
            NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
            [urlRequest setURL:jsonFileUrl];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [urlRequest setHTTPBody:postData];
            [NSURLConnection connectionWithRequest:urlRequest delegate:self];
            break;
        }
        case 2:
            NSLog(@"Clicked on Deny");
            break;
            
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
    NSLog(@"RESPONSE: %@", responseString);
    NSError *e = nil;
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"%@", JSON[@"ignore"]);
    if ([JSON[@"ignore"] isEqual: @"true"]) {
        UIAlertView * mentorAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"You are now a member of this project!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"YAY!", nil];
        [mentorAlert show];
        return;
    }
    if ([JSON[@"success"] isEqual: @"false"]) {
        UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We had an error. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Understood", nil];
        [errorAlert show];
        return;
    }
    
}

@end
