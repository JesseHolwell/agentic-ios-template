# agentic-ios-template

A reference iOS project designed to support an autonomous agentic development workflow using Claude Code. The goal is to build confidence that an agent can implement features, verify them through automated builds and tests, and iterate with minimal human intervention.

This template will eventually inform the standards brought into a production iOS codebase.

---

## Goals

- **Agentic-first**: The agent should be able to build, test, and verify its own work through repeatable scripts — not rely on a human to confirm that something compiled or passed.
- **Fast feedback loops**: Automated unit and UI tests give the agent ground truth. If a test fails, the agent knows. No manual testing required to close the loop.
- **Automated PR workflow**: Feature requests and bug fixes result in a PR. Comments on the PR are actioned automatically. PRs include simulator screenshots of affected views. Approved PRs trigger a TestFlight build for manual look-and-feel review.
- **Developer experience**: Clear scripts, clean architecture, and a predictable project structure that is easy to reason about — for both humans and agents.
- **No premature complexity**: Zero external dependencies to start. Additions are deliberate and justified.

---

## Project Structure

```
agentic-ios-template/
├── AgenticSampleApp/           # SwiftUI app target
├── AgenticSampleAppTests/      # XCTest unit test target
├── AgenticSampleAppUITests/    # XCUITest UI test target
├── AgenticSampleApp.xcodeproj/
├── scripts/                    # Repeatable shell scripts for the agent
│   ├── build.sh
│   ├── test-unit.sh
│   ├── test-ui.sh
│   └── test-all.sh
├── .github/
│   └── workflows/              # GitHub Actions CI/CD
└── README.md
```

---

## The Sample App

A minimal **Todo List** app. Simple enough to be fully understood at a glance, complex enough to exercise real patterns:

- View a list of todo items
- Add a new todo item
- Mark a todo item as complete
- Delete a todo item

The app uses no external dependencies. State management is handled with native SwiftUI (`@Observable`).

One test is intentionally left failing at project creation. This serves as a concrete starting point to validate that the agentic feedback loop works end-to-end: the agent is asked to fix it, runs the tests, sees red, makes a change, sees green.

---

## Scripts

All agent-facing commands live in `scripts/`. They are thin wrappers around `xcodebuild` so the agent always has a single, consistent interface.

| Script | What it does |
|---|---|
| `scripts/build.sh` | Builds the app target for a simulator |
| `scripts/test-unit.sh` | Runs the unit test target only |
| `scripts/test-ui.sh` | Runs the UI test target only |
| `scripts/test-all.sh` | Runs all tests and exits non-zero on any failure |

Scripts exit with a non-zero code on failure and print structured output so the agent can parse results without guessing.

---

## Agentic Workflow

### Local Development

```
Request (natural language)
        ↓
  Agent proposes tests           ← defines the contract as given/when/then
        ↓
  Human approves                 ← async, via issue or PR comment
        ↓
  Agent writes failing tests
        ↓
  Agent writes code
        ↓
  scripts/build.sh               ← does it compile?
        ↓
  scripts/test-all.sh            ← do tests pass?
        ↓
  Iterate until green
        ↓
  Agent opens a PR               ← includes simulator screenshots of affected views
```

> TDD covers behaviour. TestFlight covers aesthetics. Simulator screenshots in the PR bridge the gap for a quick visual sanity check without waiting for a full TestFlight build.

### Pull Request Lifecycle

1. Agent opens a PR with a description of what changed and why, including simulator screenshots of affected views.
2. GitHub Actions runs `test-all.sh` on every push to the PR branch.
3. A reviewer (human) can comment on the PR. The agent picks up comments and actions them, pushing new commits to the branch.
4. On merge to `main`, GitHub Actions builds an `.ipa` and uploads it to TestFlight.

---

## Requirements

- Xcode 15+
- iOS 17 deployment target
- macOS with a GitHub Actions runner (self-hosted or cloud with Xcode installed)

---

## Getting Started

```bash
git clone https://github.com/<your-org>/agentic-ios-template.git
cd agentic-ios-template
bash scripts/build.sh
bash scripts/test-all.sh   # one test will intentionally fail — that's expected
```

Then ask the agent to fix the failing test and observe the feedback loop in action.

---

## Roadmap

This template is an exploration. Decisions made here will be evaluated before being carried into production.

- [ ] SwiftUI todo app with unit and UI tests
- [ ] `scripts/` layer with build, test-unit, test-ui, test-all
- [ ] GitHub Actions: CI on PR, TestFlight upload on merge to main
- [ ] Intentionally failing test as an agent onboarding exercise
- [ ] Documented agentic workflow (this README)
- [ ] Evaluate: snapshot testing for UI regression
- [ ] Evaluate: apply template decisions to production iOS codebase

---

## Related Future Work

The same agentic approach is planned for:

- **C# API** — backend template with equivalent scripts and CI
- **React website** — frontend template
- **Terraform** — infrastructure layer
- **Orchestration layer** — an agentic template that ties all of the above together
