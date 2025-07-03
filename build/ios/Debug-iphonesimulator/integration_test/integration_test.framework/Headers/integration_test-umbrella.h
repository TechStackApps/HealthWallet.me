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

#import "FLTIntegrationTestRunner.h"
#import "IntegrationTestIosTest.h"
#import "IntegrationTestPlugin.h"

FOUNDATION_EXPORT double integration_testVersionNumber;
FOUNDATION_EXPORT const unsigned char integration_testVersionString[];

