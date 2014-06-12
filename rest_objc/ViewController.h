//
//  ViewController.h
//  rest_objc
//
//  Created by Patrick McConnell on 6/10/14.
//  Copyright (c) 2014 Patrick McConnell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)buttonPressed:(id)sender;

@end

