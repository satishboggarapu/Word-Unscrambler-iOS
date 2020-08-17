import UIKit
import SnapKit
import WebKit

class WebDefinitionCollectionViewCell: UICollectionViewCell {

    // MARK: UIElements
    private var cardView: UIView!
    private var infoBar: UIView!
    public var title: UILabel!
    public var webView: WKWebView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        cardView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(16)
            maker.right.equalToSuperview().inset(16)
            maker.top.equalToSuperview().offset(16)
            maker.bottom.equalToSuperview().inset(16)
        }

        infoBar.snp.makeConstraints { maker in
            maker.left.top.right.equalToSuperview()
            maker.height.equalTo(52)
        }

        title.snp.makeConstraints { maker in
            maker.top.bottom.left.right.equalToSuperview()
        }

        webView.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(1)
            maker.right.equalToSuperview().inset(1)
            maker.bottom.equalToSuperview()
            maker.top.equalTo(infoBar.snp.bottom)
        }

    }

    override func setupView() {
        cardView = UIView()
        cardView.backgroundColor = .white
        cardView.addShadow(cornerRadius: 4)
        addSubview(cardView)

        infoBar = UIView()
        infoBar.backgroundColor = .app
        infoBar.addShadow(cornerRadius: 0)
        cardView.addSubview(infoBar)

        title = UILabel()
        title.textColor = .white
        title.textAlignment = .center
        infoBar.addSubview(title)

        webView = WKWebView()
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        cardView.addSubview(webView)
    }

    public func refreshView(webDefinition: WebDefinitions, word: String) {
        title.text = webDefinition.title
//        image.image = webDefinition.image
        webView.load(URLRequest(url: URL(string: "\(webDefinition.url)\(word)")!))
    }
}

extension WebDefinitionCollectionViewCell: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // TODO: Loading spinner while loading
    }
}