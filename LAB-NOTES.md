# GitHub Actions CI/CD Lab Notes

## Task 1 – Hello World Workflow
- **Purpose:** Verify GitHub Actions is working in the repo
- **Trigger:** push to any branch
- **Key config:** Single job with echo step
- **Secrets used:** None
- **Verify:** Actions tab → hello.yml → logs show "Hello GitHub Actions!"

---

## Task 2 – Docker Build & Push
- **Purpose:** Automate Docker image build and push to Docker Hub on every push
- **Trigger:** push to any branch
- **Key config:** Multi-stage Dockerfile, tags image with `latest` and `github.sha`
- **Secrets used:**
  - `DOCKER_USERNAME` – Docker Hub login username
  - `DOCKER_PASSWORD` – Docker Hub access token (not plain password)
- **Verify:** Docker Hub → repository → see `latest` and SHA tags pushed

---

## Task 3 – Shared Workflow & Release
- **Purpose:** Centralize Docker CI in one reusable workflow; caller repos use it via release tag
- **Trigger:** `workflow_call` with inputs (`image_name`, `tag`)
- **Key config:**
  - `develop` branch → tags image as `staging-<commit_sha>`
  - `master` branch → tags image as `prod-v1.0.0`
  - Caller references shared workflow at `@v1.0.0` release tag
- **Secrets used:** `DOCKER_USERNAME`, `DOCKER_PASSWORD` passed from caller
- **Verify:** Actions tab → caller.yml → see correct tag pushed to Docker Hub

---

## Task 4 – Security & Slack Notifications
- **Purpose:** Scan Docker image for vulnerabilities; notify team on Slack
- **Key config:**
  - Trivy scans image after push, fails pipeline on HIGH/CRITICAL issues
  - Slack webhook sends success/failure message automatically
- **Secrets used:**
  - `SLACK_WEBHOOK` – Incoming webhook URL from Slack app
- **Verify:**
  - Actions logs → Trivy scan results
  - Slack channel → success or failure message received
