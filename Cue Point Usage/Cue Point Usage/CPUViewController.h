//
//  CPUViewController.h
//  Cue Point Usage
//
//  Created by Robert Crooks on 11/14/13.
//  Copyright (c) 2013 Robert Crooks. All rights reserved.
//

#import <UIKit/UIKit.h>

// forward references for facade protocol and the catalog service class
@protocol BCOVPlaybackFacade;
@class BCOVCatalogService;
// create media request factory
// allows access to Catalog for Japan accounts
// and via proxy
@class BCOVMediaRequestFactory;


@interface CPUViewController : UIViewController

// declare the facade and catalog properties
@property (strong, nonatomic) id<BCOVPlaybackFacade> facade;
@property (strong, nonatomic) BCOVCatalogService *catalog;
// declare property for the media request factory
@property (strong, nonatomic) BCOVMediaRequestFactory *mediaRequestFactory;

@end
