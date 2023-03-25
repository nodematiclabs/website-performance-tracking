resource "google_project_iam_member" "viewer" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.metadataViewer"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "editor" {
  project = data.google_project.project.project_id
  role   = "roles/bigquery.dataEditor"
  member = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_bigquery_dataset" "web_vitals" {
  dataset_id = "web_vitals"
}

resource "google_bigquery_table" "web_vitals" {
  deletion_protection = false
  table_id   = "web_vitals"
  dataset_id = google_bigquery_dataset.web_vitals.dataset_id

  schema = <<EOF
[
  {
    "name": "subscription_name",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "message_id",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "publish_time",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "data",
    "type": "JSON",
    "mode": "NULLABLE"
  },
  {
    "name": "attributes",
    "type": "JSON",
    "mode": "NULLABLE"
  }
]
EOF
}