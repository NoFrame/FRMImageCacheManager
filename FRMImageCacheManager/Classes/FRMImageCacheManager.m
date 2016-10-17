//
//  ImageCacheManager.h
//  Farmis
//
//  Created by Vilmantas on 05/05/16.
//  Copyright © 2016 Rento Media. All rights reserved.
//

#import "FRMImageCacheManager.h"
#import "SDImageCache+FRMImageCacheManager.h"
#import "FRMCacheNames.h"

typedef void(^FRMImageCacheManagerProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^FRMImageCacheManagerCompletionBlock)(BOOL success, UIImage *image);

@interface FRMImageCacheManager () {
	dispatch_queue_t imageCacheQueue;
}
@end

@implementation FRMImageCacheManager

- (instancetype)initWithType:(FRMImageCacheNamespace)type {
	self = [super init];
	if (self) {
		_iCache = [self cacheWithType:type];
		_iDownloader = [[SDWebImageDownloader alloc] init];
		imageCacheQueue = dispatch_queue_create("com.noframe.ImageCacheQueue", NULL);
	}
	return self;
}

+ (void)performImageFetchWithUrl:(id)url WithType:(FRMImageCacheNamespace)type ProgressBlock:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock CompletionBlock:(void (^)(BOOL success, UIImage *image))completionBlock {
	FRMImageCacheManager *iManager = [[FRMImageCacheManager alloc] initWithType:type];
    [iManager performImageFetchWithUrl:url ProgressBlock:progressBlock CompletionBlock:completionBlock];
}

- (void)performImageFetchWithUrl:(id)url ProgressBlock:(FRMImageCacheManagerProgressBlock)progressBlock CompletionBlock:(FRMImageCacheManagerCompletionBlock)completionBlock {
	NSURL *nsUrl = nil;
	if ([url isKindOfClass:[NSString class]]) {
		nsUrl = [NSURL URLWithString:url];
	}
	else if ([url isKindOfClass:[NSURL class]]) {
		nsUrl = url;
	}
	
	if (url == nil || [url isKindOfClass:[NSNull class]]) {
		completionBlock(NO, nil);
		return;
	}
	
	dispatch_async(imageCacheQueue, ^{
		UIImage *image = [_iCache imageFromDiskCacheForKey:[nsUrl absoluteString]];
        if (image == nil) {
            [_iDownloader downloadImageWithURL:nsUrl options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                if (progressBlock) {
                    progressBlock(receivedSize, expectedSize);
                }
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (finished) {
                    if (!error) {
                        if (image) {
                            [_iCache storeImage:image imageData:UIImageJPEGRepresentation(image, 0.6) forKey:[nsUrl absoluteString] toDisk:YES completion:nil];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (completionBlock) {
                                    completionBlock(YES, image);
                                }
                            });
                        }
                        else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (completionBlock) {
                                    completionBlock(NO, nil);
                                }
                            });
                        }
                    }
                    else {
                        NSLog(@"Error: %@", [error localizedDescription]);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (completionBlock) {
                                completionBlock(NO, nil);
                            }
                        });
                    }
                }
            }];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completionBlock) {
                    completionBlock(YES, image);
                }
            });
        }
	});
}

- (SDImageCache *)cacheWithType:(FRMImageCacheNamespace)type {
	if (type == FRMImageCacheNamespaceDefault) {
		return [SDImageCache sharedImageCache];
	}
	else if (type == FRMImageCacheNamespaceCatalog) {
		return [SDImageCache sharedImageCacheWithNamespace:kFarmisCatalogCacheNamespace];
	}
	else if (type == FRMImageCacheNamespaceAgronomist) {
		return [SDImageCache sharedImageCacheWithNamespace:kFarmisAgronomistCacheNamespace];
	}
	else {
		return nil;
	}
}

@end
