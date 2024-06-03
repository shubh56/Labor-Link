from flask_restful import Resource
from twilio.rest import Client

users = [
    "+919137357003",
    "+919004690126",
    "+919372538821",
    "+918850366017"
]

class Notification(Resource):
    def get(self):

        account_sid = 'AC9bfcbe0ba32fab4c09b5425fddceace8'
        auth_token = '17d8540e3563cbba37ba250ca16184e3'
        client = Client(account_sid, auth_token)

        for user in users:
            message = client.messages.create(
                from_='whatsapp:+14155238886',
                body='Hey there! We are visiting your area today. Come, we are waiting for you.',
                to=f'whatsapp:{user}'
            )

        return {"error": False, "message": "Notification sent successfully"}
