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

@property (nonatomic, strong) DBKVOBlock *blockManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.blockManager = [[DBKVOBlock alloc] init];
    
    [self.blockManager observeObject:self.textField withKeyPath:@"text" withAction:^{
        NSLog(@"self.textField.text: %@", self.textField.text);
    }];
    
    self.textField.text = @"Test";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
