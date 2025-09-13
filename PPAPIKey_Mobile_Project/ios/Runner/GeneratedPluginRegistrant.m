//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#import <sqflite_darwin/SqfliteDarwinPlugin.h>
#import <url_launcher_macos/UrlLauncherPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
  [SqfliteDarwinPlugin registerWithRegistrar:[registry registrarForPlugin:@"SqfliteDarwinPlugin"]];
  [UrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"UrlLauncherPlugin"]];
}

@end