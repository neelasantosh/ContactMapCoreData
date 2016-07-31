//
//  MapViewController.h
//  ContactMapCoreDataAsgmt
//
//  Created by Rajesh on 19/12/15.
//  Copyright © 2015 CDAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapContact;

@property CLLocationManager *locManager;
-(void)onMapLongPress:(UILongPressGestureRecognizer *)gesture;

@end
