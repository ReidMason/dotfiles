- Be extremely concise in your responses
- Never stage, commit or push a git repo
- Only run read-only Kubectl commands
- Don't run one off fix commands without asking
- Prefer integration tests over unit tests
    - If an area has complex business logic use unit tests

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/): `<type>(<scope>): <summary>`

- `<summary>`: imperative, lowercase, no trailing period, under ~72 chars
- `<scope>`: optional — package/module/area touched; omit for repo-wide changes
- Body (optional, blank line after summary): explain *why*, not *what*
- Footer (optional): `BREAKING CHANGE: <description>`, `Refs: <issue/PR>`

Types: `feat` (new capability), `fix` (bug fix), `refactor` (no behavior change), `docs`, `test`, `chore` (tooling/deps/build, nothing ships), `perf`, `style` (formatting only).

If a change could be `feat` or `refactor`, pick based on whether behavior changed for the user.
