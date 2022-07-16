//
//  RequestExecutor.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonça on 02/06/22.
//

import Foundation

protocol RequestExecutor {
    func execute(request: URLRequest,
                 in session: URLSession,
                 completion: @escaping (Data?, URLResponse?, ErrorHandler.ErrorResponse?) -> Void)
}

class NetworkingRequestExecutor: RequestExecutor {
    func execute(request: URLRequest, in session: URLSession, completion: @escaping (Data?, URLResponse?, ErrorHandler.ErrorResponse?) -> Void) {
        session.dataTask(with: request) { data, response, erro in
            let error = self.checkForResponseErrors(using: data)
            self.debugResponse(request, data, response, error)
            if error == nil && data == nil {
                let err = ErrorHandler.ErrorMessage(code: "-1004", message: "Não foi possivel conectar com o servidor. host nao foi encontrado.")
                completion(data, response, ErrorHandler.ErrorResponse(errors: [err]))
                return
            }
            completion(data, response, error)
        }.resume()
        session.finishTasksAndInvalidate()
    }
    
    private func checkForResponseErrors(using data: Data?) -> ErrorHandler.ErrorResponse? {
        guard let data = data else { return nil}
        return JSONDecode(to: ErrorHandler.ErrorResponse.self, from: data)
    }
    
    func JSONDecode<T: Codable>(to object: T.Type, from data: Data) -> T? {
        do {
            let object = try JSONDecoder().decode(T.self, from: data) as T
            return object
        } catch {
            if object != ErrorHandler.ErrorResponse.self {
                #if DEBUG
                print("\n❓JSONDecoder -> \(T.self): \(error)\n")
                #endif
            }
            return nil
        }
    }
    
    private func debugResponse(_ request: URLRequest, _ responseData: Data?, _ response: URLResponse?, _ error: ErrorHandler.ErrorResponse?) {
        #if DEBUG
        let uuid = UUID().uuidString
        print("\n↗️ ======= REQUEST =======")
        print("↗️ REQUEST #: \(uuid)")
        print("↗️ URL: \(request.url?.absoluteString ?? "")")
        print("↗️ HTTP METHOD: \(request.httpMethod ?? "GET")")
        
        if let requestHeaders = request.allHTTPHeaderFields,
            let requestHeadersData = try? JSONSerialization.data(withJSONObject: requestHeaders, options: .prettyPrinted),
            let requestHeadersString = String(data: requestHeadersData, encoding: .utf8) {
            print("↗️ HEADERS:\n\(requestHeadersString)")
        }
        
        if let requestBodyData = request.httpBody,
            let requestBody = String(data: requestBodyData, encoding: .utf8) {
            print("↗️ BODY: \n\(requestBody)")
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("\n↙️ ======= RESPONSE =======")
            switch httpResponse.statusCode {
            case 200...202:
                print("↙️ CODE: \(httpResponse.statusCode) - ✅")
            case 400...505:
                print("↙️ CODE: \(httpResponse.statusCode) - 🆘")
            default:
                print("↙️ CODE: \(httpResponse.statusCode) - ✴️")
            }
            
            if let responseHeadersData = try? JSONSerialization.data(withJSONObject: httpResponse.allHeaderFields, options: .prettyPrinted),
                let responseHeadersString = String(data: responseHeadersData, encoding: .utf8) {
                print("↙️ HEADERS:\n\(responseHeadersString)")
            }
            
            if let responseBodyData = responseData,
                let responseBody =  String(data: responseBodyData, encoding: .utf8),
                !responseBody.isEmpty {
                
                print("↙️ BODY:\n\(responseBody)\n")
            }
        }
        
        print("======== END OF: \(uuid) ========\n\n")
        #endif
    }
    
}
