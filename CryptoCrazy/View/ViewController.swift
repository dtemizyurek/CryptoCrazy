//
//  ViewController.swift
//  CryptoCrazy
//
//  Created by Doğukan Temizyürek on 27.07.2023.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self
        self.colorArray = [ UIColor(red: 120/255, green: 130/255, blue: 160/255, alpha: 1.0),
                            UIColor(red: 200/255, green: 110/255, blue: 130/255, alpha: 1.0),
                            UIColor(red: 220/255, green: 120/255, blue: 90/255, alpha: 1.0),
                            UIColor(red: 180/255, green: 110/255, blue: 70/255, alpha: 1.0),
                            UIColor(red: 190/255, green: 200/255, blue: 180/255, alpha: 1.0),
                            UIColor(red: 140/255, green: 160/255, blue: 190/255, alpha: 1.0)]
        
        getData()
        
    }
    
    func getData()
    {
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        Webservice().downloadCurrencies(url: url) { (cryptos) in
            if let cryptos = cryptos
            {
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList : cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell"  , for : indexPath) as! CryptoTableViewCell
        
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        
        return cell

    }


}

