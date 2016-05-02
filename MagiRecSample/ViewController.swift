//
//  ViewController.swift
//  MagiRecSample
//
//  Created by Hayashidesu. on 2016/05/02.
//  Copyright © 2016年 Hayashidesu. All rights reserved.
//

import UIKit
import MagicalRecord

class ViewController: UIViewController {

    @IBOutlet weak var txtMemo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtMemo.text = readData()
    }

    @IBAction func pressSaveButton(sender: UIButton) {
        writeData(txtMemo.text!)
    }
    
    
    @IBAction func pressDeleteButton(sender: UIButton) {
        txtMemo.text = nil
        deleteData()
    }
    
    // データ登録/更新
    func writeData(txtMemo: String) -> Bool{
        var ret = false
        
        let memoList = Memo.MR_findAll()
        if memoList!.count > 0 {
            // 検索して見つかったらアップデートする
            let memo = memoList![0] as! Memo
            print("UPDATE \(memo.text) TO \(txtMemo)")
            memo.text = txtMemo
            memo.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            ret = true
        }else{
            // 見つからなかったら新規登録
            let memo: Memo = Memo.MR_createEntity()! as Memo
            memo.text = txtMemo
            print("INSERT \(memo.text)")
            memo.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            ret = true
        }
        return ret
    }
    
    // データ読み込み
    func readData() -> String{
        var ret = ""
        
        let memoList = Memo.MR_findAll()
        if memoList!.count > 0 {
            // 検索して見つかったら先頭の1件だけ読み込む
            let memo = memoList![0] as! Memo
            ret = memo.text!
            print("READ:\(ret)")
        }
        return ret
    }
    
    // データ削除
    func deleteData() -> Bool {
        var ret = false
        
        let memoList = Memo.MR_findAll()
        if memoList!.count > 0 {
            // 検索して見つかったら削除
            let memo = memoList![0] as! Memo
            print("DELETE:\(memo.text)")
            memo.MR_deleteEntity()
            memo.managedObjectContext!.MR_saveToPersistentStoreAndWait()
            ret = true
        }
        return ret
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

