//
//  SDKIntegration.swift
//  FashionStore
//
//  Copyright © 2018 Klarna Bank AB. All rights reserved.
//

import UIKit

import KlarnaMobileSDK

///
/// SDK Integration:
/// Demonstrates how to initialize the Klarna Payments SDK and implement its delegates.
///
final class SDKIntegration {

    // MARK: - Properties

    weak var viewControllerDelegate: ViewControllerDelegate?

    private(set) var paymentView: KlarnaPaymentView?

    private var authorizationToken: String?
    private var clientToken: String?
    private var categories = [String]()
    private var currentCategoryIndex = 0  // start with first category

    // MARK: - Backend Operations

    func createCreditSession() {
        BackendOperations.createCreditSession { [weak self] (clientToken, categories) in
            guard let self = self else {
                fatalError("`self` does not exist!")
            }

            print("\(self.categories.count) payment method categories returned")

            self.clientToken = clientToken
            self.categories = self.extractCategories(categories)

            self.createPaymentView()
        }
    }

    func createNewOrder(completionHandler: @escaping ()->Void) {
        guard let authorizationToken = authorizationToken else {
            print("SDKIntegration createNewOrder: Authorization token does not exist!")
            return
        }

        BackendOperations.createNewOrder(withAuthorizationToken: authorizationToken) { dictionary in
            guard
                let dictionary = dictionary,
                let fraudStatus = dictionary["fraud_status"] as? String, fraudStatus == "ACCEPTED"
                else {
                    print("Failed when creating a new order and extracting dictionary!")
                    return
            }

            // success, the order was created 🎉
            completionHandler()
        }
    }

    // MARK: - Payment View

    private func createPaymentView() {
        guard let clientToken = clientToken else {
            print("SDKIntegration createPaymentView: Client token was not set!")
            return
        }

        guard !categories.isEmpty else {
            print("SDKIntegration createPaymentView: No payment method categories returned!")
            return
        }

        let category = self.categories[currentCategoryIndex]

        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                fatalError("`self` does not exist!")
            }
            self.paymentView = KlarnaPaymentView(clientToken: clientToken,
                                                 category: category,
                                                 returnUrl: "kpFashionStore://",
                                                 delegate: self)
        }
    }

    func removePaymentView() {
        if let paymentView = paymentView {
            paymentView.removeFromSuperview()
        }
    }

    // MARK: - Category

    func nextCategory() {
        // next category, or restart from beginning
        currentCategoryIndex += 1
        if currentCategoryIndex > (categories.count-1) {
            currentCategoryIndex = 0
        }

        self.removePaymentView()
        self.createPaymentView()
    }

    private func extractCategories(_ categories: [Any]) -> [String] {
        var availableCategories = [String]()

        for element in categories {
            if let categoryDictionary = element as? [String: Any],
                let categoryIdentifier = categoryDictionary["identifier"] as? String {
                availableCategories.append(categoryIdentifier)
            }
            else {
                print("SDKIntegration extractCategories: Could not extract category from dictionary!")
            }
        }

        return availableCategories
    }

}

// MARK: - KlarnaPaymentViewDelegate

extension SDKIntegration: KlarnaPaymentViewDelegate {

    func klarnaPaymentViewInitialized(_ paymentView: KlarnaPaymentView) {
        paymentView.load()
    }

    func klarnaPaymentViewLoaded(_ paymentView: KlarnaPaymentView) {
        viewControllerDelegate?.displayPaymentView()
    }

    func klarnaPaymentView(_ paymentView: KlarnaPaymentView, approved: Bool?, authorizedWithToken authToken: String?, finalizeRequired: Bool?) {
        authorizationToken = authToken
    }

    func klarnaPaymentView(_ paymentView: KlarnaPaymentView, approved: Bool?, reauthorizedWithToken authToken: String?) {
        authorizationToken = authToken
    }

    func klarnaPaymentView(_ paymentView: KlarnaPaymentView, approved: Bool?, finalizedWithToken authToken: String?) {
        authorizationToken = authToken
    }

    func klarnaPaymentView(_ paymentView: KlarnaPaymentView, resizedToHeight height: CGFloat) {
        print("KlarnaPaymentViewDelegate paymentView resizedToHeight: \(height)")
    }

    func klarnaPaymentView(_ paymentView: KlarnaPaymentView, failedWithError error: KlarnaPaymentsError) {
        print("KlarnaPaymentViewDelegate paymentView failedWithError: \(error.debugDescription)")
    }

}
