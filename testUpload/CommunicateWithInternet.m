//
//  CommunicateWithInternet.m
//  MentorReservation
//
//  Created by ej04xjp6 on 12/10/7.
//  Copyright (c) 2012年 Robert Huang. All rights reserved.
//

#import "CommunicateWithInternet.h"

@implementation CommunicateWithInternet

+(NSData*)getJsonDataFromUrl:(NSString*)url WithGetParams:(NSDictionary*)params {
  
  NSString *myRequestString = @"";
  for (NSString *key in [params allKeys]) {
    NSString *keyValue = [NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]];
    myRequestString = [myRequestString stringByAppendingString:keyValue];
    NSLog(@"keyValur:%@ strign:%@", keyValue, myRequestString);
  }
  
  url = [url stringByAppendingString:myRequestString];
  
  NSLog(@"%@", url);
  
  NSURL *_url = [NSURL URLWithString:url];
  NSMutableURLRequest *request = [NSMutableURLRequest new];
  [request setURL:_url];
  [request setHTTPMethod:@"GET"];
  [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
  [request setTimeoutInterval:30.0];
  
  NSURLResponse* response;
  NSData* data =  [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
  
  //NSString* strRet =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  //NSLog(@"%@", strRet);
  
  return data;
}

+(NSData*)getJsonDataFromUrl:(NSString*)url WithPostParams:(NSDictionary*)params
{
  
  NSString *itemAddress= url;
  NSMutableString *post= [[NSMutableString alloc] init];
  
  //building parameters
  for (NSString* key in params) {
    
    NSString *strValue = [NSString stringWithFormat:@"%@",[params objectForKey:key]];
    
    //here we should escape / = + , otherwise, the url parse will going wrong
    strValue = [strValue stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    strValue = [strValue stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    strValue = [strValue stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    //if you need more char escapes refere to http://www.december.com/html/spec/esccodes.html
    
    NSString *current = [NSString stringWithFormat:@"&%@=%@",key,strValue];
    [post appendString: current];
  }

    NSMutableDictionary *nameElements = [NSMutableDictionary dictionary];
    
    UIImage *image = [UIImage imageNamed:@"01.jpg"];
    NSData *dataImage = UIImageJPEGRepresentation(image, 1.0);
    NSMutableDictionary *imageElements = [NSMutableDictionary dictionary];
    NSString *imageString = [UIImageJPEGRepresentation(image, 1.0) base64EncodedStringWithOptions: NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary *idString = [NSMutableDictionary dictionary];
    
    //obtain the jpeg data (.1 is quicker to send, i found it better for testing)
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, .1)];
    
    //get the data into a string
    //NSString* imageString = [NSString stringWithFormat:@"%@", imageData];
    //remove whitespace from the string
    //imageString = [imageString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //remove < and > from string
    //imageString = [imageString substringWithRange:NSMakeRange(1, [imageString length]-2)];
    
    [Base64 initialize];
    NSString *imageDataEncodedString = [Base64 encode:imageData];
    
    [idString setObject:imageElements forKey:@"12345678"];
    [imageElements setObject:imageString forKey:@"image"];
    [nameElements setObject:@"Hello" forKey:@"title"];
    
    [nameElements setObject:@"12345678912213123456" forKey:@"body"];
    [nameElements setObject:imageDataEncodedString forKey:@"image_attributes"];
    

    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:nameElements options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"Dict:%@", jsonString);
  NSURL *urlObj = [NSURL URLWithString: itemAddress];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: urlObj];
    
  [request setHTTPMethod: @"POST"];
  [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
[request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-Length"];
  [request setHTTPBody: jsonData];
  
  NSURLResponse* response;
  NSData* data =  [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
  
  NSString* strRet =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  NSLog(@"%@", strRet);
  
  return data;
}

@end
