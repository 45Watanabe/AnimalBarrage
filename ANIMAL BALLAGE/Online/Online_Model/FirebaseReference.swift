//
//  FirebaseReference.swift
//  ANIMAL BALLAGE
//
//  Created by 渡辺幹 on 2022/04/13.
//

import Firebase

enum FCollectionReference: String {
    case Game
}


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
