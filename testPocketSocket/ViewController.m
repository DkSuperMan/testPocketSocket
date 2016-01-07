//
//  ViewController.m
//  testPocketSocket
//
//  Created by 陈金 on 16/1/7.
//  Copyright © 2016年 Art. All rights reserved.
//

#import "ViewController.h"
#import "PSWebSocket.h"

@interface ViewController ()<PSWebSocketDelegate>

@property (nonatomic, strong) PSWebSocket *socket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender
{
    // create the NSURLRequest that will be sent as the handshake
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"www.baidu.com"]];
    
    // create the socket and assign delegate
    self.socket = [PSWebSocket clientSocketWithRequest:request];
    self.socket.delegate = self;
    
    // open socket
    [self.socket open];

}

#pragma mark - PSWebSocketDelegate

- (void)webSocketDidOpen:(PSWebSocket *)webSocket {
    NSLog(@"The websocket handshake completed and is now open!");
    [webSocket send:@"Hello world!"];
}
- (void)webSocket:(PSWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"The websocket received a message: %@", message);
}
- (void)webSocket:(PSWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"The websocket handshake/connection failed with an error: %@", error);
}
- (void)webSocket:(PSWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"The websocket closed with code: %@, reason: %@, wasClean: %@", @(code), reason, (wasClean) ? @"YES" : @"NO");
}


//- (void)serverDidStart:(PSWebSocketServer *)server {
//    NSLog(@"Server did start…");
//}
//- (void)serverDidStop:(PSWebSocketServer *)server {
//    NSLog(@"Server did stop…");
//}
//- (BOOL)server:(PSWebSocketServer *)server acceptWebSocketWithRequest:(NSURLRequest *)request {
//    NSLog(@"Server should accept request: %@", request);
//    return YES;
//}
//- (void)server:(PSWebSocketServer *)server webSocket:(PSWebSocket *)webSocket didReceiveMessage:(id)message {
//    NSLog(@"Server websocket did receive message: %@", message);
//}
//- (void)server:(PSWebSocketServer *)server webSocketDidOpen:(PSWebSocket *)webSocket {
//    NSLog(@"Server websocket did open");
//}
//- (void)server:(PSWebSocketServer *)server webSocket:(PSWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
//    NSLog(@"Server websocket did close with code: %@, reason: %@, wasClean: %@", @(code), reason, @(wasClean));
//}
//- (void)server:(PSWebSocketServer *)server webSocket:(PSWebSocket *)webSocket didFailWithError:(NSError *)error {
//    NSLog(@"Server websocket did fail with error: %@", error);
//}

@end
