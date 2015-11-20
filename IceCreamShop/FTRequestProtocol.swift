//
//  FTRequestProtocol.swift
//  IceCreamShop
//
//  Created by user on 11/20/15.
//  Copyright © 2015 Razeware, LLC. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveCocoa

protocol FTRequestProtocol {
  // MARK:请求的host
  var requestHost: String! { get }
  // MARK:请求的路径
  var requestAPIPath: String! { get }
  // MARK:请求方法
  var requestMethod: Alamofire.Method { get }
  // MAKR:请求encodingType
  var requestEncodingType: Alamofire.ParameterEncoding { get }
  // MARK:请求header
  var requestHeaders: [String : String]? { get }
  // MARK:请求参数 如果是GET则会拼接到URL,如果是POST则会根据encoding来做处理放到请求体
  var requestParam: [String : AnyObject]? { get }
  // MARK:请求体其他数据
  var requestBody: NSData? { get }
  // MARK:请求对象所在的manager,默认在defaultManager
  var requestSessionManager: Alamofire.Manager! { get }
  // MARK:开始请求
  func startRequest() -> RACSignal
}









