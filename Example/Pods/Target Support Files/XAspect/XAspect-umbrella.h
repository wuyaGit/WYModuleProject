#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XAspect.h"
#import "XACExtensions.h"
#import "XACrystallization.h"
#import "XAWeaveHandler.h"
#import "XADebugMacros.h"
#import "XAExtObjcMetamacros.h"
#import "XAFoundation.h"
#import "XAObjcMetaprogramming.h"

FOUNDATION_EXPORT double XAspectVersionNumber;
FOUNDATION_EXPORT const unsigned char XAspectVersionString[];

