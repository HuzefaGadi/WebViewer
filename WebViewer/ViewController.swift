//
//  ViewController.swift
//  WebViewer


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView?
    @IBOutlet weak var activityIndocator: UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndocator?.isHidden = isSpinnerDisabled
        
        webView?.scrollView.bounces = false
        
        let path = String(format: "%@", arguments: [kWebUrl])
        print("\(path)")
        
        if let url = NSURL(string: path) {
            self.activityIndocator?.startAnimating()
            DispatchQueue.main.async { [weak self] in
                self?.webView?.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    private func updateUI() {
//        if self.navigationController?.navigationBar
//    }
}

extension ViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("pdf loaded successfully")
        self.activityIndocator?.stopAnimating()
        self.activityIndocator?.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityIndocator?.stopAnimating()
        self.activityIndocator?.isHidden = true
        let alertController = UIAlertController(title: "Error", message:
            "Unable to load data.\nPlease try again later.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}
