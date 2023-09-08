//
//  LoggingInterceptor.swift
//  NosyNetwork
//
//  Created by Krzysztof Kosobudzki on 14/06/2023.
//

import Foundation

class LoggingInterceptor : URLProtocol {
  private static let FlagKey = "NosyIntercepted"
  
  private let nosy: NosyClient = NosyClient()
  
  override class func canInit(with request: URLRequest) -> Bool {
    guard self.property(forKey: FlagKey, in: request) == nil
    else { return false } // already intercepted
    
    return true
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override func startLoading() {
    guard let client = self.client else {
      return
    }
    
    let mutableRequest = (self.request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
    let request = mutableRequest as URLRequest
    
    LoggingInterceptor.setProperty(true, forKey: LoggingInterceptor.FlagKey, in: mutableRequest)
    
    Task.init {
        async let requestId = self.nosy.logRequest(request)
        async let (data, response) = try! URLSession.shared.data(for: request)
      
        client.urlProtocol(self, didReceive: await response, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
        client.urlProtocol(self, didLoad: await data)
        client.urlProtocolDidFinishLoading(self)
        
        if let id = await requestId {
            await self.nosy.logResponse(id, response, data)
        }
    }
  }
  
  override func stopLoading() {
    // no-op
  }
}
