//
//  SHMediaItem.m
//  SHGalleryView
//
//  Created by SHAN UL HAQ on 8/5/14.
//  Copyright (c) 2014 com.grevolution.shgalleryview. All rights reserved.
//

#import "SHMediaItem.h"

@implementation SHMediaItem

- (instancetype)initWithMediaType:(kMediaType)mediaType
                          andPath:(NSString *)resourcePath {
    if((self = [super init])) {
        _mediaType = mediaType;
        _resourcePath = resourcePath;
    }
    return self;
}

+ (instancetype)mediaItemWithMediaType:(kMediaType)mediaType
                               andPath:(NSString *)resourcePath {
    return [[self alloc] initWithMediaType:mediaType andPath:resourcePath];
}


@end
