from flask_restful import Resource, request
from llms.geminiProVision import generate_gemini_response
from io import BytesIO
import json

professions = [
    "Carpenter",
    "Plumber",
    "Electrician",
    "Welder",
    "Delivery boy",
    "Mason",
    "Painter",
    "Driver",
    "Maid",
    "Nurse",
    "Cook",
    "Massager",
    "Office Boy",
    "Watchman",
    "AC technicians",
    "Water filtration technician",
    "Scrap dealer"
]

class CategoryDetection(Resource):
    def post(self):
        image = request.files['image']

        input_prompt = """
            Suggest me a blue-collar worker type for this image. Strictly from this {} list.
        """.format(professions)

        question_prompt = """
            Which categories are the perfect blue-collar worker category for the image?

            output should be only single blue-collar worker category from the {}.

            Strictly no \\n or \\ or any other special characters are allowed. don't format your response in any other way.
        """.format(professions)

        image_content = BytesIO(image.read())
        response = generate_gemini_response(input_prompt=input_prompt, image=image_content, question_prompt=question_prompt)
        print(response)

        
        return {"error": False, "data": response}

