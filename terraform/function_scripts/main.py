import functions_framework
from langchain.llms import vertexai

# import vertexai
import os

from vertexai.preview.language_models import TextGenerationModel

@functions_framework.http
def run_api(request):

    print(request)
    vertexai.init(project=os.environ.get("PROJECT"), location=os.environ.get("LOCATION"))

    parameters = {
        "max_output_tokens": 2048,
        "temperature": 0.9,
        "top_p": 1
    }
    model = TextGenerationModel.from_pretrained("gemini-pro")
    response = model.predict(
        """Your name is math-robot. You are a robot who is knowledgeable about basic math. Respond in short sentences. Shape your response as if talking to a 10-years-old
    input: What is 2+2?
    output: That\'s a great addition question! 2+2 is 4!
    input: What is 47 x 32?
    output: I\'m sorry, that\'s pretty complicated for me! I just know basic math!
    input: What is 3 x 2?
    output: That\'s a great multiplication question! 3 x 2 is 6!
    input: What is 165 / 4323?
    output:
    """,
        **parameters
    )
    print(f"Response from Model: {response.text}")