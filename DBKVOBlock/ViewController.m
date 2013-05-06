//
//  ViewController.m
//  DBKVOBlock
//
//  Created by Daniel Beard on 3/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import "ViewController.h"
#import "DBKVOBlock.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *testString;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[DBKVOBlock sharedManager] observeObject:self withKeyPath:@"testString" withAction:^{
        NSLog(@"self.textField.text: %@", self.testString);
    }];
    
    self.testString = @"123 test";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
