#!/usr/bin/env python
"""
This script MUST not throw errors. If it does, the pod will fail to start.
"""
import requests
from git import Repo
from os.path import basename, exists

MAN_URL = ('https://s3.us-east-2.amazonaws.com/'
           'globusworldk8.nick.globuscs.info/gwmanifest.json')


def get_manifest():
    try:
        r = requests.get(MAN_URL)
        return r.json()
    except Exception as e:
        print(str(e))


def pull_resources(manifest):
    """
    Try to get everything in the manifest. Allow single entries to fail.
    Don't overwrite anything or throw any errors.
    :param manifest:
    :return:
    """
    for repo in manifest.get('github'):
        try:
            print('Cloning repo: ', repo['repo'])
            Repo.clone_from(repo['repo'], repo['name'])
        except Exception as e:
            print(str(e))

    for file in manifest.get('http'):
        try:
            response = requests.get(file)
            response.raise_for_status()
            filename = basename(file)
            if exists(filename):
                raise Exception(
                    'File Exists: "{}", not overwriting...'.format(filename))
            with open(filename, 'wb') as handle:
                for block in response.iter_content(1024):
                    handle.write(block)
            print('Saved ', filename)
        except Exception as e:
            print(str(e))


if __name__ == '__main__':
    manifest = get_manifest()
    if manifest:
        pull_resources(manifest)
