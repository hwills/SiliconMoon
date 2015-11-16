//
//  ProjectMessageViewController.m
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import "ProjectMessageViewController.h"

@implementation ProjectMessageViewController

-(id) init
{
    self= [super init];
    self.title= @"Messages";
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
            break;

        case 2:
            break;

        default:
            break;
    }
}

@end
