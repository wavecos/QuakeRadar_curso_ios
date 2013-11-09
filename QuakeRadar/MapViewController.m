//
//  ViewController.m
//  QuakeRadar
//
//  Created by Tekhne on 10/26/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

dispatch_queue_t myQuakeQueue;
NSArray *quakes;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self earthquakesInPastHour];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Get All Earthquakes in Past Hour
-(void) earthquakesInPastHour {
    myQuakeQueue = dispatch_queue_create("com.tekhne.QuakeRadar", NULL);
    
    dispatch_async(myQuakeQueue, ^{
        quakes = [QuakeUtilities earthquakesInPastHour];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshMap];
        });
    });
}

#pragma mark Refresh the MapView

-(void) refreshMap {
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    for (Quake *quake in quakes) {
        MKPointAnnotation *quakeAnnotation = [[MKPointAnnotation alloc] init];
        
        quakeAnnotation.title = quake.place;
        
        NSMutableString *detail = [[NSMutableString alloc] init];
        
        [detail appendFormat:@"Mag: %@", quake.magnitude];
        [detail appendFormat:@"\t Dur: %@", quake.duration];
        [detail appendFormat:@"\t Prof: %@", quake.proof];
        
        quakeAnnotation.subtitle = detail;
        
        quakeAnnotation.coordinate = quake.location.coordinate;
        
        [annotations addObject:quakeAnnotation];
        
    }
    
    [self.mapView addAnnotations:annotations];
}

@end







