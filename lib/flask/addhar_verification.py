from flask import Flask, request, jsonify
import cv2
import numpy as np

app = Flask(__name__)

# Initialize the face detection model
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

# Function to detect faces and return keypoints and descriptors using SIFT
def detect_face_keypoints(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5)

    sift = cv2.SIFT_create()
    keypoints_list = []
    descriptors_list = []

    for (x, y, w, h) in faces:
        face = gray[y:y+h, x:x+w]
        keypoints, descriptors = sift.detectAndCompute(face, None)
        keypoints_list.append(keypoints)
        descriptors_list.append(descriptors)

    return faces, keypoints_list, descriptors_list

@app.route('/api/face_similarity', methods=['POST'])
def face_similarity():
    try:
        # Get images from the request
        image_data1 = request.files['image1'].read()
        image_data2 = request.files['image2'].read()

        # Decode the images
        image1 = cv2.imdecode(np.frombuffer(image_data1, np.uint8), cv2.IMREAD_COLOR)
        image2 = cv2.imdecode(np.frombuffer(image_data2, np.uint8), cv2.IMREAD_COLOR)

        # Detect keypoints and descriptors for faces in both images
        faces1, keypoints1, descriptors1 = detect_face_keypoints(image1)
        faces2, keypoints2, descriptors2 = detect_face_keypoints(image2)

        # Check if faces are detected in both images
        if not keypoints1 or not keypoints2:
            return jsonify({'result': 'No face detected in one or both images'})

        # Initialize keypoint matcher
        matcher = cv2.BFMatcher()

        # Match descriptors
        matches = matcher.knnMatch(descriptors1[0], descriptors2[0], k=2)  # Assuming there's only one face in each image

        # Apply ratio test to find good matches
        good_matches = []
        for m, n in matches:
            if m.distance < 0.75 * n.distance:
                good_matches.append(m)

        # Minimum number of matches for similarity
        min_matches = 2  # Adjust this based on the number of matches you want to consider

        if len(good_matches) > min_matches:
            result = {'result': 'Similarity in facial features detected'}
        else:
            result = {'result': 'No significant similarity in facial features'}

        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
