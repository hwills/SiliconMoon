//
//  BrowseProjectsViewController.m
//  SiliconMoon
//
//  Created by Hunter Wills on 11/15/15.
//  Copyright (c) 2015 Hunter Wills. All rights reserved.
//

#import "BrowseProjectsViewController.h"
#import "NewProjectViewController.h"
#import "ProjectDescriptionViewController.h"

@implementation BrowseProjectsViewController
@synthesize projects;
@synthesize descrics;

-(id) initWithUserId:(NSInteger) userId
{
    self= [super init];
    projects= [[NSMutableArray alloc]init];
    descrics= [[NSMutableArray alloc]init];
    [self setTitle:@"Projects"];
    self.userId = userId;
    NSString *post = [NSString stringWithFormat:@""];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSURL *jsonFileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", @"http://ec2-54-148-70-188.us-west-2.compute.amazonaws.com/~hwills/getProjects.php"]];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:jsonFileUrl];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    return self;
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
        UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error finding projects" message:@"We had an error finding projects. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Understood", nil];
        [errorAlert show];
        return;
    }
    NSArray *names = [JSON[@"name"] componentsSeparatedByString:@", "];
    NSArray *descs = [JSON[@"desc"] componentsSeparatedByString:@", "];
    NSLog(@"%@", descs);
    [projects addObjectsFromArray:names];
    [descrics addObjectsFromArray:descs];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 400, 400)
                                                      style:UITableViewStylePlain];
    
    table.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    table.delegate = self;
    table.dataSource = self;
    [table reloadData];
    
    [self addButton:@"New project" :CGRectMake(200, 50, 200, 50) :1];
    [self.view addSubview: table];
    
}

- (void)buttonClicked: (UIButton*) sender
{
    UIViewController *vc = [[NewProjectViewController alloc] initWithUserId:self.userId];
    [self.navigationController pushViewController:vc animated:YES];
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
    return [projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    // Configure the cell...
    cell.textLabel.text = [projects objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectDescriptionViewController *descriptionVC= [[ProjectDescriptionViewController alloc]initWithProjectNameDescriptionRequestIdAndUserId:[projects objectAtIndex:indexPath.row] projectDesctiption:[descrics objectAtIndex:indexPath.row] projectRequest:0 projectId:-1 userId:-1];
    [self.navigationController pushViewController:descriptionVC animated:YES];
}



@end