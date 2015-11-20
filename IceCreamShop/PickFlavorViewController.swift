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
import ReactiveCocoa

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
    
//    let signal = UITextField(frame: CGRectZero).rac_textSignal()
//    signal.subscribeNext { (x: AnyObject!) -> Void in
//      
//    }
    let signal = RACSignal.createSignal { (subscriber: RACSubscriber!) -> RACDisposable! in
      let request = Alamofire.request(.GET, "http://www.raywenderlich.com/downloads/Flavors.plist", parameters: nil, encoding: .PropertyList(.XMLFormat_v1_0, 0), headers: nil).responsePropertyList(completionHandler: { (response: Response<AnyObject, NSError>) -> Void in
        if response.result.isSuccess {
          subscriber.sendNext(response.result.value!)
        }
        if response.result.isFailure {
          subscriber.sendError(response.result.error!)
        }
        subscriber.sendCompleted()
      })
      return RACDisposable(block: {() -> Void in
        request.cancel()
      })
    }
    signal.subscribeNext { (x: AnyObject!) -> Void in
      print(x)
    }

//     let signal = RACSignal.createSignal {[weak self] (subscriber: RACSubscriber!) -> RACDisposable! in
//      
//        Alamofire.request(.GET, "http://www.raywenderlich.com/downloads/Flavors.plist", parameters: nil, encoding: .PropertyList(.XMLFormat_v1_0, 0), headers: nil).responsePropertyList {[weak subscriber] (response : Response<AnyObject,NSError>) -> Void in
//          subscriber?.sendNext(response as! AnyObject)
//        }
//     }
//      signal.subscribeNext{[weak self] (x: AnyObject) -> Void in
//
//      }
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
