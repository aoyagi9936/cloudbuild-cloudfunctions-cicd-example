# cloudbuild-gce-container-example

![Architecture Diagram](https://github.com/aoyagi9936/cloudbuild-gce-container-example/blob/master/architecture-diagram.png?raw=true)

This script is create and update gce container by cloud build.

Docker Container in GCE will publish Angular application on Nginx.

You need to make two triggers for initialization and update (cloudbuild.init.yaml, cloudbuild.yaml).

I setted each trigger the following condition.

## Set Service Account Permission

To execute this build, please add the following roles to the automatically generated Cloud Build Service Account. ([YOUR_PROJECT_NUM]@cloudbuild.gserviceaccount.com)

- roles/compute.instanceAdmin (OR roles/compute.instanceAdmin.v1)
- roles/iam.serviceAccountUser

Please see following.

[Cloud Build Document](https://cloud.google.com/cloud-build/docs/securing-builds/set-service-account-permissions)

## Cloud Build Configuration

At the moment you can choose the following Repositoriy Hosting.

- Cloud Source Repositories
- Bitbucket
- GitHub

#### Init Trigger (Create GCE instance with container)

- Trigger Name: gce-container-example-init
- Trigger Type: branch
- Pattern Match: init-trigger
- Include File Filter: .init

*Operation is*

```console
$ git checkout -b init-trigger
$ echo >> .init
$ git commit .init -m "start init trigger"
# verify commit
# git commit .init -m "start init trigger" -S
$ git push origin HEAD
```

#### Update Trigger (Update GCE instance with container)

- Trigger Name: gce-container-example
- Trigger Type: tag
- Pattern Match: release_v*

In addition, please set the following key for update trigger.

- _GIT_MAIL=[YourGitEmail]
- _GIT_USER=[YourGitUser]

*Operation is*

```console
$ git tag release_v1 -m "first release"
# verify tag
# git tag -s release_v1 -m "first release"
$ git push origin release_v1
```

# NOTE

This script uses following ZONE and GCR HOST

- ZONE:us-central1-a
- GCR HOST:gcr.io
