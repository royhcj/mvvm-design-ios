//
//  Router.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/16.
//

import UIKit

public class Router {
    public init() {
    }
    
    public func perform(_ behavior: RouteBehavior, from source: UIViewController) {
        
        switch behavior {
        case let .show(target, displayContext, configuration):
            target.displayContext = displayContext
            displayContext.display(target)
            configuration?(source, target)
        case let .close(target):
            target.displayContext?.undisplay(target)
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
    public init(sourceViewController: UIViewController?, method: UIDisplayContext.DisplayMethod) {
        self.sourceViewController = sourceViewController
        self.method = method
    }
    
    
    
    public func display(_ viewController: UIViewController) {
        switch method {
        case let .present(animated, presentationStyle):
            viewController.modalPresentationStyle = presentationStyle
            sourceViewController?.present(viewController, animated: animated)
        case let .push(animated):
            if let navigationController = sourceViewController as? UINavigationController
                ?? sourceViewController?.navigationController {
                navigationController.pushViewController(viewController, animated: animated)
            }
        case let .embed(view):
            guard let sourceViewController = sourceViewController else {
                return
            }
            
            let sourceView = view ?? sourceViewController.view
            if let nc = sourceViewController as? UINavigationController,
               sourceViewController.tabBarController != nil {
                // Fix a problem of extra gap to bottom when embedding navigation controllors
                nc.children.forEach { $0.extendedLayoutIncludesOpaqueBars = true }
            }
            
            sourceViewController.embed(viewController, over: sourceView)
            
            
        case .custom(_):
            fatalError("Unimplemented for this demo")
        }
        

    }
    
    public func undisplay(_ viewController: UIViewController) {
        switch method {
        case .present(let animated, _):
            if viewController.presentedViewController != nil {
                viewController.dismiss(animated: false, completion: nil)
            }
            
            
            viewController.dismiss(animated: animated, completion: nil)
            

        case .push(let animated):
            if viewController.presentedViewController != nil { // dismiss presented children first
                viewController.dismiss(animated: false, completion: nil)
            }

            if let navigationController = sourceViewController as? UINavigationController
                                                  ?? sourceViewController?.navigationController {
                if navigationController.topViewController == viewController {
                    navigationController.popViewController(animated: animated)
                } else if let index = navigationController.viewControllers.firstIndex(of: viewController),
                          index >= 1 {
                    navigationController.popToViewController(
                        navigationController.viewControllers[index-1],
                        animated: animated)
                }
            }
        case .embed(_):
            if viewController.presentedViewController != nil { // dismiss presented children first
                viewController.dismiss(animated: false, completion: nil)
            }
            
            viewController.unembedFromParent()

//            viewController.removeFromParent()
//            viewController.view.removeFromSuperview()
//            viewController.didMove(toParent: nil)
//        case .appendToTabBarController(let source):
//            guard let source = source as? UITabBarController else { break }
//            var viewControllers = source.viewControllers ?? []
//            if let index = viewControllers.firstIndex(of: source) {
//                viewControllers.remove(at: index)
//                source.viewControllers = viewControllers
//            }
        case .custom(_):
            fatalError("Unimplemented for demo")
        }
    }
    
    public weak var sourceViewController: UIViewController?
    public var method: DisplayMethod
    
    public enum DisplayMethod {
        case present(animated: Bool, presentationStyle: UIModalPresentationStyle = .fullScreen)
        case push(animated: Bool)
        case embed(over: UIView? = nil)
        case custom(userInfo: Any)
    }
}
