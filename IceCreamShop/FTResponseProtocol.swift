//
//  FTResponseProtocol.swift
//  IceCreamShop
//
//  Created by user on 11/20/15.
//  Copyright © 2015 Razeware, LLC. All rights reserved.
//

import Foundation
import Alamofire

protocol FTResponseProtocol {
  // MARK:解析响应头
  func parseResponseHeader(responseHeader responseHeader: [String: String]?) -> AnyObject
  // MARK:响应头
  var responseHeader: [String : String]? { get set }
  // MARK:响应头的状态值
  var responseHeaderStatus: Int { get set }
  // MARK:响应的解析对象
  var responseSerializer: Alamofire.ResponseSerializer { get }
  // MARK:解析responseObject
  func parseResponseObject(responseObject responseObject: AnyObject!) -> AnyObject
  // MARK:解析responseObjectStatus
  var responseObjectStatus: Int { get set }
  
}
