# Configure the GitHub Provider
provider "github" {
    token = "${var.github_token}"
    organization = "${var.github_organisation}"
}

resource "github_repository" "ttnp-25-nodes" {
    name = "ttnp-25-nodes"
    description = "Software to run on Nodes for TTNP-25"
    has_issues = true
    has_wiki = false
}

resource "github_repository" "ttnp-25-infra" {
    name = "ttnp-25-infra"
    description = "Infrastructure as Code for TTNP-25"
    has_issues = true
    has_wiki = false
}
