//
//  ConfigureLogger.swift
//  WongaPay
//
//  Created by Krzysztof Kosobudzki on 29/05/2023.
//

import Foundation

@objc
extension URLSessionConfiguration {
  
  @objc
  class var swizzled_default: URLSessionConfiguration {
    let configuration = swizzled_default

    configuration.protocolClasses?.insert(LoggingInterceptor.self, at: 0)

    return configuration
  }
}
