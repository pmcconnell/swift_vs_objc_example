//
//  HTTPService.h
//  rest_objc
//
//  Created by Patrick McConnell on 6/10/14.
//  Copyright (c) 2014 Patrick McConnell. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HTTPSessionCompletionBlock)(NSData *data,
                                           NSURLResponse *response,
                                           NSError *error);

@interface HTTPService : NSObject

- (void)getDataFromURL:(NSString *)urlString
          onCompletion:(HTTPSessionCompletionBlock)completion;

- (void)postData:(NSData*)data
     toURLString:(NSString*)URLString
          onCompletion:(HTTPSessionCompletionBlock)completion;

@end
