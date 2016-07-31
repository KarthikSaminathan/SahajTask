//
//  ApiCall.h
//  sahajTask
//
//  Created by Karthik Saminathan on 31/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"
#import "Reachability.h"
@interface ApiCall : NSObject

+(ApiCall *)sharedInstance;

//-------------------------------------------------------------------------------------
#pragma mark - get response from flickr url and pass back through block
//-------------------------------------------------------------------------------------
-(void)GetResponse :(void (^) (BOOL success, NSDictionary *response, NSString *error))CompletionBlock;
//-------------------------------------------------------------------------------------
@end
