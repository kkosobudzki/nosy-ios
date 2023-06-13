//
// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the protocol buffer compiler.
// Source: nosy.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `Nosy_LoggerClient`, then call methods of this protocol to make API calls.
internal protocol Nosy_LoggerClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Nosy_LoggerClientInterceptorFactoryProtocol? { get }

  func logRequest(
    _ request: Nosy_NetworkRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Nosy_NetworkRequest, Nosy_RegisteredRequest>

  func logResponse(
    _ request: Nosy_NetworkResponse,
    callOptions: CallOptions?
  ) -> UnaryCall<Nosy_NetworkResponse, Nosy_Empty>
}

extension Nosy_LoggerClientProtocol {
  internal var serviceName: String {
    return "nosy.Logger"
  }

  /// Unary call to LogRequest
  ///
  /// - Parameters:
  ///   - request: Request to send to LogRequest.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func logRequest(
    _ request: Nosy_NetworkRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nosy_NetworkRequest, Nosy_RegisteredRequest> {
    return self.makeUnaryCall(
      path: Nosy_LoggerClientMetadata.Methods.logRequest.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLogRequestInterceptors() ?? []
    )
  }

  /// Unary call to LogResponse
  ///
  /// - Parameters:
  ///   - request: Request to send to LogResponse.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func logResponse(
    _ request: Nosy_NetworkResponse,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Nosy_NetworkResponse, Nosy_Empty> {
    return self.makeUnaryCall(
      path: Nosy_LoggerClientMetadata.Methods.logResponse.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLogResponseInterceptors() ?? []
    )
  }
}

@available(*, deprecated)
extension Nosy_LoggerClient: @unchecked Sendable {}

@available(*, deprecated, renamed: "Nosy_LoggerNIOClient")
internal final class Nosy_LoggerClient: Nosy_LoggerClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: Nosy_LoggerClientInterceptorFactoryProtocol?
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  internal var interceptors: Nosy_LoggerClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the nosy.Logger service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Nosy_LoggerClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

internal struct Nosy_LoggerNIOClient: Nosy_LoggerClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Nosy_LoggerClientInterceptorFactoryProtocol?

  /// Creates a client for the nosy.Logger service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Nosy_LoggerClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal protocol Nosy_LoggerAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: Nosy_LoggerClientInterceptorFactoryProtocol? { get }

  func makeLogRequestCall(
    _ request: Nosy_NetworkRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Nosy_NetworkRequest, Nosy_RegisteredRequest>

  func makeLogResponseCall(
    _ request: Nosy_NetworkResponse,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<Nosy_NetworkResponse, Nosy_Empty>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Nosy_LoggerAsyncClientProtocol {
  internal static var serviceDescriptor: GRPCServiceDescriptor {
    return Nosy_LoggerClientMetadata.serviceDescriptor
  }

  internal var interceptors: Nosy_LoggerClientInterceptorFactoryProtocol? {
    return nil
  }

  internal func makeLogRequestCall(
    _ request: Nosy_NetworkRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Nosy_NetworkRequest, Nosy_RegisteredRequest> {
    return self.makeAsyncUnaryCall(
      path: Nosy_LoggerClientMetadata.Methods.logRequest.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLogRequestInterceptors() ?? []
    )
  }

  internal func makeLogResponseCall(
    _ request: Nosy_NetworkResponse,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<Nosy_NetworkResponse, Nosy_Empty> {
    return self.makeAsyncUnaryCall(
      path: Nosy_LoggerClientMetadata.Methods.logResponse.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLogResponseInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension Nosy_LoggerAsyncClientProtocol {
  internal func logRequest(
    _ request: Nosy_NetworkRequest,
    callOptions: CallOptions? = nil
  ) async throws -> Nosy_RegisteredRequest {
    return try await self.performAsyncUnaryCall(
      path: Nosy_LoggerClientMetadata.Methods.logRequest.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLogRequestInterceptors() ?? []
    )
  }

  internal func logResponse(
    _ request: Nosy_NetworkResponse,
    callOptions: CallOptions? = nil
  ) async throws -> Nosy_Empty {
    return try await self.performAsyncUnaryCall(
      path: Nosy_LoggerClientMetadata.Methods.logResponse.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLogResponseInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct Nosy_LoggerAsyncClient: Nosy_LoggerAsyncClientProtocol {
  internal var channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Nosy_LoggerClientInterceptorFactoryProtocol?

  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Nosy_LoggerClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

internal protocol Nosy_LoggerClientInterceptorFactoryProtocol: Sendable {

  /// - Returns: Interceptors to use when invoking 'logRequest'.
  func makeLogRequestInterceptors() -> [ClientInterceptor<Nosy_NetworkRequest, Nosy_RegisteredRequest>]

  /// - Returns: Interceptors to use when invoking 'logResponse'.
  func makeLogResponseInterceptors() -> [ClientInterceptor<Nosy_NetworkResponse, Nosy_Empty>]
}

internal enum Nosy_LoggerClientMetadata {
  internal static let serviceDescriptor = GRPCServiceDescriptor(
    name: "Logger",
    fullName: "nosy.Logger",
    methods: [
      Nosy_LoggerClientMetadata.Methods.logRequest,
      Nosy_LoggerClientMetadata.Methods.logResponse,
    ]
  )

  internal enum Methods {
    internal static let logRequest = GRPCMethodDescriptor(
      name: "LogRequest",
      path: "/nosy.Logger/LogRequest",
      type: GRPCCallType.unary
    )

    internal static let logResponse = GRPCMethodDescriptor(
      name: "LogResponse",
      path: "/nosy.Logger/LogResponse",
      type: GRPCCallType.unary
    )
  }
}

