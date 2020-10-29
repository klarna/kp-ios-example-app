//
//  BackendOperations.swift
//  FashionStore
//
//  Copyright © 2018 Klarna Bank AB. All rights reserved.
//

import Foundation

///
/// Backend Operations:
/// Normally this would be done on your back-end, but in this example app
/// we do it here in order to demonstrate.
///
struct BackendOperations {

    // MARK: - Backend Operations

    static func createCreditSession(completionHandler: @escaping(_ clientToken: String, _ categories: [Any])->Void) {
        createDataTask(withUrlString: Constants.ApiUrl.createCreditSession) { (dictionary) in
            guard
                let dictionary = dictionary,
                let clientToken = dictionary["client_token"] as? String,
                let paymentMethodCategories = dictionary["payment_method_categories"] as? [Any]
                else {
                    print("BackendOperations createCreditSession: Could not extract information from dictionary!")
                    return
            }

            completionHandler(clientToken, paymentMethodCategories)
        }
    }

    static func createNewOrder(withAuthorizationToken authorizationToken: String, completionHandler: @escaping(_ dictionary: [String: Any]?)->Void) {
        let createNewOrderUrlString = String(format: Constants.ApiUrl.createNewOrder, authorizationToken)
        createDataTask(withUrlString: createNewOrderUrlString, completionHandler: completionHandler)
    }

}

// MARK: - Properties

extension BackendOperations {

    enum Constants {
        #warning("""
                 TODO: Please enter your Merchant credentials & API details below,
                 or create a test account.
                 See this page for more details:
                 https://developers.klarna.com/en/gb/kco-v3/klarna-payment-methods#test-account
                 """)

        enum BasicAuth {
            static let username = "<please enter here>"
            static let password = "<please enter here>"
        }

        enum Merchant {
            static let purchaseCountry = "SE"
            static let purchaseCurrency = "SEK"
            static let locale = "en-US"
        }

        enum ApiUrl {
            static let baseUrl = "https://api.playground.klarna.com/"
            static let createCreditSession = "\(Constants.ApiUrl.baseUrl)/payments/v1/sessions"
            static let createNewOrder = "\(Constants.ApiUrl.baseUrl)/payments/v1/authorizations/%@/order"
        }
    }

    static private let examplePayload: [String: Any] = [
        "purchase_country": Constants.Merchant.purchaseCountry,
        "purchase_currency": Constants.Merchant.purchaseCurrency,
        "locale": Constants.Merchant.locale,
        "order_amount": 10000,
        "order_tax_amount": 0,
        "order_lines": [
            [
                "image_url": "https://demo.klarna.se/fashion/kp/media/wysiwyg/Accessoriesbagimg.jpg",
                "type": "physical",
                "reference": "AccessoryBag-Ref-ID-0001",
                "name":"Light Brown Accessory Bag",
                "quantity": 1,
                "unit_price": 10000,
                "tax_rate": 0,
                "total_amount": 10000,
                "total_tax_amount": 0
            ]
        ]
    ]

}

// MARK: - Networking

extension BackendOperations {

    static func makeSessionConfiguration() -> URLSessionConfiguration {
        var httpAdditionalHeaders = [AnyHashable: Any]()
        httpAdditionalHeaders["Content-Type"] = "application/json; charset=utf-8"

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.httpAdditionalHeaders = httpAdditionalHeaders

        return configuration
    }

    static func makeBasicAuth() -> String? {
        let usernamePassword = String(format: "%@:%@", Constants.BasicAuth.username, Constants.BasicAuth.password)

        guard let data = usernamePassword.data(using: String.Encoding.utf8) else {
            print("Utils makeBasicAuth: Cannot encode data '\(usernamePassword)'!")
            return nil
        }

        return data.base64EncodedString()
    }

    static func makeRequestWithUrl(_ url: URL) -> URLRequest? {
        guard let basicAuth = makeBasicAuth() else {
            print("BackendOperations makeRequestWithUrl: Cannot make basic auth for url '\(url)'!")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 10
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Basic \(basicAuth)", forHTTPHeaderField: "Authorization")

        return request
    }

    static private func createDataTask(withUrlString urlString: String, completionHandler: @escaping(_ dictionary: [String: Any]?)->Void) {
        guard let url = URL(string: urlString) else {
            print("BackendOperations createDataTask: Cannot create url for '\(urlString)'!")
            return
        }

        guard JSONSerialization.isValidJSONObject(examplePayload) else {
            print("BackendOperations createDataTask: json validation failed!")
            return
        }

        guard var request = makeRequestWithUrl(url) else {
            print("BackendOperations createDataTask: Cannot make request for url '\(url)'!")
            return
        }

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: examplePayload, options: [])
        }
        catch {
            print("BackendOperations createDataTask: \(error.localizedDescription)")
            return
        }

        let session = URLSession(configuration: makeSessionConfiguration())

        let task = session.dataTask(with: request) {
            (data, response, error) in

            if let error = error {
                print("BackendOperations createDataTask: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("BackendOperations createDataTask: No data returned by task!")
                return
            }

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])

                guard let dict = jsonObject as? [String: Any] else {
                    print("BackendOperations createDataTask: json serialization failed!")
                    return
                }

                completionHandler(dict)
            }
            catch {
                print("BackendOperations createDataTask: \(error.localizedDescription)")
                return
            }
        }

        task.resume()
    }

}
