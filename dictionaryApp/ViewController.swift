//
//  ViewController.swift
//  dictionaryApp
//
//  Created by Yo on 2/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Lifecycle
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    
    let words = [
        ["Apple", "Pear", "Watermelon"],
        ["Carrot", "Pickle", "Potato", "Tomato"],
        ["Strawberry", "Raspberry", "Blackberry", "Blueberry"]
    ]
    
    let headers = ["Fruit", "Vegetables", "Berry"] //  создаем массив с заголовками
    
    
    // MARK: - Override
    
    
    override func viewDidLoad() {
        tableView.sectionHeaderHeight = 32 // изменяем высоту хедера, чтобы в него помещались названия
        tableView.dataSource = self // устанавливаем связь с DataSourse, где self это контроллер, который должен выступать как датаСорс
        tableView.delegate = self // устанавливаем связь с Delegate, где self это контроллер, который должен выступать как делегат
        super.viewDidLoad()
        
    }
}


// MARK: - Extension


@available(iOS 14.0, *)
extension ViewController: UITableViewDataSource { // в этом расширении используем методы dataSource
    
    func numberOfSections(in tableView: UITableView) -> Int { // метод чтобы узнать сколько будет секций
        return words.count //  words — это массив, хранящий другие массивы, то число секций — это количество элементов (самих массивов) в words. Поэтому мы и возвращаем words.count, которое равно двум
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // метод чтобы таблица знала сколько будет ячеек в секции
        let vegOrFruitArray = words[section] // получили массив по номеру секции
        return vegOrFruitArray.count // вернули количество элементов в нём
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // в этом методе создаем ячейку, наполняем данными и передаем таблице
        let cell: UITableViewCell // не инициализированная константа. В нее сохраним ячейку, которую будем настраивать и возвращать таблице
        
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "textCell") {
            cell = reusedCell // чтобы не создавать новую ячейку с текстом мы переиспользуем старую и присваиваем ее к cell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "textCell") // если по каким либо причинам переиспользовать ячейку не удалось и dequeueReusableCell вернул nil то мы создаем новую ячейку с идентификатором textCell
        }
        
        cell.selectionStyle = .blue // делаем голубой цвет ячейки (но можнно это сделать в сториборде)
        
        // добавляем контент для ячейки
        var content = cell.defaultContentConfiguration()
        content.text = words[indexPath.section][indexPath.row] //  получаем элемент по номеру секции и номеру ячейки
        cell.contentConfiguration = content
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // в этом методе заполняем данным заголовок секции
        return headers[section]
    }
}



extension ViewController: UITableViewDelegate { // в этом расширении используем методы делегата
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // метод сообщить делегату, что строка выбрана
        tableView.deselectRow(at: indexPath, animated: true) // при выборе ячейки она окрашивается в серый цвет. После нажатия на ячейку эту подсветку нужно скрыть
        // при назатии на ячейку мы будем выводить алерт, который отобразит слово что мы нажали и кнопку "ОК"
        let alert = UIAlertController(title: nil, // создаем сам алерт и все отображение в нем
                                      message: "Вы нажали на \(words[indexPath.section][indexPath.row])",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", // создаем кнопку ОК
                                     style: .default) { _ in
            alert.dismiss(animated: true) // нажимая на кнопку ОК мы закрываем алерту
        }
        alert.addAction(okAction) // отображаем кнопку в алерте
        present(alert, animated: true) // отображаем алерт
    }
    
}
