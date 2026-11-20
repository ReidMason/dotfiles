- Be extremely concise in your responses
- Don't run one off fix commands without asking
    - For example only run read-only Kubectl commands
    - We don't want to apply one off command line fixes unless specifically told
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

Never add `Co-Authored-By` or other Claude attribution lines to commits or PR bodies.

## Code comments

- Default to no code comments; express intent through naming and structure
- Only comment a non-obvious *why* (workaround, hidden constraint), in one short line
- No commented-out code or TODOs without an issue reference
- Doc strings: public API only, one or two concise sentences, don't restate the signature
