//
//  MYTwilioClient.m
//  Pods
//
//  Created by Vincil Bishop on 3/6/14.
//
//

#import "MYTwilioClient.h"

@implementation MYTwilioClient

static MYTwilioClient *_sharedClient;
static NSString *_capabilityToken;

+ (MYTwilioClient*) sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [[MYTwilioClient alloc] init];
    }
    
    return _sharedClient;
}

+ (void) setCapabilityToken:(NSString*)token
{
    _capabilityToken = token;
}

- (id) init
{
    self = [super init];
    
    if (self) {
        
        DDLogVerbose(@"CapabilityToken: %@",_capabilityToken);
        
        self.device = [[TCDevice alloc] initWithCapabilityToken:_capabilityToken delegate:self];
    }
    
    
    return self;
}

- (void) acceptConnection:(TCConnection*)connection
{
    self.connection = connection;
    [self.connection accept];
}

- (void) connect
{
    [self connectWithParameters:nil];
}

- (void) connectWithParameters:(NSDictionary*)parameters
{
    self.connection = [self.device connect:parameters delegate:self];
}

- (void) disconnect
{
    [self.connection disconnect];
    self.connection = nil;
}

#pragma mark - TCDeviceDelegate -

-(void)device:(TCDevice*)device didStopListeningForIncomingConnections:(NSError*)error
{
    DDLogVerbose(@"error: %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_deviceDidStartListeningForIncomingConnections object:error userInfo:@{@"sender":self}];
}

-(void)deviceDidStartListeningForIncomingConnections:(TCDevice*)device
{
    DDLogVerbose(@"device: %@", device);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_deviceDidStopListeningForIncomingConnections object:self];
}

-(void)device:(TCDevice*)device didReceiveIncomingConnection:(TCConnection*)connection
{
    DDLogVerbose(@"device: %@, connection: %@", device,connection);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_deviceDidReceiveIncomingConnection object:connection userInfo:@{@"sender":self}];
}

-(void)device:(TCDevice *)device didReceivePresenceUpdate:(TCPresenceEvent *)presenceEvent
{
    DDLogVerbose(@"device: %@, presenceEventL%@", device, presenceEvent);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_deviceDidReceivePresenceUpdate object:presenceEvent userInfo:@{@"sender":self}];
}

#pragma mark - TCConnectionDelegate -

-(void)connection:(TCConnection*)connection didFailWithError:(NSError*)error
{
    DDLogVerbose(@"error: %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_connectionDidFailWithError object:error userInfo:@{@"sender":self}];
}

-(void)connectionDidStartConnecting:(TCConnection*)connection
{
    DDLogVerbose(@"connection: %@", connection);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_connectionDidStartConnecting object:connection userInfo:@{@"sender":self}];
}

-(void)connectionDidConnect:(TCConnection*)connection
{
    DDLogVerbose(@"connection: %@", connection);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_connectionDidConnect object:connection userInfo:@{@"sender":self}];
}

-(void)connectionDidDisconnect:(TCConnection*)connection
{
    DDLogVerbose(@"connection: %@", connection);
    [[NSNotificationCenter defaultCenter] postNotificationName:MYTwilioClient_connectionDidDisconnect object:connection userInfo:@{@"sender":self}];
}

@end
