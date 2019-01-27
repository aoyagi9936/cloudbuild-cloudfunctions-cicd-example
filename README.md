# cloudbuild-gce-container-example

![Architecture Diagram](https://github.com/aoyagi9936/cloudbuild-gce-container-example/blob/master/architecture-diagram.png?raw=true)

This script is create and update gce container by cloud build.

Docker Container in GCE will publish Angular application on Nginx.

You need to make two triggers for initialization and update (cloudbuild.init.yaml, cloudbuild.yaml).

I setted each trigger the following condition.

#### Init Trigger (Create GCE instance with container)

- Trigger Name: gce-container-example-init
- Trigger Type: branch
- Pattern Match: .*
- Include File Filter: .init

*Operation is*

```console
echo >> .init
git commit .init -m "start init trigger"
# verify commit
# git commit .init -m "start init trigger" -S
git push origin HEAD
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
git tag release_v1 -m "first release"
# verify tag
# git tag -s release_v1 -m "first release"
git push origin release_v1
```

# NOTE

This script uses following ZONE and GCR HOST

- ZONE:us-central1-a
- GCR HOST:gcr.io
