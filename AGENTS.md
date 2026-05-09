# Repository Guidelines

## Project Structure & Module Organization

This repository builds Debian-based Docker images for Hugo Extended. The main image definition is `Dockerfile`, with build orchestration in `Makefile`. The `deps/` Go module exists to pin and inspect the Hugo dependency version used for image tags and build arguments. CI is defined in `.github/workflows/ci.yml`, editor defaults in `.editorconfig`, Docker lint settings in `.hadolint.yaml`, and public assets such as the README image live under `images/`.

## Build, Test, and Development Commands

- `make get-go-version`: prints the Go version declared in `deps/go.mod`.
- `make build-slim`: builds the default `ghcr.io/peaceiris/hugo:vX.Y.Z` image from a Debian slim base.
- `make build-mod`: builds the `-mod` image with a Go base for Hugo Modules.
- `make build-full`: builds the `-full` image with Hugo Modules plus Node.js/npm.
- `make build`: runs all three image builds and lists local Docker images.
- `make login`, `make login-ghcr`, `make push-slim|push-mod|push-full`: publish commands; use only with valid registry credentials.

Local builds require Docker BuildKit/buildx, `go`, `jq`, and network access to download Hugo release artifacts.

## Coding Style & Naming Conventions

Follow `.editorconfig`: UTF-8, LF line endings, two-space indentation, final newline, and trimmed trailing whitespace. `Makefile` recipes must use tabs. Keep Dockerfile instructions explicit and compatible with `hadolint`; current lint ignores are limited to `DL3006` and `DL3008`. Image variants are named `slim`, `mod`, and `full`; preserve the matching Make targets and tag suffixes.

## Testing Guidelines

There is no separate unit test suite. Validation is image-build based: run the relevant `make build-*` target for any Dockerfile, Makefile, or dependency change. CI builds all three variants on pull requests and also runs the shared hadolint workflow. For dependency-only updates, confirm the generated Hugo version by checking the build output or running the built image with `hugo version`.

## Commit & Pull Request Guidelines

Recent commits use Conventional Commit prefixes, especially `fix(deps): ...` for Hugo module updates and `chore(deps): ...` for tooling updates. Keep commit subjects concise and include PR issue references where applicable. Pull requests should describe the changed image behavior, list the variants tested, and note any version updates in `deps/go.mod` or `Dockerfile`. Screenshots are not usually needed unless README assets change.

## Agent-Specific Instructions

Use English for repository-facing content, including documentation, code comments, commit messages, and pull request text, unless the task explicitly requires another language.
