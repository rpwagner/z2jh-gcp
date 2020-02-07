# Single User Server

This is the notebook server that is started when someone visits jupyter.demo.globus.org.

The Docker image is hosted here: https://hub.docker.com/r/nickolaussaint/gwk8s

This extends the original single user server listed here:
https://github.com/jupyterhub/zero-to-jupyterhub-k8s/tree/master/images/singleuser-sample

### Remote files

This image depends on remote files in a couple different locations, both on S3 and
Github. S3 contains the manifest of files to fetch, which lists the Github repos to
clone. It's intended this notebook server is configured not to have persistent storage,
and that all storage will be wiped when the server is shut down.

* Notebook Puller -- https://s3.us-east-2.amazonaws.com/globusworldk8.nick.globuscs.info/NotebookPuller.ipynb
* File/Repo Manifest -- https://s3.us-east-2.amazonaws.com/globusworldk8.nick.globuscs.info/gwmanifest.json

### Updating

Run the following commands (UNTESTED! It's been a while!) from this directory:

```
$ docker build .
$ docker tag <image> nickolaussaint/gwk8s:v0.8.x
$ docker push nickolaussaint/gwk8s
```