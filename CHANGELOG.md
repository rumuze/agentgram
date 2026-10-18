# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Multi-arch `Dockerfile` and `docker-compose.yml` for containerized headless deployments on Linux VPS and servers.
- Automated Dependabot configuration for GitHub Actions and npm package ecosystem.

---

## [1.0.4] - 2026-10-18

### Fixed
- **HTML Entity Parsing**: Escaped `<task>` tag in `help_title` which caused Telegram Bot API to reject messages with `HTTP 400 Bad Request`.
- **400 Entity Fallback**: Added automatic plain-text fallback in `send()` and `edit()` so unclosed or lookalike tags seamlessly downgrade to plain text without failing user actions.

---

## [1.0.3] - 2026-10-18

### Added
- **Resilient HTTPS Keep-Alive Connection Pool**: Replaced one-shot `urllib` requests with persistent thread-local `HTTPSConnection` pooling.
- **8x Performance Speedup**: Reduced sequential Telegram API latency by up to 800%.
- **Automatic Retries**: Added transparent 3x retries with exponential backoff on transient network drops (`[Errno 54] Connection reset by peer`, socket timeouts, and `502 Bad Gateway`).

---

## [1.0.2] - 2026-10-18

### Fixed
- **Python Compatibility**: Fixed PEP 701 nested double quote syntax in `OpenCode._url()` for backward compatibility with Python 3.9, 3.10, and 3.11.
- **Full CI Matrix**: All 24 matrix jobs across Ubuntu and macOS passing with 100% green status.

### Added
- Dedicated unit test suite for `OpenCode` client URL builder and character encoding in `tests/test_client.py`.

---

## [1.0.1] - 2026-10-18

### Added
- Multi-language localization module (`core/i18n.py`) with English as the default international language and complete Arabic translations.
- Interactive `/lang` command and inline language selector keyboard.

---

## [1.0.0] - 2026-10-18

### Added
- Initial open-source release of **Rumuze Edit**.
- Zero-dependency Node.js CLI runner (`bin/rumuze-edit.js`) with interactive auto-pairing wizard (`init`).
- Zero-trust security policy engine (`core/policy.py`) blocking destructive shell commands and sensitive credential leakage.
- Live streaming mission control card via Server-Sent Events (SSE).
- Persistent system service manager (`core/service_manager.py`) supporting macOS `launchd` and Linux `systemd`.
- Laravel auto-discovery integration (`src/RumuzeEditServiceProvider.php` and `php artisan rumuze:edit`).
