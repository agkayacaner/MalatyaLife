//
//  UploadImage.swift
//  MalatyaLife
//
//  Created by Caner Ağkaya on 16.01.2024.
//

import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImages(_ images: [UIImage]) async throws -> [String] {
        var urls = [String]()
        for image in images {
            let imageSize = image.jpegData(compressionQuality: 1)?.count ?? 0 /// get the size of the image
            var compressionQuality: CGFloat = 0.8 /// default compression quality
            
            if imageSize < 500000 { /// if the image size is less than 500KB
                compressionQuality = 1 /// no compression
            } else if imageSize > 3000000 { /// if the image size is more than 3MB
                compressionQuality = max(0.8, 0.5) /// higher compression
            }
            guard let imageData = image.jpegData(compressionQuality: compressionQuality) else { continue }
            // guard let imageData = image.jpegData(compressionQuality: 0.8) else { continue }
            let fileName = NSUUID().uuidString
            let storageRef = Storage.storage().reference(withPath: "/business_images/\(fileName)")
            
            do {
                let _ = try await storageRef.putDataAsync(imageData)
                let url = try await storageRef.downloadURL()
                urls.append(url.absoluteString)
            } catch {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
            }
        }
        return urls
    }
}


// Tek Bir Görsel  Yüklemek İçin

//struct ImageUploader {
//    static func uploadImage(_ image: UIImage) async throws -> String? {
//        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return nil }
//        let fileName = NSUUID().uuidString
//        let storageRef = Storage.storage().reference(withPath: "/business_images/\(fileName)")
//
//        do {
//            let _ = try await storageRef.putDataAsync(imageData)
//            let url = try await storageRef.downloadURL()
//            return url.absoluteString
//        } catch {
//            print("DEBUG: Failed to upload image \(error.localizedDescription)")
//            return nil
//        }
//    }
//}

