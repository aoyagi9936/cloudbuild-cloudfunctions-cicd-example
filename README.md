# cloudbuild-gce-container-example

![Architecture Diagram](https://github.com/aoyagi9936/cloudbuild-gce-container-example/blob/master/architecture-diagram.png?raw=true)

This script is create and update gce container by cloud build.

Docker container in GCE will publish Angular application on Nginx.

You need to make two triggers for initialization and update (cloudbuild.init.yml, cloudbuild.yml).

I setted each trigger the following condition.

#### init trigger (create gce container instance)

- Trigger Name: gce-container-example-init
- Trigger Type: branch
~ Pattern Match: .*
- Include File Filter: .init

*Opperation is*

```console
echo >> .init
git commit .init -m "trigger initialize"
git push origin HEAD
```

#### update trigger (update gce container instance)

- Trigger Name: gce-container-example
- Trigger Type: tag
- Pattern Match: release_v*

*Opperation is*

```console
git tag -s release_v1 -m "first release"
git push origin release_v1
```

In addition, please set the following key for update trigger.

* _GIT_MAIL=[YourGitEmail]
* _GIT_USER=[YourGitUser]

# NOTE

This script uses following ZONE and GCR HOST
* ZONE:us-central1-a
* GCR HOST:gcr.io
