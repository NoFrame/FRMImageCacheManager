//
//  SDImageCache+FarmisCatalog.m
//  Farmis
//
//  Created by Vilmantas on 05/05/16.
//  Copyright © 2016 Rento Media. All rights reserved.
//

#import "SDImageCache+FRMImageCacheManager.h"
#import "FRMCacheNames.h"

@implementation SDImageCache (FRMImageCacheManager)

+ (SDImageCache *)sharedImageCacheWithNamespace:(NSString *)ns {
    if ([ns isEqualToString:kFarmisCatalogCacheNamespace]) {
        static dispatch_once_t catalogOnce;
        static id catalogInstance;
        dispatch_once(&catalogOnce, ^{
            catalogInstance = [[SDImageCache alloc] initWithNamespace:ns];
        });
        return catalogInstance;
    }
    else if ([ns isEqualToString:kFarmisAgronomistCacheNamespace]) {
        static dispatch_once_t agronomistOnce;
        static id agronomistInstance;
        dispatch_once(&agronomistOnce, ^{
            agronomistInstance = [[SDImageCache alloc] initWithNamespace:ns];
        });
        return agronomistInstance;
    }
    else {
        return [SDImageCache sharedImageCache];
    }
}
@end
