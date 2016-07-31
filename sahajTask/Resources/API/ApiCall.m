//
//  ApiCall.m
//  sahajTask
//
//  Created by Karthik Saminathan on 31/07/16.
//  Copyright © 2016 Karthik Saminathan. All rights reserved.
//

#import "ApiCall.h"

static ApiCall *apicall;
@implementation ApiCall

+(ApiCall *)sharedInstance
{
    apicall = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        apicall = [[ApiCall alloc] init];
    });
    return apicall;
}
//-------------------------------------------------------------------------------------
#pragma mark - get response from flickr url and pass back through block 
//-------------------------------------------------------------------------------------
-(void)GetResponse :(void (^) (BOOL success, NSDictionary *response, NSString *error))CompletionBlock
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable)
    {
        NSURL *flickr_url = [NSURL URLWithString:ImageUrl];
        NSURLRequest *flickr_url_request = [[NSURLRequest alloc] initWithURL:flickr_url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *responseTask = [session dataTaskWithRequest:flickr_url_request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            if (data.length > 0 && !error)
            {
                NSDictionary  *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                CompletionBlock(true,responseDictionary,nil);
            }
            else
            {
                CompletionBlock(false,nil,[NSString stringWithFormat:@"%@",error]);
            }
        }];
        [responseTask resume];
    }
    else
    {
        CompletionBlock(false,nil,@"Network Connection is not available");
    }
}
//-------------------------------------------------------------------------------------
@end
