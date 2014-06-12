//
//  HTTPService.m
//  rest_objc
//
//  Created by Patrick McConnell on 6/10/14.
//  Copyright (c) 2014 Patrick McConnell. All rights reserved.
//

#import "HTTPService.h"

@implementation HTTPService

- (void)getDataFromURL:(NSString *)urlString
          onCompletion:(HTTPSessionCompletionBlock)completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, response, error);
    }];
    [task resume];
}

- (void)postData:(NSData*)data
     toURLString:(NSString*)URLString
    onCompletion:(HTTPSessionCompletionBlock)completion {
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    
    [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, response, error);
    }];
}


@end
