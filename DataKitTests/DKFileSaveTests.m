//
//  DKFileSaveTests.m
//  DataKit
//
//  Created by Erik Aigner on 18.03.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import "DKFileSaveTests.h"

#import "DataKit.h"

@implementation DKFileSaveTests

- (void)setUp {
  [DKManager setAPIEndpoint:@"http://localhost:3000"];
  [DKManager setAPISecret:@"c821a09ebf01e090a46b6bbe8b21bcb36eb5b432265a51a76739c20472908989"];
}

- (NSData *)generateRandomData {
  NSMutableData *data = [NSMutableData new];
  for (int i=0; i<1024*100; i++) {
    UInt8 c = (UInt8)(rand() % 255);
    CFDataAppendBytes((__bridge CFMutableDataRef)data, &c, 1);
  }
  return [NSData dataWithData:data];
}

- (void)testRandomData {
  NSData *data = [self generateRandomData];
  NSData *data2 = [self generateRandomData];
  
  STAssertFalse([data isEqualToData:data2], nil);
}

- (void)testSave {
  NSData *data = [self generateRandomData];
  
  DKFile *file = [DKFile fileWithData:data name:@"afile"];
  
  NSError *error = nil;
  BOOL success = [file save:&error];
  
  STAssertTrue(success, nil);
  STAssertNil(error, error.localizedDescription);
}

@end