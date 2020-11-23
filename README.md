# Github Action for Google Cloud Run

An GitHub Action for deploying revisions to Google Cloud Run.

## Usage

In your actions workflow, somewhere after the step that pushes
`gcr.io/<your-project>/<image>`, insert this:

```bash
- name: Deploy service to Cloud Run
  uses: stefda/action-cloud-run@1.0.0
  with:
    image: gcr.io/[your-project]/[image]
    service: [your-service]
    project: [your-project]
    region: [gcp-region]
    memory: [eg: 1G]
    concurrency: [eg: 10]
    allow_unauth: [true or false]
    env: [path-to-env-file]
    service key: ${{ secrets.GCLOUD_AUTH }}
    timeout: 10m
    service_account: account-name@PROJECT_ID.iam.gserviceaccount.com
```

Your `GCLOUD_AUTH` secret (or whatever you name it) must be a base64 encoded
gcloud service key with the following permissions:
- Service Account User
- Cloud Run Admin
- Storage Admin

The `env` input is optional. If you don't provide a path to env file the run
deployment will be triggered with the `--clear-env-vars` flag.
