from langchain_core.messages import HumanMessage
from langchain_google_genai import ChatGoogleGenerativeAI
import os

os.environ["GOOGLE_API_KEY"] = os.getenv("GEMINI")
llm = ChatGoogleGenerativeAI(model="gemini-pro", temperature=0.7)

llm.invoke("Hello, how are you?")