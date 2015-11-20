//
//  ViewController.swift
//  IceCreamShop
//
//  Created by Joshua Greene on 2/8/15.
//  Copyright (c) 2015 Razeware, LLC. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

public class PickFlavorViewController: UIViewController, UICollectionViewDelegate {
  
  // MARK: Instance Variables
  // MARK: 对数据初始化,否则需要提供一个初始化方法
  
  private var dataSource: PickFlavorDataSource? {
    return collectionView?.dataSource as! PickFlavorDataSource?
  }

  var flavors: [Flavor] = [] {
    
    didSet {
      pickFlavorDataSource?.flavors = flavors
    }
  }
  
  
  private var pickFlavorDataSource: PickFlavorDataSource? {
    return collectionView?.dataSource as! PickFlavorDataSource?
  }
  
  private let flavorFactory = FlavorFactory()
  
  // MARK: Outlets
  
  @IBOutlet var contentView: UIView!
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var iceCreamView: IceCreamView!
  @IBOutlet var label: UILabel!
  
  // MARK: View Lifecycle
  
  public override func viewDidLoad() {
    
    super.viewDidLoad()
    ///隐式解可选如果该值为nil,那么再次调用会runttime error :fatal error: unexpectedly found nil while unwrapping an Optional value
    ///这样设计有他自身的优势,1.内存管理2.明确逻辑3.比optional解包书写更方便
//    self.contentView = nil
//    self.contentView.frame = CGRectMake(1.0, 1.0, 1.0, 1.0)
    ///如果是自身方法可以省略self
    loadFlavors()
  }
  
  private func loadFlavors() {
    // TO-DO: Implement this
//    Alamofire.request(
//      .GET,
//      "http://www.raywenderlich.com/downloads/Flavors.plist",
//      parameters: nil,
//      encoding: .PropertyList(.XMLFormat_v1_0, 0),
//      headers: nil)
//      .responsePropertyList { [weak self] (_, _, result) -> Void in
//      
//    }
    showLoadingHUD()
    
    Alamofire.request(.GET, "http://www.raywenderlich.com/downloads/Flavors.plist", parameters: nil, encoding: .PropertyList(.XMLFormat_v1_0, 0), headers: nil).responsePropertyList {[weak self] (response : Response<AnyObject,NSError>) -> Void in
      
      guard let strongSelf = self else {
        return
      }
      var flavorsArray: [[String : String]]? = nil
      if response.result.isSuccess {
        if let array = response.result.value as? [[String : String]] {
          flavorsArray = array
        }
      }
      strongSelf.hideHUD()
      strongSelf.flavors = strongSelf.flavorFactory.flavorsFromDictionaryArray(flavorsArray!)
      strongSelf.collectionView.reloadData()
      strongSelf.selectFirstFlavor()
    }
  }
  
  private func showLoadingHUD() {
    let hud = MBProgressHUD.showHUDAddedTo(contentView, animated: true)
    hud.labelText = "Loading..."
  }
  
  private func hideHUD() {
    MBProgressHUD.hideHUDForView(contentView, animated: true)
  }
  
  private func selectFirstFlavor() {
    
    if let flavor = flavors.first {
      updateWithFlavor(flavor)
    }
  }
  
  // MARK: UICollectionViewDelegate
  
  public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let flavor = flavors[indexPath.row]
    updateWithFlavor(flavor)
  }
  
  // MARK: Internal
  
  private func updateWithFlavor(flavor: Flavor) {
    
    iceCreamView.updateWithFlavor(flavor)
    label.text = flavor.name
  }
}
