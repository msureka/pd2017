//
//  LocationView4ViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "LocationView4ViewController.h"

@interface LocationView4ViewController ()
{
    NSUserDefaults * defauls;
    CLLocationManager *locationManager ;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@end

@implementation LocationView4ViewController
@synthesize HeadTopView,City_Txt,Country_Txt;
- (void)viewDidLoad {
    [super viewDidLoad];
     defauls=[[NSUserDefaults alloc]init];
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor lightGrayColor].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 1, HeadTopView.frame.size.width, 1);
    [HeadTopView.layer addSublayer:borderBottom];
    
    
    City_Txt.clipsToBounds=YES;
    City_Txt.layer.cornerRadius=City_Txt.frame.size.height/2;
    
    Country_Txt.clipsToBounds=YES;
    Country_Txt.layer.cornerRadius=Country_Txt.frame.size.height/2;
    if (![[defauls valueForKey:@"Cityname"] isEqualToString:@""] && ![[defauls valueForKey:@"Cityname"]isEqualToString:@""] )
    {
        City_Txt.text=[defauls valueForKey:@"Cityname"];
        Country_Txt.text=[defauls valueForKey:@"Countryname"];
    }
    
// locationManager = [[CLLocationManager alloc] init] ;
//    geocoder = [[CLGeocoder alloc] init];
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy =kCLLocationAccuracyBest; //kCLLocationAccuracyNearestTenMeters;
//    [locationManager requestWhenInUseAuthorization];
//    [locationManager startUpdatingLocation];
    
}



//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
//    CLLocation *currentLocation = newLocation;
////    
////    if (currentLocation != nil) {
////        longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
////        latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
////    }
//    
//    // Reverse Geocoding
//    NSLog(@"Resolving the Address");
//    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
//        if (error == nil && [placemarks count] > 0) {
//            placemark = [placemarks lastObject];
//            NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                                   NSLog(@"placemark.country %@",placemark.country);
//                                   NSLog(@"placemark.postalCode %@",placemark.postalCode);
//                                   NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//                                   NSLog(@"placemark.locality %@",placemark.locality);
//                                   NSLog(@"placemark.subLocality %@",placemark.subLocality);
//                                   NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
//            City_Txt.text=placemark.locality;
//            Country_Txt.text=placemark.country;
//            
//        } else {
//            NSLog(@"%@", error.debugDescription);
//        }
//    } ];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BackView:(id)sender
{
    if (![City_Txt.text isEqualToString:@""] && ![Country_Txt.text isEqualToString:@""])
    {
        if (![City_Txt.text isEqualToString:@""] && ![Country_Txt.text isEqualToString:@""])
        {
            if (![City_Txt.text isEqualToString:[defauls valueForKey:@"Cityname"]])
            {
                [defauls setObject:City_Txt.text forKey:@"Cityname"];
                [defauls synchronize];
            }
            if (![Country_Txt.text isEqualToString:[defauls valueForKey:@"Countryname"]])
            {
                [defauls setObject:Country_Txt.text forKey:@"Countryname"];
                [defauls synchronize];
            }
            
        }    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
