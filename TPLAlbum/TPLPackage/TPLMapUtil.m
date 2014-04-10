//
//  TPLMapUtil.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-27.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import "TPLMapUtil.h"
#import "AppDelegate.h"
extern UIWindow *g_window;
@implementation MapAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize action;
@synthesize image;


static TPLMapUtil* mapInstance;


BOOL isPressCurrent = FALSE;



- (id) initWithCoordinate: (CLLocationCoordinate2D) aCoordinate
{
    if (self = [super init])
    {
        
        if (aCoordinate.latitude != 0 && aCoordinate.longitude != 0)
        {
            coordinate = aCoordinate;
        }
        else
        {
            //通过Mapuntil的实例来获得当前的坐标
            coordinate = [mapInstance getCurrentCoordinate];
            
        }
        
        
    }
    return self;
}


- (id) initWithPointDict: (NSDictionary*) point
{
    if (self = [super init])
    {
        coordinate.latitude = [[point objectForKey:LATITUDE] doubleValue];
        coordinate.longitude = [[point objectForKey:LONGITUDE] doubleValue];
        
        if ([point objectForKey:TITLE])
            title = [[NSString alloc] initWithString:[point objectForKey:TITLE]];
        if ([point objectForKey:SUBTITLE])
            subtitle = [[NSString alloc] initWithString:[point objectForKey:SUBTITLE]];
        if ([point objectForKey:ACTION])
            action = [[NSString alloc] initWithString:[point objectForKey:ACTION]];
    }
    
    return self;
}



-(void) dealloc
{
    [image release];
    [title release];
    [subtitle release];
    [action release];
    [super dealloc];
}
@end

#pragma mark-
#pragma mark-----MapUntil-------
@implementation TPLMapUtil

@synthesize nav;
@synthesize backbutton;
@synthesize currentbutton;
@synthesize locManager;
@synthesize bestLocation;
@synthesize mapView;

static CLLocationCoordinate2D initCoordinate;
static CLLocationCoordinate2D currentCoor;

+ (id) getInstence
{
    if (!mapInstance) {
        mapInstance = [[TPLMapUtil alloc] init];
        
    }
    return mapInstance;
}

#pragma -
#pragma --CLLocationManagerDelegate--

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    NSString *errorString;
    [manager stopUpdatingLocation];
//    NSLog(@"Error: %@",[error localizedDescription]);
//    switch([error code]) {
//        case kCLErrorDenied:
//            //Access denied by user
//            errorString = @"定位服务未开启";
//            //Do something...
//            break;
//        case kCLErrorLocationUnknown:
//            //Probably temporary...
//            errorString = @"未获取定位数据";
//            //Do something else...
//            break;
//        default:
//            errorString = @"定位错误";
//            break;
//    }
    [[NSUserDefaults standardUserDefaults] setInteger:[error code] forKey:@"location"];

    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //去掉定位失败的信息
    @try {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"location"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    double longi = initCoordinate.longitude;
    double lati = initCoordinate.latitude;
    
    if (longi==0 && lati==0) {
        initCoordinate = newLocation.coordinate;
    }
    //设置当前的坐标为最新更新的坐标
    [self setCurrentCoordinate:newLocation.coordinate];
    
    
    //计算两点之间距离
    CLLocation* fixLocation = [[CLLocation alloc] initWithLatitude:initCoordinate.latitude
                                                         longitude:initCoordinate.longitude];
    
    NSLog(@"");
    NSLog(@"当前的 latitude : %f", newLocation.coordinate.latitude);
    NSLog(@"当前的 longitude : %f", newLocation.coordinate.longitude);
    
    [[NSUserDefaults standardUserDefaults] setFloat:newLocation.coordinate.latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setFloat:newLocation.coordinate.longitude forKey:@"longtitude" ];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    LOG(@"与当前的距离 %0.2f km", [newLocation distanceFromLocation:fixLocation]/1000);
    [fixLocation release];
    
    
    // disable further location for the moment
    
    self.locManager.delegate = nil;
    [self.locManager stopUpdatingLocation];
    
    // Keep track of the best location found
    
    if (!self.bestLocation)
        self.bestLocation = newLocation;
    else if (newLocation.horizontalAccuracy <  bestLocation.horizontalAccuracy)
        self.bestLocation = newLocation;
    
    
    if (isPressCurrent) {
        isPressCurrent = FALSE;
        //      mapView.showsUserLocation = YES;
        mapView.region = MKCoordinateRegionMake(self.bestLocation.coordinate, MKCoordinateSpanMake(0.1f, 0.1f));
        MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:newLocation.coordinate];
        [mapView addAnnotation:annotation];
        [annotation release];
    }
    else
    {
        
        mapView.region = MKCoordinateRegionMake(initCoordinate, MKCoordinateSpanMake(0.1f, 0.1f));
        //    [mapView setRegion:MKCoordinateRegionMakeWithDistance(self.bestLocation.coordinate, 5000.0f, 5000.0f) animated:YES];
        MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:initCoordinate];
        [mapView addAnnotation:annotation];
        [annotation release];
    }
    
    
    mapView.mapType = MKMapTypeStandard;
    mapView.zoomEnabled = YES;
    
    
}

