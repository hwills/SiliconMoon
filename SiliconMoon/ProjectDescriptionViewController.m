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

-(id) initWithProjectNameAndDescription: (NSString *) name projectDesctiption: (NSString *) desc;
{
    self= [super init];
    self.title= @"Messages";
    
    // populate information from database
    self.isRequested= true;
    self.projectName= name;
    self.projectDescription= desc;
    
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
        case 1:
            NSLog(@"Clicked on Accept");
            break;
            
        case 2:
            NSLog(@"Clicked on Deny");
            break;
            
        default:
            break;
    }
}

@end
