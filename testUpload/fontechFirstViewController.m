//
//  fontechFirstViewController.m
//  testUpload
//
//  Created by Robert Huang on 10/25/13.
//  Copyright (c) 2013 Robert Huang. All rights reserved.
//

#import "fontechFirstViewController.h"

@interface fontechFirstViewController ()

@end

@implementation fontechFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSData *data = [CommunicateWithInternet getJsonDataFromUrl:@"http://testjson.herokuapp.com/posts.json?auth_token=-xeG-o8xcyTJd9bz-Gwf" WithPostParams:[NSDictionary dictionaryWithObjectsAndKeys:@"name",@"hello",@"description", @"MynameisRobert",nil]];
    
    
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSLog(@"%@", json);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
