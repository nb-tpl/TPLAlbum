//
//  TPLMapUtil.h
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-27.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


#define POINTS      @"points"
#define LATITUDE    @"latitude"
#define LONGITUDE   @"longitude"
#define TITLE       @"name"
#define SUBTITLE    @"addr"
#define ACTION      @"action"


@interface MapAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString* title;
    NSString* subtitle;
    NSString* action;
    UIImage* image;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, strong) NSString* action;
@property (nonatomic, strong) UIImage* image;


- (id) initWithPointDict: (NSDictionary*) point;
- (id) initWithCoordinate: (CLLocationCoordinate2D) aCoordinate;
@end





#pragma mark-
#pragma mark----------MapUntil-------

@interface TPLMapUtil : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    
    UINavigationController* nav;
    UIButton* backbutton;
    UIButton* currentbutton;
    CLLocationManager *locManager;
    MKMapView *mapView;
    CLLocation *bestLocation;
    
}

@property (strong) CLLocationManager *locManager;
@property (strong) CLLocation *bestLocation;
@property (strong) MKMapView *mapView;
@property (nonatomic, strong) UINavigationController* nav;
@property (nonatomic, strong) UIButton* backbutton;
@property (nonatomic, strong) UIButton* currentbutton;

+ (id) getInstence;

- (void) showMap: (UIWindow*) window
            Span: (NSString*) span
            Coor: (CLLocationCoordinate2D) coor;
- (void) startLocManager;
- (void) addPointToMap: (MapAnnotation*) annotation;
- (void) addPointsToMap: (NSArray*) annotations;
- (void) getCurrentPoint;
- (void) setCurrentCoordinate: (CLLocationCoordinate2D) coor;
- (CLLocationCoordinate2D) getCurrentCoordinate;

@end
