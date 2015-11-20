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
  
  // MARK:响应头
  var responseHeader: [String : String]? { get set }
  // MARK:响应头的状态值
  var responseStatus: Int { get }
  // MARK:响应头
  
  // MARK:响应的解析对象
  var responseSerializer: Alamofire.ResponseSerializer { get }
  
}
