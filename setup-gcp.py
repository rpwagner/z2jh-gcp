import os
import subprocess
import pickle
import base64
import globus_sdk


globus_env_data = os.getenv('GLOBUS_DATA')
pickled_tokens = base64.b64decode(globus_env_data)
tokens = pickle.loads(pickled_tokens)
TRANSFER_TOKEN = tokens['tokens']['transfer.api.globus.org']['access_token']

authorizer = globus_sdk.AccessTokenAuthorizer(TRANSFER_TOKEN)
tc = globus_sdk.TransferClient(authorizer=authorizer)

ENDPOINT_DOCUMENT = {
  "DATA_TYPE": "endpoint",
  "display_name": "GCPScriptTest",
  "description": "Example gridftp endpoint.",
  "is_globus_connect": True,
}


if os.path.exists("/home/jovyan/.globusonline/lta"):
    pass
else:
    create_result = tc.create_endpoint(ENDPOINT_DOCUMENT)
    print(create_result)
    setup_key = create_result["globus_connect_setup_key"]
    print(setup_key)
    pid = subprocess.run(['/opt/globusconnectpersonal-2.3.9/globusconnectpersonal', '-setup', setup_key])

    

