//
//  Logging.swift
//  NosyNetwork
//
//  Created by Krzysztof Kosobudzki on 14/06/2023.
//

import Foundation

@objc
public class NosyInspect: NSObject {
    
    @objc
    public static func inspect() {
      let originalSelector = #selector(getter: URLSessionConfiguration.default)
      let swizzledSelector = #selector(getter: URLSessionConfiguration.swizzled_default)

      guard let originalMethod = class_getClassMethod(URLSessionConfiguration.self, originalSelector),
            let swizzledMethod = class_getClassMethod(URLSessionConfiguration.self, swizzledSelector)
      else { return }

      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
