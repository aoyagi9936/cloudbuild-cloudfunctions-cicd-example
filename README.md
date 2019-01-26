# cloudbuild-to-gce-container-example

This script is create and update gce container by cloud build.

You need to make two triggers for initialization and update (cloudbuild.init.yml, cloudbuild.yml).

In addition, please set the following key for update trigger.

* _GIT_MAIL=[YourGitEmail]
* _GIT_USER=[YourGitUser]

# NOTE

This script uses following ZONE and GCR HOST
* ZONE:asia-northeast1-a
* GCR HOST:asia.gcr.io
