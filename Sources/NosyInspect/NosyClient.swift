//
//  NosyClient.swift
//  NosyInspect
//
//  Created by Krzysztof Kosobudzki on 12/06/2023.
//

import Foundation
import GRPC
import NIO

class NosyClient {
  var service: Nosy_LoggerAsyncClient?
  
  let port: Int = 6969
  
  init() {
    let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 4)
    
    do {
      let channel = try GRPCChannelPool.with(
        target: .host("localhost", port: self.port),
        transportSecurity: .plaintext,
        eventLoopGroup: eventLoopGroup
      )
      
      self.service = Nosy_LoggerAsyncClient(
        channel: channel,
        defaultCallOptions: CallOptions(timeLimit: .timeout(.seconds(2)))
      )
    } catch {
      print("Could not connect to Nosy")
    }
  }
  
  func logRequest(_ request: URLRequest) async -> String? {
    let networkRequest: Nosy_NetworkRequest = .with {
      $0.method = request.httpMethod ?? "Unknown http method"
      $0.url = request.url?.absoluteString ?? "Unknown url"
      $0.headers = request.allHTTPHeaderFields ?? [:]
      $0.body = request.httpBodyStream?.readfully().string() ?? ""
    }
    
    do {
      let registerdRequest = try await service?.logRequest(networkRequest)
      
      return registerdRequest?.id
    } catch {
        print("Failed to log request to Nosy. Got error: \(error.localizedDescription)")
    }
    
    return nil
  }
  
  func logResponse(_ requestId: String, _ response: URLResponse, _ data: Data) async -> Void {
    guard let response = response as? HTTPURLResponse else { return }
    
    let networkResponse: Nosy_NetworkResponse = .with {
      $0.requestID = requestId
      $0.code = Int32(response.statusCode)
      $0.headers = response.allHeaderFields as NSDictionary? as? [String: String] ?? [:]
      $0.body = data.string()
    }
    
    do {
      try await service?.logResponse(networkResponse)
    } catch {
        print("Failed to log response to Nosy. Got error: \(error.localizedDescription)")
    }
  }
}

extension InputStream {
  func readfully() -> Data {
    var result = Data()
    var buffer = [UInt8](repeating: 0, count: 4096)
        
    open()
        
    var amount = 0
    repeat {
      amount = read(&buffer, maxLength: buffer.count)
            
      if amount > 0 {
        result.append(buffer, count: amount)
      }
    } while amount > 0
        
    close()
        
    return result
  }
}

extension Data {
  func string() -> String {
    return String(data: self, encoding: String.Encoding.utf8) ?? "Could not create data string"
  }
}
