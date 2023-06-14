//
//  ConfigureLogger.swift
//  WongaPay
//
//  Created by Krzysztof Kosobudzki on 29/05/2023.
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
      let requestId = await self.nosy.logRequest(request)
        
      let (data, response) = try await URLSession.shared.data(for: request)
      
      if let id = requestId {
        await self.nosy.logResponse(id, response, data)
      }
      
      client.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
      client.urlProtocol(self, didLoad: data)
      client.urlProtocolDidFinishLoading(self)
    }
  }
  
  override func stopLoading() {
    // no-op
  }
}

@objc
extension URLSessionConfiguration {

  @objc
  static func inspect() {
    let originalSelector = #selector(getter: URLSessionConfiguration.default)
    let swizzledSelector = #selector(getter: URLSessionConfiguration.swizzled_default)

    guard let originalMethod = class_getClassMethod(URLSessionConfiguration.self, originalSelector),
          let swizzledMethod = class_getClassMethod(URLSessionConfiguration.self, swizzledSelector)
    else { return }

    method_exchangeImplementations(originalMethod, swizzledMethod)
  }
  
  @objc
  class var swizzled_default: URLSessionConfiguration {
    let configuration = swizzled_default

    configuration.protocolClasses?.insert(LoggingInterceptor.self, at: 0)

    return configuration
  }
}
