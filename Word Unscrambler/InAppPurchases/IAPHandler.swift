import Foundation
import StoreKit
import KeychainAccess

enum IAPHandlerAlertType {
    case setProductIds
    case disabled
    case restored
    case purchased

    var message: String {
        switch self {
        case .setProductIds:
            return "Product ids not set, call setProductIds method!"
        case .disabled:
            return "Purchases are disabled in your device!"
        case .restored:
            return "You've successfully restored your purchase"
        case .purchased:
            return "You've successfully bought this purchase"
        }
    }
}

class IAPHandler: NSObject {

    static let instance = IAPHandler()
    private override init() { }

    fileprivate var productIds: [String] = Default.IAP_PRODUCT_IDS
    fileprivate var productId = ""
    fileprivate var products = [SKProduct]()
    fileprivate var productRequest = SKProductsRequest()
    fileprivate var fetchProductCompletion: (([SKProduct]) -> Void)?
    fileprivate let firebaseEvents = FirebaseEvents()

    fileprivate var productToPurchase: SKProduct?
    fileprivate var purchaseProductCompletion: ((IAPHandlerAlertType, SKProduct?, SKPaymentTransaction?) -> Void)?

    func setProductIds(ids: [String]) {
        self.productIds = ids
    }

    func setProducts(products: [SKProduct]) {
        self.products = products
        print(products)
    }
    
    func getDisableAdsProduct() -> SKProduct? {
        guard let product = products.first else { return nil }
        if product.productIdentifier == Default.IAP_PRODUCT_IDS.first {
            return product
        }
        return nil
    }

    func canMakePurchases() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }

    func purchase(product: SKProduct, completion: @escaping (IAPHandlerAlertType, SKProduct?, SKPaymentTransaction?) -> Void) {
        self.purchaseProductCompletion = completion
        self.productToPurchase = product
        firebaseEvents.logStartPurchaseOfDisableAds()
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)

            print("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productId = product.productIdentifier
        } else {
            firebaseEvents.logIAPDisabledOnDevice()
            completion(.disabled, nil, nil)
        }
    }

    private func savePurchasedItemToKeychain(identifier: String?) {
        guard let identifier = identifier else { return }
        let keychain = Keychain(service: Default.KEYCHAIN_SERVICE_NAME)
        do {
            try keychain.set("purchased", key: identifier)
            firebaseEvents.logSavePurchasedItemToKeychain(productId: identifier)
        } catch let error {
            print("setting keychain to purchased failed")
            print("error")
            firebaseEvents.logFailedToSavePurchasedItemToKeychain(productId: identifier, error: error)
        }
    }

    public func isProductPurchased(_ productIdentifier: String) -> Bool {
        firebaseEvents.logCheckIfAdsDisabled()
        let keychain = Keychain(service: Default.KEYCHAIN_SERVICE_NAME)
        if let hasPurchased = try? keychain.get(productIdentifier) {
            return true
        } else {
            return false
        }
    }

    func restorePurchase() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func fetchAvailableProducts(completion: @escaping ([SKProduct]) -> Void) {
        self.fetchProductCompletion = completion
        if self.productIds.isEmpty {
            print(IAPHandlerAlertType.setProductIds.message)
            fatalError(IAPHandlerAlertType.setProductIds.message)
        } else {
            productRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
            productRequest.delegate = self
            productRequest.start()
        }
    }
}

extension IAPHandler: SKProductsRequestDelegate, SKPaymentTransactionObserver {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (response.products.count > 0) {
            if let completion = self.fetchProductCompletion {
                completion(response.products)
            }
        }
    }

    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if let completion = self.purchaseProductCompletion {
            completion(.restored, nil, nil)
        }
    }

    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction: AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    print("Product purchase done")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if let completion = self.purchaseProductCompletion {
                        completion(.purchased, self.productToPurchase, trans)
                    }
                    savePurchasedItemToKeychain(identifier: transaction.productIdentifier)
                    firebaseEvents.logIAPDisableAdsProductPurchased()
                    break
                case .failed:
                    print("Product purchase failed")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    firebaseEvents.logIAPDisableAdsProductPurchaseFailed()
                    break
                case .restored:
                    print("Product restored")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                default:
                    break
                }
            }
        }
    }
}