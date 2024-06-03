import google.generativeai as genai

genai.configure(api_key = 'AIzaSyBskbxBg6w7sU7mqAtsrFb6B1q788wLRSA')

generation_config = {
    "temperature": 0.4,
    "top_p": 1,
    "top_k": 32,
    "max_output_tokens": 4096,
}

safety_settings = [
    {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
    {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_MEDIUM_AND_ABOVE"},
    {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE",
    },
    {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE",
    },
]

def input_image_setup(image):
    image_parts = {
        "mime_type": "image/png",
        "data": image.getvalue()
    }
    return image_parts

gemini_model = genai.GenerativeModel(model_name = "gemini-pro-vision",
    generation_config = generation_config,
    safety_settings = safety_settings
)

def generate_gemini_response(input_prompt, image, question_prompt):
    gemini_compatible_image = input_image_setup(image)
    prompt_parts = [input_prompt, gemini_compatible_image, question_prompt]
    response = gemini_model.generate_content(prompt_parts)
    
    return response.text
