//
//  ViewController.m
//  rest_objc
//
//  Created by Patrick McConnell on 6/10/14.
//  Copyright (c) 2014 Patrick McConnell. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "HTTPService.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)parseTextField {
    NSString *originalString = self.textField.text;
    return [originalString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
}


- (void)addPinToMap:(double)lat lng:(double)lng{
    MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
    pin.coordinate = CLLocationCoordinate2DMake(lat, lng);
    pin.title = self.textField.text;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(pin.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    [self.mapView addAnnotation:pin];
    [self.mapView setNeedsDisplay];
}


- (void)fetchLocation {
    HTTPService *httpService = [[HTTPService alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", @"http://maps.googleapis.com/maps/api/geocode/json?address=", [self parseTextField]];
    [httpService getDataFromURL:urlString onCompletion:^(NSData *data, NSURLResponse *urlResponse, NSError *error) {
        NSError *parseError;
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:&parseError];
        
        NSDictionary *location = response[@"results"][0][@"geometry"][@"location"];
        double lat = [location[@"lat"] doubleValue];
        double lng = [location[@"lng"] doubleValue];

        NSLog(@"Lat: %f Lng: %f", lat, lng);
        [self addPinToMap:lat lng:lng];
    }];
}


- (IBAction)buttonPressed:(id)sender {
    if (![self.textField.text isEqualToString:@""]){
        [self.view endEditing:YES];
        [self fetchLocation];
    } else {
        NSLog(@"No Address entered!");
    }
}

@end
