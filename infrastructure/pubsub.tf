resource "google_pubsub_topic" "web_vitals" {
  name = "web-vitals"
}

resource "google_pubsub_subscription" "web_vitals" {
  name  = "web-vitals"
  topic = google_pubsub_topic.web_vitals.name

  bigquery_config {
    table = "${google_bigquery_table.web_vitals.project}.${google_bigquery_table.web_vitals.dataset_id}.${google_bigquery_table.web_vitals.table_id}"
    use_topic_schema = false
    write_metadata = true
  }

  depends_on = [google_project_iam_member.viewer, google_project_iam_member.editor]
}