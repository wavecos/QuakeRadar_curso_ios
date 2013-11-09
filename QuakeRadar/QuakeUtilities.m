//
//  QuakeUtilities.m
//  QuakeRadar
//
//  Created by Tekhne on 11/9/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import "QuakeUtilities.h"

NSString * const kEarthquakeInPastHour = @"http://earthquake.usgs.gov/earthquakes/feed/v0.1/summary/all_hour.geojson";

@implementation QuakeUtilities

+(NSArray *)earthquakesInPastHour {
    
    NSMutableArray *quakes = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:kEarthquakeInPastHour];
    
    NSData *quakeData = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *quakeDic = [NSJSONSerialization JSONObjectWithData:quakeData options:kNilOptions error:nil];
    
    NSArray *features = quakeDic[@"features"];
    
    for (NSDictionary *feature in features) {
        NSDictionary *properties = feature[@"properties"];
        NSDictionary *geometry = feature[@"geometry"];
        
        Quake *quake = [[Quake alloc] init];
        quake.place = properties[@"place"];
        quake.magnitude = [NSString stringWithFormat:@"%@ %@", properties[@"mag"], properties[@"magnitudeType"]];
        
        double magnitude = [properties[@"mag"] doubleValue];
        
        if (magnitude > 1.5) {
            quake.imgAlert = [UIImage imageNamed:@"red.png"];
        } else {
            quake.imgAlert = [UIImage imageNamed:@"orange.png"];
        }
        
        double unixTime = [properties[@"time"] doubleValue];
        // Time
        quake.time = [NSDate dateWithTimeIntervalSince1970:unixTime / 1000];
        // Duration
        quake.duration = [NSString stringWithFormat:@"%@ seg", properties[@"rms"]];
        
        // Coordinates
        double longitude = [geometry[@"coordinates"][0] doubleValue];
        double latitude = [geometry[@"coordinates"][1] doubleValue];
        quake.location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        quake.proof = [NSString stringWithFormat:@"%@ km", geometry[@"coordinates"][2]];
        
        [quakes addObject:quake];
    }
    
    return quakes;
}


@end
