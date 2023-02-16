//
//  Router.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit

public class Router {
    public func perform(_ behavior: RouteBehavior, from source: UIViewController) {
        
        switch behavior {
        case let .show(target, displayContext, configuration):
            target.displayContext = displayContext
            displayContext.display(target)
            configuration?(source, target)
        case let .close(target):
            target.displayContext?.undisplay()
        case .custom:
            break
        }
    }
    
}

public protocol RoutableViewController: UIViewController {
    var displayContext: UIDisplayContext? { get set }
}

public enum RouteBehavior {
    case show(target: RoutableViewController,
              displayContext: UIDisplayContext,
              configuration: ((Any, Any) -> Void)? = nil)
    case close(target: RoutableViewController)
    case custom
}

public struct UIDisplayContext {
    public func display(_ viewController: UIViewController) {
        
    }
    
    public func undisplay() {
        
    }
    
    public weak var sourceViewController: UIViewController?
    public var method: DisplayMethod
    
    public enum DisplayMethod {
        case present(animated: Bool)
        case push(animated: Bool)
        case embed(over: UIView? = nil)
        case custom(userInfo: Any)
    }
}
