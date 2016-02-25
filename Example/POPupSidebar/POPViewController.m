//
//  POPViewController.m
//  POPupSidebar
//
//  Created by popeveryday on 02/25/2016.
//  Copyright (c) 2016 popeveryday. All rights reserved.
//

#import "POPViewController.h"
#import <POPupSidebar/POPupSidebar.h>

@interface POPViewController ()

@end

@implementation POPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [POPupSidebarVC addSidebarWithViewController:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
