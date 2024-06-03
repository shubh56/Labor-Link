from dotenv import load_dotenv
load_dotenv()

from flask import Flask, jsonify, request
from flask_restful import Api
from flask_cors import CORS
from resources.Verification import WorkerVerification
from resources.Post import (Hashtags, Caption)
from resources.getWorkerType import (CategoryDetection)
from resources.Notification import Notification
import requests
import json
import time

app = Flask(__name__)
api = Api(app)
CORS(app)


# APIs
api.add_resource(Hashtags, "/hashtag")
api.add_resource(Caption, "/caption")
api.add_resource(Notification, '/notification')
api.add_resource(WorkerVerification, '/verification')
api.add_resource(CategoryDetection, '/getWorkerType')
# api.add_resource(CategoryText, '/getWorkerTypeText')



# post on instagram

def upload_media(media_url, media_type, access_token, insta_user_id, caption):
    post_url = "https://graph.facebook.com/v19.0/{}/media".format(insta_user_id)
    
    payload = {
        'media_type': media_type,
        'caption': caption
    }

    if media_type == 'IMAGE':
        payload['image_url'] = media_url
    elif media_type == 'REELS':
        payload['video_url'] = media_url
    else:
        print("Invalid media type. Supported types are 'IMAGE' and 'REELS'.")
        return None
    
    

    r = requests.post(post_url, params={'access_token': access_token}, data=payload)

    try:
        result = r.json()
        print(result)
        return result
    except json.decoder.JSONDecodeError:
        print("Error decoding JSON. Response might not be in JSON format.")
        print("HTTP Status Code:", r.status_code)
        print("Response Text:", r.text)

        try:
            html_response = r.text
            print("HTML Response:", html_response)
        except Exception as e:
            print("Error parsing HTML response:", str(e))

        return None

def status_code(ig_container_id, access_token):
    graph_url = "https://graph.facebook.com/v19.0/{}/".format(ig_container_id)
    params = {
        'access_token': access_token,
        'fields': 'status_code'
    }
    response = requests.get(graph_url, params=params)

    try:
        response_json = response.json()
        return response_json['status_code']
    except json.decoder.JSONDecodeError:
        print("Error decoding JSON. Response might not be in JSON format.")
        print("HTTP Status Code:", response.status_code)
        print("Response Text:", response.text)
        return None
def publish_media(results, access_token, insta_user_id):
    if results and 'id' in results:
        creation_id = results['id']
        second_url = "https://graph.facebook.com/v19.0/{}/media_publish".format(insta_user_id)
        second_payload = {
            'creation_id': creation_id,
            'access_token': access_token,
        }
        r = requests.post(second_url, data=second_payload)
        print(r.text)
        print('Media published to Instagram')
    else:
        print("Media posting not possible")

@app.route('/instagramUpload', methods=['POST'])
def upload():
    data = request.json

    media_type = data.get('media_type', '').upper()
    media_url = data.get('media_url', '')
    access_token = 'EAALwZACV0gEoBOZCDZB0ddAbPAyb3NAHbzgrZCHZBNPZBBZAZA2jDiU1pJZAjYhMsmcbzAZAqwau2bSI9yBQGrzQTKUIAS57KsQ5LVziYdKBL2UwW5fsB93v4ZAUSDeqMVALNTzNjPtpKwDGd77cXxhQwcTeoy4QdSVQmckZCubZBzV3WzCpCfkSjHDb3G7mNJti7dNXZAKb5Em8KgdMRbHKk3zBgC9ATwWgZDZD'
    insta_user_id ='17841464682383816'
    caption = data.get('caption', '')

    if not media_type or not media_url or not access_token or not insta_user_id:
        return jsonify({'error': 'Missing required parameters'}), 400

    results = upload_media(media_url, media_type, access_token, insta_user_id, caption)

    if results is not None:
        time.sleep(10)
        ig_container_id = results.get('id')
        if ig_container_id:
            s = status_code(ig_container_id, access_token)
            if s == 'FINISHED':
                publish_media(results, access_token, insta_user_id)
                return jsonify({'status': 'success', 'message': 'Media uploaded and published successfully'})
            else:
                time.sleep(60)
                publish_media(results, access_token, insta_user_id)
                return jsonify({'status': 'success', 'message': 'Media uploaded successfully. Still waiting for publishing'})
        else:
            return jsonify({'error': 'Error uploading media. Please check your request'}), 500
    else:
        return jsonify({'error': 'Error uploading media. Please check your request'}), 500



if __name__ == "__main__":
   app.run(host='0.0.0.0', port=5000)