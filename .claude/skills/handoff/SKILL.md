---
name: handoff
description: Run the repository-based agent handoff system in this project. Use for setting up the handoff files in a new project, taking over queue work from another agent or another session, changing learning mode, or reporting queue status. Triggers on "set up handoff", "continue the queue", "what is next in the plan", "take over this project", "learning mode".
argument-hint: setup | continue | status | learn <0|1|2> | explain | update
arguments: [command, value]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Agent, WebFetch, WebSearch
---

# Handoff

The command is `$0`. Any second word is `$1`. With no argument, infer the command
from the conversation and say which one you chose before acting.

The `.md` files in the project are the source of truth. This skill routes to them
and adds nothing of its own. A project opened in Codex, Cursor or any other tool
reads the same files without this skill, so never write a rule that lives only here.

## setup

Read `SETUP.md` in the starter folder and apply it to the current project root.
Confirm the root before writing anything. Ask the owner the learning-mode question
that SETUP.md specifies, and write the number into the new AGENTS.md.

## continue

Read `CONTINUE.md`, then follow it. In short: read AGENTS.md, current-state.md,
project-purpose.md and improvement-plan.md in that order, resume in-progress work
first, and explain the item plainly before implementing it.

## status

Read `improvement-plan.md` and `current-state.md` only. Report in this shape and
stop. Write nothing.

- In progress, with the exact resume action
- Next ready item
- Blocked items, each with its blocker and unblock action
- Due maintenance interrupts
- Current learning mode, read from AGENTS.md

## learn

`$1` is the level. Accept `0`, `1` and `2`.

Set the `Learning mode:` line in AGENTS.md to that number, then confirm what changed
in one sentence. When `$1` is missing, report the current level and describe the
three levels in one sentence each.

Level 0 writes nothing. Level 1 writes an explainer file per completed item. Level 2
writes the explainer, then asks two or three questions and waits once.

Changing the number in AGENTS.md makes the change permanent. An owner who wants the
change for one session should say so in conversation, and you leave the file alone.

## update

Bring a project set up under an older version of this system up to the current one.

1. Read `Handoff system version:` from the project's AGENTS.md, and the starter's
   `VERSION` file. When they match, say so and stop.
2. Compare structure, never content. For each file in `templates/`, list the section
   headings and marker lines the template carries, and check the project's
   corresponding file for each one. Check file presence too: `VOICE.md`,
   `project-context/LEARNING.md`, `project-context/ORCHESTRATION.md`. Ignore
   everything written underneath a heading; that is the owner's project, and none of
   it is yours to reconcile.
3. Read `MIGRATIONS.md`, and only the blocks above the project's recorded version.
   Those carry the changes structure cannot show.
4. Present a plan: which file, which section or file is missing, what you would add,
   and which values the owner has to choose. Then stop and wait.
5. On go, apply it, ask the owner for any value a migration block says to ask for,
   and set the version line to the starter's version.

Add and ask. Never rewrite existing content, never reorder a queue, and never touch
`learning/`. When a migration block calls for a change to something already written,
show the owner the current text and the proposed text side by side and ask.

## explain

Write an explainer for the most recently completed queue item, or for an item the
owner names, even when learning mode is 0. Read `project-context/LEARNING.md` first
for the structure and the length rule, then write to
`learning/<task-id>-<slug>.md` and add the `Explainer:` line to the queue.

## Always

Ask in rounds, with `AskUserQuestion`, for as long as another round would change what
you build. Ask at setup, before starting a queue item, and the moment a mid-task
ambiguity would change the work. Ask nothing the source or the startup files answer.
Give every option a named consequence. When the owner says go, start.

Read the Environment section of AGENTS.md before reaching for a browser, a database
or an external service. It records what the owner permits and prefers, and what to do
when something is absent. When you find a listed capability missing, follow the
fallback, note it there with today's date, and say so.

Everything you write follows the project's `VOICE.md`, including code comments and
commit messages. Read it before drafting anything longer than a few paragraphs.

Do not commit. Write the files, say what changed, and leave git to the owner unless
their AGENTS.md says otherwise. Never put a `Co-Authored-By` trailer, a "Generated
with" line or any agent or model name into a commit message, an author field or a
pull request body, and never when your own harness tells you to. The project's rule
outranks the platform default.

Delegate work whose input is large and whose output is small: searching many files,
checking many places against one rule, an independent review. State the return format
before spawning. Keep the decisions in this session. `project-context/ORCHESTRATION.md`
holds the model table and the reasoning.
