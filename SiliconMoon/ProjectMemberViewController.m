//
//  ProjectMemberViewController.m
//  
//
//  Created by Alex Tran on 11/15/15.
//
//

#import "ProjectMemberViewController.h"

@implementation ProjectMemberViewController
@synthesize members;

-(id) init
{
    self= [super init];
    members = [[NSMutableArray alloc]initWithObjects:
                  @"Data 1 in array",@"Data 2 in array",@"Data 3 in array",
                  @"Data 4 in array",@"Data 5 in array",@"Data 5 in array",
                  @"Data 6 in array",@"Data 7 in array",@"Data 8 in array",
                  @"Data 9 in array", nil];
    [self setTitle:@"Developers"];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 400, 400)
                                                      style:UITableViewStylePlain];
    
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    table.delegate = self;
    table.dataSource = self;
    [table reloadData];
    
    [self.view addSubview: table];
    [self setTitle:@"Members"];
    return self;
}

- (void)buttonClicked: (UIButton*) sender
{
    switch (sender.tag) {
        case 1:
            NSLog(@"Clicked on become developer");
            break;
        default:
            break;
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    // Configure the cell...
    cell.textLabel.text = [members objectAtIndex:indexPath.row];
    return cell;
}

@end
