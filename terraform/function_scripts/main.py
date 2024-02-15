import functions_framework


from google.cloud import aiplatform

from google.oauth2 import service_account
from google.cloud import secretmanager
import os
import json

from vertexai.language_models._language_models import (
    ChatModel,
    InputOutputTextPair,
)

def get_secret(secret_id_parameter):
    project_number = os.environ["PROJECT_NUMBER"]
    secret_id = secret_id_parameter
    version_id = 'latest'

    secret_version_name = f"projects/{project_number}/secrets/{secret_id}/versions/{version_id}"

    client = secretmanager.SecretManagerServiceClient()

    response = client.access_secret_version(request={"name": secret_version_name})

    return response.payload.data.decode("UTF-8")

@functions_framework.http
def run_api(request):

    if request.method == "OPTIONS":
        # Allows POST requests from any origin with the Content-Type
        # header and caches preflight response for an 3600s
        headers = {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "POST",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Max-Age": "3600",
        }

        return ("", 204, headers)

    # Set CORS headers for the main request
    headers = {"Access-Control-Allow-Origin": "*"}

    request_json = request.get_json(silent=True)

    question = request_json['question']

    project_id_from_secrets = get_secret("math-robot-secret-projectID")

    credentials_from_secrets = get_secret("math-robot-secret-credentials")

    credentials_from_secrets_json = json.loads(credentials_from_secrets)

    credentials = service_account.Credentials.from_service_account_info(credentials_from_secrets_json)

    aiplatform.init(project=project_id_from_secrets, location=os.environ["LOCATION"], credentials=credentials)

    parameters = {
        "max_output_tokens": 2048,
        "temperature": 0.9,
        "top_p": 1
    }

    chat_model = ChatModel.from_pretrained("chat-bison@002")

    chat = chat_model.start_chat(
        context="Your name is math-robot. You are a robot who is knowledgeable about basic math. Respond in short sentences. Shape your response as if talking to a 10-years-old",
        examples=[
            InputOutputTextPair(
                input_text="What is 2+2?",
                output_text="That\'s a great addition question! 2+2 is 4!",
            ),
            InputOutputTextPair(
                input_text="What is 47 x 32?",
                output_text="I\'m sorry, that\'s pretty complicated for me! I just know basic math!",
            ),
            InputOutputTextPair(
                input_text="What is 3 x 2?",
                output_text="That\'s a great multiplication question! 3 x 2 is 6!",
            ),
        ],
    )

    response = chat.send_message(question, **parameters)

    print(response)

    return (response.text, 200, headers)