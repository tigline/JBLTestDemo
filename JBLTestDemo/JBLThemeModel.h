//
//  ThemeModel.h
//  JBLConnectPlus
//
//  Created by Niranjan, Rajabhaiya on 14/10/16.
//  Copyright © 2016 Deepak Kumar. All rights reserved.
//

/**
 @header JBLThemeModel.h
 @brief This is the model class  for theme model.
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants_JBLP.h"
@interface JBLThemeModel : NSObject
{
    
}
/** This property Will hold theme name */
@property (nonatomic,retain)NSString *strThemeName;

/** This property  theme image name that will show on theme card in app */
@property (nonatomic,retain)NSString *strThemeImageName;

/** This property holds Current theme color */
@property (nonatomic,retain)UIColor *currentThemeColor;

/** This property for Previous theme color for mantianing reset button*/
@property (nonatomic,retain)UIColor *previousThemeColor;

/** This property  Default color code of theme*/
@property (nonatomic,retain)UIColor *defaultThemeColor;

/** This property For holding High Frequency value */
@property unsigned int highFrequency;

/** This property  For holding low Frequency value */
@property unsigned int lowFrequency;

/** This property  For holding mid Frequency value */
@property unsigned int midFrequency;

/** This property  bool for checking sound playing */
@property BOOL isSoundPlaying;

/** This property   bool for checking theme color changes */
@property BOOL isThemeColorChanges;

/** This property  is for storing theme type */
@property (nonatomic, assign) ThemeType themeType;

/** This property  holds array animation images */
@property (nonatomic,retain) NSMutableArray *arrayAnimationImage;

/**
 @brief This method initialises theme model
 @param themeDic takes theme dictionary
 */
-(id)initWithThemeDic:(NSDictionary *)themeDic;

/**
 @brief  It will return RGB for all theme and Light effect number for Custome Theme  1st Bytes for Low freq , 2nd Bytes for Mid Freq and 3rd bytes for High Freq.
 @resetValueram it takes a bool value for reset flag
 */
-(NSData *)getThemeColorInDataWithResetValue:(BOOL)resetValue;

/**
 @brief This method   will return RGB for all theme and Light effect number for Custome Theme.
 @dicram it takes a theme dictionary
 */
-(void)updateThemeCurrentRGBValue:(NSDictionary *)dic;

@end
