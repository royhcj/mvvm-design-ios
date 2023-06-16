//
//  BasicLoggerPlugin.swift
//  CleanArcDesign
//
//  Created by Roy on 2023/2/17.
//

import Foundation
import Alamofire
import Moya


/// Logs network activity (outgoing requests and incoming responses).
public final class BasicNetworkLoggerPlugin: PluginType {
    fileprivate let loggerId = "Urfitness API"
    fileprivate let dateFormatString = "yyyy/MM/dd(eee) HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = ", "
    fileprivate let terminator = "\n"
    fileprivate let cURLTerminator = "\\\n"
    fileprivate let output: (_ separator: String, _ terminator: String, _ items: Any...) -> Void
    fileprivate let requestDataFormatter: ((Data) -> (String))?
    fileprivate let responseDataFormatter: ((Data) -> (Data))?

    /// A Boolean value determing whether response body data should be logged.
    public let isVerbose: Bool
    public let cURL: Bool

    /// Initializes a NetworkLoggerPlugin.
    public init(verbose: Bool = false, cURL: Bool = false, output: ((_ separator: String, _ terminator: String, _ items: Any...) -> Void)? = nil, requestDataFormatter: ((Data) -> (String))? = nil, responseDataFormatter: ((Data) -> (Data))? = nil) {
        self.cURL = cURL
        self.isVerbose = verbose
        self.output = output ?? BasicNetworkLoggerPlugin.reversedPrint
        self.requestDataFormatter = requestDataFormatter
        self.responseDataFormatter = responseDataFormatter
    }

    public func willSend(_ request: RequestType, target: TargetType) {
        var cURLString: String?
        if let request = request as? Request, cURL {
            cURLString = request.getCurlRepresentation()
            //output(separator, terminator, request.debugDescription)
            //return
        }
        outputItems(logNetworkRequest(request.request as URLRequest?, cURL: cURLString))
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            outputItems(logNetworkResponse(response, data: response.data, target: target))
        } else {
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
    }

    fileprivate func outputItems(_ items: [String]) {
        if isVerbose {
            items.forEach { output(separator, terminator, $0) }
        } else {
            output(separator, terminator, items)
        }
    }
}

private extension BasicNetworkLoggerPlugin {

    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }

    func format(_ loggerId: String, date: String, identifier: String, message: String) -> String {
        return "\(loggerId): [\(date)] \(identifier): \(message)"
    }

    func logNetworkRequest(_ request: URLRequest?, cURL: String?) -> [String] {

        var output = [String]()

        output += ["API ⬆ \(request?.httpMethod ?? "UnknownMethod ") \(request?.url?.absoluteString ?? "")"]
        
        output += [cURL ?? "No cURL"]
        
        /*
        if let headers = request?.allHTTPHeaderFields {
            output += [format(loggerId, date: date, identifier: "Request Headers", message: headers.description)]
        }

        if let bodyStream = request?.httpBodyStream {
            output += [format(loggerId, date: date, identifier: "Request Body Stream", message: bodyStream.description)]
        }

        if let httpMethod = request?.httpMethod {
            output += [format(loggerId, date: date, identifier: "HTTP Request Method", message: httpMethod)]
        }

        if let body = request?.httpBody, let stringOutput = requestDataFormatter?(body) ?? String(data: body, encoding: .utf8), isVerbose {
            output += [format(loggerId, date: date, identifier: "Request Body", message: stringOutput)]
        }
         */
        return output
    }

    func logNetworkResponse(_ moyaResponse: Moya.Response?, data: Data?, target: TargetType) -> [String] {
        guard let response = moyaResponse?.response else {
           return [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
        }

        var output = [String]()
        output += ["API ⬇ \(moyaResponse?.request?.httpMethod ?? "UnknownMethod ") \(moyaResponse?.request?.url?.absoluteString ?? "") (\(response.statusCode))"]
        //output += [format(loggerId, date: date, identifier: "API Response", message: moyaResponse?.request?.url?.absoluteString ?? "")]

        if let data = data, let stringData = String(data: responseDataFormatter?(data) ?? data, encoding: String.Encoding.utf8), isVerbose {
            output += [stringData]
        }

        return output
    }
}

fileprivate extension BasicNetworkLoggerPlugin {
    static func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            print(item, separator: separator, terminator: terminator)
        }
    }
}

fileprivate extension Request {
    func getCurlRepresentation() -> String {
        var components = ["$ curl -v"]

        guard let request = self.request,
              let url = request.url,
              let _ = url.host
        else {
            return "$ curl command could not be created"
        }

        if let httpMethod = request.httpMethod, httpMethod != "GET" {
            components.append("-X \(httpMethod)")
        }

        /* Skip credentials to ignore warnings.
        if let credentialStorage = self.session.configuration.urlCredentialStorage {
            let protectionSpace = URLProtectionSpace(
                host: host,
                port: url.port ?? 0,
                protocol: url.scheme,
                realm: host,
                authenticationMethod: NSURLAuthenticationMethodHTTPBasic
            )

            if let credentials = credentialStorage.credentials(for: protectionSpace)?.values {
                for credential in credentials {
                    guard let user = credential.user, let password = credential.password else { continue }
                    components.append("-u \(user):\(password)")
                }
            } else {
                if let credential = delegate.credential, let user = credential.user, let password = credential.password {
                    components.append("-u \(user):\(password)")
                }
            }
        }
         */

        /* Skip since session no longer accessible in Alamofire 5.x.x
        if session.configuration.httpShouldSetCookies {
            if
                let cookieStorage = session.configuration.httpCookieStorage,
                let cookies = cookieStorage.cookies(for: url), !cookies.isEmpty
            {
                let string = cookies.reduce("") { $0 + "\($1.name)=\($1.value);" }

            #if swift(>=3.2)
                components.append("-b \"\(string[..<string.index(before: string.endIndex)])\"")
            #else
                components.append("-b \"\(string.substring(to: string.characters.index(before: string.endIndex)))\"")
            #endif
            }
        }
         

        session.configuration.httpAdditionalHeaders?.filter {  $0.0 != AnyHashable("Cookie") }
                                                    .forEach { headers[$0.0] = $0.1 }
         */
        
        var headers: [AnyHashable: Any] = [:]

        request.allHTTPHeaderFields?.filter { $0.0 != "Cookie" }
                                    .forEach { headers[$0.0] = $0.1 }

        components += headers.map {
            let escapedValue = String(describing: $0.value).replacingOccurrences(of: "\"", with: "\\\"")

            return "-H \"\($0.key): \(escapedValue)\""
        }

        if let httpBodyData = request.httpBody, let httpBody = String(data: httpBodyData, encoding: .utf8) {
            var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
            escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")

            components.append("-d \"\(escapedBody)\"")
        }

        components.append("\"\(url.absoluteString)\"")

        return components.joined(separator: " \\\n\t")
    }
}

