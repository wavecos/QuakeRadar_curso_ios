//
//  Quake.h
//  QuakeRadar
//
//  Created by Tekhne on 10/26/13.
//  Copyright (c) 2013 Tekhne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Quake : NSObject

@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *magnitude;
@property (nonatomic, strong) NSDate *time;

@property (nonatomic, strong) NSString *duration;

@property (nonatomic, strong) NSString *proof;

@property (nonatomic, strong) CLLocation *location;

@end
