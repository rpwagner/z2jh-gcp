c = get_config()

from subprocess import check_call
import os
def start_gcp_script_hook(spawner):
    script = '/srv/start-gcp.sh'
    check_call(script)

# attach the hook function to the spawner
c.Spawner.post_stop_hook = start_gcp_script_hook
