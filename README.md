# Self-Hosted GitHub Actions Runner

A Dockerized self-hosted GitHub Actions runner. Since GitHub-hosted runners can sometimes be slow due to high demand, running your CI jobs locally can be a faster and more reliable alternative.

## Quick Start

After cloning the repository, create a `.env` file using the provided `.env.tpl` file as a template.

```env
GITHUB_OWNER=${GITHUB_OWNER}

GITHUB_REPO=${GITHUB_REPO}

# Generate this in Repository Settings -> Actions -> Runners -> New self-hosted runner
GITHUB_TOKEN=${GITHUB_TOKEN}
```

To obtain a `GITHUB_TOKEN`, go to:

**Repository Settings → Actions → Runners → New self-hosted runner**

The registration token will be displayed in the generated setup commands. Copy it into your `.env` file.

> **Note:** This registration token expires after one hour. It is only used to register the runner.

To have up and runnnig the runner:

```
docker compose up --build
```

To shut down the runner ro you can simply press Ctrl + C:

```
docker compose down
```

## Security Considerations

If you are using this runner with a private repository, it is **strongly recommended** to restrict workflows triggered by pull requests from non-collaborators.

To prevent non-collaborators from opening PRs on your repo:

- Go to the main page of your repository.
- Click in *Settings* under your repository name.
- Under *General* settings find *Pull Request* section.
- In Pull request permissions downdown select *Collaborator only*

A self-hosted runner can execute any workflow that is triggered for your repository. Without proper restrictions, a malicious user could open a pull request that causes your runner to execute untrusted code.

For personal or small-team repositories, consider requiring approval before running workflows from first-time contributors or external pull requests.