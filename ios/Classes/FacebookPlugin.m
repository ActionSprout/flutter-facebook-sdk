#import "FacebookPlugin.h"
#if __has_include(<facebook/facebook-Swift.h>)
#import <facebook/facebook-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "facebook-Swift.h"
#endif

@implementation FacebookPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFacebookPlugin registerWithRegistrar:registrar];
}
@end
