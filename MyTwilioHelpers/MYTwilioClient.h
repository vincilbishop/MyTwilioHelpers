//
//  MYTwilioClient.h
//  Pods
//
//  Created by Vincil Bishop on 3/6/14.
//
//

#import <Foundation/Foundation.h>
#import "TwilioClient.h"

#define MYTwilioClient_deviceDidStartListeningForIncomingConnections @"MYTwilioClient_deviceDidStartListeningForIncomingConnections"
#define MYTwilioClient_deviceDidStopListeningForIncomingConnections @"MYTwilioClient_deviceDidStopListeningForIncomingConnections"
#define MYTwilioClient_deviceDidReceiveIncomingConnection @"MYTwilioClient_deviceDidReceiveIncomingConnection"
#define MYTwilioClient_deviceDidReceivePresenceUpdate @"MYTwilioClient_deviceDidReceivePresenceUpdate"
#define MYTwilioClient_connectionDidFailWithError @"MYTwilioClient_connectionDidFailWithError"
#define MYTwilioClient_connectionDidStartConnecting @"MYTwilioClient_connectionDidStartConnecting"
#define MYTwilioClient_connectionDidConnect @"MYTwilioClient_connectionDidConnect"
#define MYTwilioClient_connectionDidDisconnect @"MYTwilioClient_connectionDidDisconnect"

@interface MYTwilioClient : NSObject<TCDeviceDelegate,TCConnectionDelegate>

@property (nonatomic,strong) TCDevice* device;
@property (nonatomic,strong) TCConnection* connection;

+ (void) setCapabilityToken:(NSString*)token;
+ (MYTwilioClient*) sharedClient;

- (void) acceptConnection:(TCConnection*)connection;
- (void) connect;
- (void) connectWithParameters:(NSDictionary*)parameters;

- (void) disconnect;

@end