//
//  ThemeModel.m
//  JBLConnectPlus
//
//  Created by Niranjan, Rajabhaiya on 14/10/16.
//  Copyright © 2016 Deepak Kumar. All rights reserved.
//

#import "JBLThemeModel.h"

#define LOWFREQUENCY 3
#define HIGHFREQUENCY 5
#define MIDFREQUENCY 8


@interface JBLThemeModel ()
{
}
@end

@implementation JBLThemeModel
/**
 *  create JBLThemeModel object using theme data dictionary
 *
 *  @param themeDic        this dictionary will have all basic value of theme.
 *
 *  @return return JBLThemeModel Object .
 */
-(id)initWithThemeDic:(NSDictionary *)themeDic
{
    if(self = [super init])
    {
        self.themeType = [[themeDic objectForKey:@"id"] integerValue];
        self.strThemeName = [themeDic objectForKey:@"name"];
        self.strThemeImageName = [themeDic objectForKey:@"drawable"];
        unsigned int hexint = 0;
        NSScanner *scanner = [NSScanner scannerWithString:[themeDic objectForKey:@"defaultColour"]];
        // Tell scanner to skip the # character
        [scanner setCharactersToBeSkipped:[NSCharacterSet
                                           characterSetWithCharactersInString:@"#"]];
        [scanner scanHexInt:&hexint];
        self.defaultThemeColor = UIColorFromRGB(hexint);
        self.currentThemeColor = self.defaultThemeColor;

        self.isThemeColorChanges = NO;
        
        if(self.themeType != CustomizeThemeType){
            self.arrayAnimationImage = [[NSMutableArray alloc]initWithArray:[themeDic   objectForKey:@"animationdrawable"]];
        }
    }
    return self;
}

/**
 @brief This method   will return RGB for all theme and Light effect number for Custome Theme.
 @param dic takes a theme dictionary
 */
-(void)updateThemeCurrentRGBValue:(NSDictionary *)dic
{
    self.themeType = [[dic objectForKey:@"THEMEID"] integerValue];
    if([[dic objectForKey:@"THEMEID"] integerValue] != CustomizeThemeType){
        if([[dic objectForKey:@"RESET"] boolValue]){
            self.currentThemeColor = self.defaultThemeColor;
            self.isThemeColorChanges = NO;
        }else{
            self.isThemeColorChanges = YES;
            float redValue = [[dic objectForKey:@"RED"] floatValue];
            float greenValue = [[dic objectForKey:@"GREEN"] floatValue];
            float blueValue = [[dic objectForKey:@"BLUE"] floatValue];
            self.currentThemeColor = [UIColor colorWithRed:redValue/255.0 green:greenValue/255.0 blue:blueValue/255.0 alpha:1];
        }
    }else if([[dic objectForKey:@"THEMEID"] integerValue] == CustomizeThemeType){
        if([[dic objectForKey:@"RESET"] boolValue]){
            self.lowFrequency = LOWFREQUENCY;
            self.highFrequency = HIGHFREQUENCY;
            self.midFrequency = MIDFREQUENCY;
        }else{
            self.lowFrequency = [[dic objectForKey:@"RED"] unsignedIntValue];
            self.highFrequency = [[dic objectForKey:@"GREEN"] unsignedIntValue];
            self.midFrequency = [[dic objectForKey:@"BLUE"] unsignedIntValue];
        }
        self.currentThemeColor =  UIColorFromRGB(0x000000);
    }
}
// It will return RGB for all theme and Light effect number for Custome Theme  1st Bytes for Low freq , 2nd Bytes for Mid Freq and 3rd bytes for High Freq
-(NSData *)getThemeColorInDataWithResetValue:(BOOL)resetValue
{
    NSData *colorData = nil;
    if(self.themeType != CustomizeThemeType){
        colorData = [self hexStringForColor:self.currentThemeColor withResetValue:resetValue];
    }else{
        colorData = [self createLightEffectFreqData];
    }
    //NSLog(@"%@ colorData",colorData);
    return  colorData;
}
/**
 *  create data for theme frequency using frequency ,
 *
 *
 *  @return return frequency data .
 */
-(NSData *)createLightEffectFreqData
{
    unsigned char lightEffect[4] = {};
    lightEffect[0] = self.lowFrequency;
    lightEffect[1] = self.highFrequency;
    lightEffect[2] = self.midFrequency;
    lightEffect[3] = 0x00;
    NSData *data = [NSData dataWithBytes:&lightEffect length:sizeof(lightEffect)];
    return  data;
}
/**
 *  create RGB data for theme using color ,
 *
 *
 *  @return return frequency data .
 */
- (NSData *)hexStringForColor:(UIColor *)color withResetValue:(BOOL)resetValue{
     unsigned char rgbData[4] = {};
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    rgbData[0] = (unsigned char)(r * 255);
    rgbData[1] = (unsigned char)(g * 255);
    rgbData[2] = (unsigned char)(b * 255);
    if(resetValue || !self.isThemeColorChanges){
//        rgbData[0] = 00;
//        rgbData[1] = 00;
//        rgbData[2] = 00;
        rgbData[3] = 01;
    }else{
        
        rgbData[3] = 00;
    }
    NSData *data = [NSData dataWithBytes:&rgbData length:sizeof(rgbData)];
    //NSLog(@"%@ data hexStringForColor",data);
    return  data;
}
@end
