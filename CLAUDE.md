# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

An agentic-first iOS template using a minimal SwiftUI Todo app. The app intentionally contains one failing test (`completedTodos_returnsOnlyCompletedItems`) as an onboarding exercise to validate the agentic feedback loop. Requirements: Xcode 15+, iOS 17 deployment target.

## Commands

### Build & Test (shell scripts — used by CI)

```bash
bash scripts/build.sh          # build for simulator
bash scripts/test-unit.sh      # unit tests only
bash scripts/test-ui.sh        # UI tests only
bash scripts/test-all.sh       # all tests, exits non-zero on failure
```

Override the target simulator via environment variable:
```bash
DESTINATION="platform=iOS Simulator,name=iPhone 16,OS=18.2" bash scripts/test-all.sh
```

### Build & Test (XcodeBuildMCP — preferred for local interactive use)

Use the `mcp__XcodeBuildMCP__*` tools for local development. They produce structured, LLM-friendly output vs. raw verbose `xcodebuild` logs. Always call `mcp__XcodeBuildMCP__session_show_defaults` before the first build/test in a session.

## Architecture

**MVVM with `@Observable` (iOS 17+). No external dependencies.**

- `Todo.swift` — `Identifiable` struct (id, title, isComplete)
- `TodoStore.swift` — `@Observable` class; owns the todo array; methods: `add()`, `toggle()`, `delete(at:)`
- `ContentView.swift` — SwiftUI view + `TodoRow` subcomponent; uses accessibility identifiers for UI testing

## Agentic Workflow

The intended loop for any change:

1. Write failing tests that define the contract
2. Write code to make them pass
3. `scripts/build.sh` — verify it compiles
4. `scripts/test-all.sh` — verify tests pass
5. Open a PR with simulator screenshots of affected views

PR lifecycle: GitHub Actions runs `test-all.sh` on every push. On merge to `main`, a TestFlight build is uploaded. PR comments from reviewers should be actioned by the agent with new commits.
