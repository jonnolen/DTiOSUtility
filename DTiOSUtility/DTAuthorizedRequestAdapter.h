//
//  PWAuthorizedRequestAdapter.h
//  passageways
//
//  Created by Jonathan Nolen on 12/18/12.
//  Copyright (c) 2012 Developertown. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 sits in between restkit and the caller and 
 intercepts didFailWithError calls.
 
 Looks for 400 series errors and then does the right thing, once it has re-established authentication then re-execute
 the initial request.
 
 Request requires authentication token but no authentication was passed in.
 HTTP 401
 WWW-Authenticate: Bearer realm="some-realm"
 --> prompt for authentication.
 --> re-send request when new token notification arrives.
 
 Request was made with an invalid or expired authentication token.
 HTTP 401
 WWW-Authenticate: Bearer realm="some-realm",error="invalid_token",error_description="The access token is expired."
 --> make new token request using refresh token.
 --> if token request fails: prompt for authentication.
 --> re-send request when new token notification arrives.
 
 Request was made with an authentication token with insufficient scope (not fixable error).
 HTTP 403
 WWW-Authenticate: Bearer realm="some-realm",error="insufficient_scope",scope="required scope to access resource",error_description="The access token does not have the required scope to access the resource"
 --> log NSError
 --> pass NSError with message "you do not have permission to access this resource" to caller didFailWithError.
**/
 
@interface DTAuthorizedRequestAdapter : NSObject

/**
 RKObjectLoaderDelegate method
 -(void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error;
 
 RKRequestDelegate methods
 - (void)request:(RKRequest *)request didFailLoadWithError:(NSError *)error;

 RKObjectLoader callbacks
 ==========================
 RKObjectLoaderDidFailwithErrorBlock onDidFailWithError => ^(NSError *)
**/
@end
