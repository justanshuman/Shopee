//
//  APIController.swift
//  FlyRobeDemo
//
//  Created by Anshuman Srivastava on 23/06/16.
//  Copyright © 2016 Anshuman Srivastava. All rights reserved.
//

import UIKit

class APIController: NSObject {
    typealias CompletionBlock = (response: Dictionary<String, AnyObject>?) -> Void
    static func get(path: String, queryParameters: Dictionary<String, String>?, success: CompletionBlock?, failure: CompletionBlock?) {
        var queryString = "?"
        if let params = queryParameters {
            queryString += "&"
            for (key, value) in params {
                queryString += key + "=" + value + "&"
            }
        }
        if let encodedString = queryString.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet()) {
            queryString = encodedString
        }
        
        let url = NSURL(string: path.stringByAppendingString(queryString))
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 60
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
            if let r = response as? NSHTTPURLResponse{
                if r.statusCode == 200 {
                    if let d = data {
                        do {
                            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(d, options: .MutableContainers)
                            if let jsonArray = jsonObject as? Array<AnyObject> {
                                let dictionary = ["JSON": jsonArray]
                                success?(response: dictionary)
                            } else if let jsonDictionary = jsonObject as? Dictionary<String, AnyObject> {
                                success?(response: jsonDictionary)
                            }
                        }
                            
                            
                        catch let e as NSError{
                            print(String(data: d, encoding: NSUTF8StringEncoding))
                            failure?(response: ["error": "error"])
                        }
                        catch {
                            failure?(response: nil)
                        }
                    }
                }
                else {
                    failure?(response: nil)
                }
            }
        })
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        })
        task.resume()
        
    }
    
    
    static func post(path: String, queryParameters: Dictionary<String, String>?, body: AnyObject?, success: CompletionBlock?, failure: CompletionBlock?) {
        var queryString = "?"
        if let params = queryParameters {
            queryString += "&"
            for (key, value) in params {
                queryString += key + "=" + value + "&"
            }
        }
        
        if let encodedString = queryString.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet()) {
            queryString = encodedString
        }
        
        let url = NSURL(string: path.stringByAppendingString(queryString))
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        if request.valueForHTTPHeaderField("Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let b = body {
            request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(b, options: [])
        }
        
        request.timeoutInterval = 60
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
            if let r = response as? NSHTTPURLResponse{
                if r.statusCode == 200 {
                    if let d = data {
                        do {
                            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(d, options: .MutableContainers)
                            if let jsonArray = jsonObject as? Array<AnyObject> {
                                let dictionary = ["JSON": jsonArray]
                                success?(response: dictionary)
                            } else if let jsonDictionary = jsonObject as? Dictionary<String, AnyObject> {
                                success?(response: jsonDictionary)
                            }
                        }
                            
                            
                        catch let e as NSError{
                            print(String(data: d, encoding: NSUTF8StringEncoding))
                            failure?(response: ["error": "error"])
                        }
                        catch {
                            failure?(response: nil)
                        }
                    }
                }
                else {
                    failure?(response: nil)
                }
            }
        })
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        })
        task.resume()
        
    }
    
    
    
    static func getImageDataFromUrl(url: NSURL, success: ((imageData: NSData) -> Void)?, failure: (() -> Void)? = nil) -> NSURLSessionDataTask? {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let imageData = data {
                success?(imageData: imageData)
            } else {
                failure?()
            }
        })
        task.resume()
        return task
    }
    
}

extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}

extension String
{
    var parseJSONString: AnyObject?
    {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        if let jsonData = data
        {
            // Will return an object or nil if JSON decoding fails
            do
            {
                let message = try NSJSONSerialization.JSONObjectWithData(jsonData, options:.MutableContainers)
                if let jsonResult = message as? NSMutableArray
                {
                    print(jsonResult)
                    
                    return jsonResult //Will return the json array output
                }
                else
                {
                    return nil
                }
            }
            catch let error as NSError
            {
                print("An error occurred: \(error)")
                return nil
            }
        }
        else
        {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}
