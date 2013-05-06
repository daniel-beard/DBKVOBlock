//
//  DBKVOBlockTests.m
//  DBKVOBlockTests
//
//  Created by Daniel Beard on 6/05/13.
//  Copyright (c) 2013 Daniel Beard. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "DBKVODummyClass.h"
#import "DBKVOBlock.h"

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
    
    [[DBKVOBlock sharedManager] removeAllObservers];
    
    [super tearDown];
}

/** This method tests that a simple one keyPath KVO block gets called */
-(void) testSimpleOneKeyPathKVO {
   
    DBKVODummyClass *dummyClass = [[DBKVODummyClass alloc] init];

    __block BOOL result = NO;
    [[DBKVOBlock sharedManager] observeObject:dummyClass withKeyPath:@"testString" withAction:^{
        result = YES;
    }];
    
    dummyClass.testString = @"Test string";
    STAssertTrue(result == YES, @"Result should equal YES");
}

/** This method tests that unregistering a single key path using the `removeObserverForObject` method doesn't get any further block invocations */
-(void) testUnregisterOneKeyPathKVO {
    
    DBKVODummyClass *dummyClass = [[DBKVODummyClass alloc] init];
    __block BOOL result = NO;
    [[DBKVOBlock sharedManager] observeObject:dummyClass withKeyPath:@"testString" withAction:^{
        result = YES;
    }];
    
    //unregister
    [[DBKVOBlock sharedManager] removeObserverForObject:dummyClass];
    
    dummyClass.testString = @"Test string";
    STAssertTrue(result == NO, @"Result should be NO");
}

/** This method test that unregistering a single key path using the `removeAllObservers` method doesn't get any further block invocations */
-(void) testUnregisterAllKeyPaths {
    
    DBKVODummyClass *dummyClass = [[DBKVODummyClass alloc] init];
    __block BOOL result = NO;
    [[DBKVOBlock sharedManager] observeObject:dummyClass withKeyPath:@"testString" withAction:^{
        result = YES;
    }];
    
    //unregister
    [[DBKVOBlock sharedManager] removeAllObservers];
    dummyClass.testString = @"Test string";
    STAssertTrue(result == NO, @"Result should be NO");
}

/** This method tests that unregistering a single key path using the `removeObserverForObject:withKeyPath:` method doesn't get any further block invocations */
-(void) testUnregisterObjectUsingKeyPath {
    
    DBKVODummyClass *dummyClass = [[DBKVODummyClass alloc] init];
    __block BOOL result = NO;
    [[DBKVOBlock sharedManager] observeObject:dummyClass withKeyPath:@"testString" withAction:^{
        result = YES;
    }];
    
    //unregister
    [[DBKVOBlock sharedManager] removeObserverForObject:dummyClass withKeyPath:@"testString"];
    dummyClass.testString = @"Test string";
    STAssertTrue(result == NO, @"Result should be NO");
}

/** Test auto-unregister of deallocated objects */
-(void) testAutoUnregisterOfDeallocatedObjects {
    
    DBKVODummyClass *dummyClass = [[DBKVODummyClass alloc] init];
    __block BOOL result = NO;
    [[DBKVOBlock sharedManager] observeObject:dummyClass withKeyPath:@"testString" withAction:^{
        result = YES;
    }];
    
    dummyClass = nil;
    dummyClass.testString = @"Test string";
    STAssertTrue(result == NO, @"Result should be NO");
}

/** Test isolation of `removeObserverForObject:withKeyPath:` method for same keyPath */
-(void) testIsolationOfRemoveObserverForObjectWithSameKeyPath {
    
    DBKVODummyClass *dummyClass1 = [[DBKVODummyClass alloc] init];
    DBKVODummyClass *dummyClass2 = [[DBKVODummyClass alloc] init];
    
    __block BOOL result1 = NO;
    [[DBKVOBlock sharedManager] observeObject:dummyClass1 withKeyPath:@"testString" withAction:^{
        result1 = YES;
    }];
    
    __block BOOL result2 = NO;
    [[DBKVOBlock sharedManager] observeObject:dummyClass2 withKeyPath:@"testString" withAction:^{
        result2 = YES;
    }];
    
    [[DBKVOBlock sharedManager] removeObserverForObject:dummyClass1 withKeyPath:@"testString"];
    
    dummyClass1.testString = @"teststring1";
    dummyClass2.testString = @"testString2";
    
    STAssertTrue(result1 == NO, @"Result should be NO");
    STAssertTrue(result2 == YES, @"Result should be YES");
    
}

/** Test the category method for adding an observer */
-(void) testCategoryMethodForAddingObserver {
    
    DBKVODummyClass *dummyClass = [[DBKVODummyClass alloc] init];
    __block NSString *result = @"";
    [dummyClass observeKeyPath:@"testString" withAction:^{
        result = dummyClass.testString;
    }];
    
    dummyClass.testString = @"test";
    STAssertTrue([result isEqualToString:@"test"], @"Result should equal \"test\"");
}

#warning add other category method tests

@end
