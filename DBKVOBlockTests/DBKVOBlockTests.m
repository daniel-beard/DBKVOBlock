//
//  DBKVOBlockTests.m
//  DBKVOBlockTests
//
//  Created by Daniel Beard on 5/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import "DBKVOBlock.h"
#import "DBDummyTestClass.h"
#import <SenTestingKit/SenTestingKit.h>

@interface DBKVOBlockTests : SenTestCase

@end

@implementation DBKVOBlockTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void)testSimpleKVOExample {
    
    DBDummyTestClass *testClass = [[DBDummyTestClass alloc] init];
    
    __block BOOL result = NO;
    [[DBKVOBlock sharedManager] observeObject:testClass withKeyPath:@"testString" withAction:^{
        result = YES;
    }];
    
    testClass.testString = @"This is a test string";
    STAssertTrue(result == YES, @"Result should be YES");
}

@end
