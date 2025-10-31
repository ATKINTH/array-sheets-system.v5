## Summary
(Short summary of what this PR does)

## Why
(Why this change is required — problem statement)

## What was changed
- list of files added/modified
- behavior changes (e.g., “fallback to rclone if rsync fails”)

## How to Test
- Local Termux: `bash scripts/push_reports_full.sh`
- Ensure server public key is installed: check `/home/<user>/.ssh/authorized_keys`
- CI jobs: Should pass `ci/verify-network.yml` and `ci/ci-lint-and-security.yml`

## Rollback
- Use `scripts/rollback_push.sh` and restore from the last snapshot in `/var/backups/ever_export/`

## Checklist
- [ ] I have run the scripts locally (dry-run).
- [ ] Secrets stored in repo? **No** (must be in Actions secrets)
- [ ] CodeQL and CI enabled