- (void) showMap: (UIWindow *) window
            Span: (NSString*) span
            Coor: (CLLocationCoordinate2D) coor
{
    
#if 1
    
    
    //初始位置
    initCoordinate = coor;
    nav = [[UINavigationController alloc] initWithRootViewController: [TPLMapUtil getInstence]];
    [window addSubview:nav.view];
    
    self.view.backgroundColor=[UIColor redColor];
    //返回按钮
    backbutton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    backbutton.frame = CGRectMake(230, 25, 80, 30);
    [backbutton setTitle:@"返回" forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(pressBack)
         forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:backbutton];
    
    //返回当前位置按钮
    currentbutton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    currentbutton.frame = CGRectMake(140, 25, 80, 30);
    [currentbutton setTitle:@"当前位置" forState:UIControlStateNormal];
    [currentbutton addTarget:self action:@selector(pressCurrent)
            forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:currentbutton];
    
    
    mapView = [[MKMapView alloc] init];
    mapView.frame = CGRectMake(0, 60, 320, 420);
    mapView.delegate = self;
    [window addSubview:mapView]; //添加按钮到视图中
    
    
    
    
    CLLocationManager* manager = [[CLLocationManager alloc] init];
    self.locManager = manager;
    [manager release];
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.bestLocation = nil;
    self.locManager.delegate = self;
    [self.locManager startUpdatingLocation];//启动位置管理器
    
#else
    
    
    
#endif
    
}




- (void) startLocManager
{
    CLLocationManager* manager = [[CLLocationManager alloc] init];
    self.locManager = manager;
    [manager release];
    
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.bestLocation = nil;
    self.locManager.delegate = self;
    [self.locManager startUpdatingLocation];//启动位置管理器
}


- (void) getCurrentPoint
{
    CLLocationManager* manager = [[CLLocationManager alloc] init];
    self.locManager = manager;
    [manager release];
    self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.bestLocation = nil;
    self.locManager.delegate = self;
    [self.locManager startUpdatingLocation];//启动位置管理器
}



- (void) setCurrentCoordinate: (CLLocationCoordinate2D) _coor
{
    currentCoor = _coor;
}

- (CLLocationCoordinate2D) getCurrentCoordinate
{
    return currentCoor;
    
}

/** 通过一个点的信息添加到地图
 *
 *  @param annotation 点信息
 */
- (void) addPointToMap: (MapAnnotation*) annotation
{
    //添加标注
    [mapView addAnnotation:annotation];
}

/** 通过多个点的信息添加到地图
 *
 *  @param annotation 点信息数组
 */
- (void) addPointsToMap: (NSArray*) annotations
{
    //添加标注
    [mapView addAnnotations:annotations];
}

- (void) pressBack
{
    
    
    [nav.view removeFromSuperview];
    [backbutton removeFromSuperview];
    [currentbutton removeFromSuperview];
    [mapView removeFromSuperview];
    
}

- (void) pressCurrent
{
    
    //移到当前位置
    isPressCurrent = TRUE;
    self.locManager.delegate = self;
    [self.locManager startUpdatingLocation];//启动位置管理器
}

- (void)mapView:(MKMapView *)aMapView regionDidChangeAnimated:(BOOL)animated
{
    // Gather annotations
}

- (void)mapView:(MKMapView *)mapview didAddAnnotationViews:(NSArray *)views
{
    return;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MapAnnotation *annotation = view.annotation;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:annotation.action]];
}



- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    //    if ([annotation isKindOfClass:[MKUserLocation class]])
    //        return nil;
    //    if ([annotation isKindOfClass:[MapAnnotation class]]) {
    //        MKPinAnnotationView* pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotation.title];
    //        if (!pinView)
    //        {
    //            // if an existing pin view was not available, create one
    //            pinView = [[[MKPinAnnotationView alloc]
    //                                                initWithAnnotation:annotation reuseIdentifier:annotation.title] autorelease];
    //            UIImage *image = [UIImage imageNamed:@"pic1.png"];
    //            pinView.image = image;  //将图钉变成笑脸
    //            [image release];
    //            return pinView;
    //        }
    //        else
    //        {
    //            pinView.annotation = annotation;
    //        }
    //        return pinView;
    //    }
    //    return nil;
    
    
    
    
    //这个是让你自定义自己的大头针，可以个性化定制
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:annotation.title];
    
    if (pinView == nil)
        pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                   reuseIdentifier:annotation.title] autorelease];
    else
        pinView.annotation = annotation;
    
    //注释中添加图片
    UIImageView *headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic.png"]];
    pinView.leftCalloutAccessoryView = headImage;
    
    
    UIImage *image = [UIImage imageNamed:@"pic.png"];
    if (image)
        pinView.image = image;  //将图钉变成图片
    
    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinView.animatesDrop = NO;
    pinView.canShowCallout = TRUE;
    return pinView;
    
    return nil;
    
    
}

- (void) dealloc
{
    [nav release];
    [backbutton release];
    [currentbutton release];
    [locManager release];
    [bestLocation release];
    [mapView release];
    [super dealloc];
}

@end
