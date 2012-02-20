//
//  RKURL.m
//  RestKit
//
//  Created by Jeff Arena on 10/18/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "RKURL.h"

@implementation RKURL

@synthesize baseURLString = _baseURLString;
@synthesize resourcePath = _resourcePath;

+ (RKURL*)URLWithBaseURLString:(NSString*)baseURLString resourcePath:(NSString*)resourcePath {
	return [[[RKURL alloc] initWithBaseURLString:baseURLString resourcePath:resourcePath] autorelease];
}

+ (BOOL)verifyURL:(NSString *)url {
    // Sorry about this, bro
    NSURL *candidateURL = [NSURL URLWithString:url];
    return (candidateURL && candidateURL.scheme && candidateURL.host);
}

- (id)initWithBaseURLString:(NSString*)baseURLString resourcePath:(NSString*)resourcePath {
    if ([RKURL verifyURL:resourcePath]) { // resource path is a full url, so uh, treat it like one
        self = [self initWithString:[resourcePath copy]];
        if (self) {
            _baseURLString = [[[[NSURL URLWithString:resourcePath] baseURL] absoluteString] copy];
            _resourcePath = [[[NSURL URLWithString:resourcePath] path] copy];
        }
    } else {
        self = [self initWithString:[NSString stringWithFormat:@"%@%@", baseURLString, resourcePath]];
        if (self) {
            _baseURLString = [baseURLString copy];
            _resourcePath = [resourcePath copy];
        }
    }
	return self;
}

- (void)dealloc {
	[_baseURLString release];
	_baseURLString = nil;
	[_resourcePath release];
	_resourcePath = nil;
	[super dealloc];
}

@end
