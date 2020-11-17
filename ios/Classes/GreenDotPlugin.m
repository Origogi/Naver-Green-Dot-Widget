#import "GreenDotPlugin.h"
#if __has_include(<green_dot/green_dot-Swift.h>)
#import <green_dot/green_dot-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "green_dot-Swift.h"
#endif

@implementation GreenDotPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGreenDotPlugin registerWithRegistrar:registrar];
}
@end
