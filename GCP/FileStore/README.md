No need to run enable-file-api.sh


https://cloud.google.com/filestore/docs/troubleshooting

https://cloud.google.com/filestore/docs/troubleshooting#permission_denied_when_trying_to_mount_a_file_share

gcloud projects list | grep <project pattern>

```console
gcloud services enable file.googleapis.com
```

```console
gcloud projects get-iam-policy project-name  \
    --flatten="bindings[].members" \
    --format='table(bindings.role)' \
    --filter="bindings.members:service-project-id@cloud-filer.iam.gserviceaccount.com"
```

