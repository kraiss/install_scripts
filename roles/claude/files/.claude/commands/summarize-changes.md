---
description: Summarizes changes and flags anything risky. Use when the user asks to be assisted for a code review.
argument-hint: ""
allowed-tools: Bash(git rev-list:*), Bash(git diff:*), Bash(git branch-get-base:*)
---

## Context

- Commits with commit message: !`git rev-list "$(git branch-get-base)..HEAD" --format=%B`
- Diff: !`git diff "$(git branch-get-base)..HEAD"`

## Instructions

1. **Gather commits and changes**

2. **Summarize** the changes in two or three bullet points, then list the places where the main changes have been made, then list any risks you notice such as missing error handling, hardcoded values, or tests that need updating.

If there are no changes against the base, say so plainly instead of inventing a summary.
