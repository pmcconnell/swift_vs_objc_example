//
//  HTTPService.swift
//  rest
//
//  Created by Patrick McConnell on 6/5/14.
//  Copyright (c) 2014 Patrick McConnell. All rights reserved.
//

import UIKit

extension String {
    /// Provides an NSURL instance based on a url path string
    func toURL() -> NSURL {
        return NSURL.URLWithString(self)
    }
}

class HTTPService: NSObject {
    
    func getDataFromURL(urlString: String, onCompletion: (NSData!, NSURLResponse!, NSError!) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(urlString.toURL(), completionHandler: onCompletion)
        task.resume()
    }
    
    func postData(data: NSData, toURLString: String, onCompletion: (NSData!, NSURLResponse!, NSError!) -> Void) {
        let request = NSMutableURLRequest(URL: toURLString.toURL())
        request.HTTPMethod = "POST"
        request.HTTPBody = data
        
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: onCompletion).resume()
    }
}

//    func getGoogle() {
//        NSLog("getGoogle()")
//        
//        func dataToString(data: NSData) -> String {
//            return NSString(data: data, encoding: NSASCIIStringEncoding)
//        }
//        
//        func completion(data: NSData!, _: NSURLResponse!, _:NSError!) {
//            NSLog("\(dataToString(data))")
//        }
//        
//        let url = NSURL.URLWithString("http://google.com")
//        let session = NSURLSession.sharedSession()
//        let task = session.dataTaskWithURL(url, completionHandler: completion)
//        task.resume()
//    }

