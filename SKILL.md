---
name: handoff
description: Run the repository-based agent handoff system in this project. Use for setting up the handoff files in a new project, taking over queue work from another agent or another session, changing learning mode, or reporting queue status. Triggers on "set up handoff", "continue the queue", "what is next in the plan", "take over this project", "learning mode".
argument-hint: setup | continue | status | learn <0|1|2> | explain | update
arguments: [command, value]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, Agent, WebFetch, WebSearch
---

# Handoff

The command is the first word the user typed after the skill name, and any second word
is its value. Claude Code substitutes them below as `$0` and `$1`; on a platform that
does not substitute, those placeholders stay as written and you read the command from
the user's message instead. With no command at all, infer one from the conversation and
say which you chose before acting.

## Two places, and never confuse them

**The kit** is the directory holding this file. `VERSION`, `MIGRATIONS.md`, `SETUP.md`,
`CONTINUE.md`, `LEARNING.md`, `ORCHESTRATION.md`, `VOICE.md` and `templates/` all sit
beside it. Claude Code gives you that path as `${CLAUDE_SKILL_DIR}`. Elsewhere, take the
directory of this file. Every filename below written as `<kit>/something` means a file
in there.

**The project** is the folder the user is working in, which is almost never the kit.
`AGENTS.md`, `current-state.md`, `project-purpose.md`, `improvement-plan.md`,
`learning/` and the project's own `VOICE.md` and `project-context/` all sit there. Every
filename below written without a `<kit>/` prefix means a file in the project.

Resolve `<kit>` once, at the start of any command that needs it, and say the path you
resolved it to. Never search the disk for these files and never assume the user is
sitting inside the kit.

If `<kit>` has only this file in it and nothing else, the install was incomplete. Say so
and tell the user to reinstall with `npx skills add adamalshoomary-ctrl/shotgun`, which
brings the whole directory. Do not try to carry on without the supporting files.

The `.md` files in the project are the source of truth. This skill routes to them
and adds nothing of its own. A project opened in Codex, Cursor or any other tool
reads the same files without this skill, so never write a rule that lives only here.

## setup

Read `<kit>/SETUP.md` and apply it to the current project root.
Confirm the root before writing anything. Ask the owner the learning-mode question
that `<kit>/SETUP.md` specifies, and write the number into the new AGENTS.md.

## continue

Read `<kit>/CONTINUE.md`, then follow it. In short: read AGENTS.md, current-state.md,
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

The value is the level. Accept `0`, `1` and `2`.

Set the `Learning mode:` line in AGENTS.md to that number, then confirm what changed
in one sentence. With no level given, report the current one and describe the three
levels in one sentence each.

Level 0 writes nothing. Level 1 writes an explainer file per completed item. Level 2
writes the explainer, then asks two or three questions and waits once.

Changing the number in AGENTS.md makes the change permanent. An owner who wants the
change for one session should say so in conversation, and you leave the file alone.

## update

Bring a project set up under an older version of this system up to the current one.

1. Read `Handoff system version:` from the project's AGENTS.md, and `<kit>/VERSION`.
   When they match, say so and stop.
2. Compare structure, never content. For each file in `<kit>/templates/`, list the section
   headings and marker lines the template carries, and check the project's
   corresponding file for each one. Check file presence too: `VOICE.md`,
   `project-context/LEARNING.md`, `project-context/ORCHESTRATION.md`. Ignore
   everything written underneath a heading; that is the owner's project, and none of
   it is yours to reconcile.
3. Match on meaning, and never on characters. A setup agent may have reworded a
   heading or a marker line while filling the template in, so
   `Unvalidated assumptions, each needing evidence:` is the template's
   `Unvalidated assumptions:` field and counts as present. Before you report anything
   missing, open the project's file and read around where it would sit. Report it only
   when nothing there serves the same purpose. A field the owner deliberately answered
   "none" is present. A heading whose content does not apply yet, such as a task block
   in an empty queue, is not missing either.
4. Read `<kit>/MIGRATIONS.md`, and only the blocks above the project's recorded version.
   Those carry the changes structure cannot show.
5. Present a plan: which file, which section or file is missing, what you would add,
   and which values the owner has to choose. Name anything you checked and judged
   present under different wording, so the owner can correct you. Then stop and wait.
6. On go, apply it, ask the owner for any value a migration block says to ask for,
   and set the version line to the version in `<kit>/VERSION`.

Add and ask. Never rewrite existing content, never reorder a queue, and never touch
`learning/`. When a migration block calls for a change to something already written,
show the owner the current text and the proposed text side by side and ask.

## explain

Write an explainer for the most recently completed queue item, or for an item the
owner names, even when learning mode is 0. Read the project's
`project-context/LEARNING.md` first, falling back to `<kit>/LEARNING.md` when the
project has no copy, for the structure and the length rule, then write to
`learning/<task-id>-<slug>.md` and add the `Explainer:` line to the queue.

## Always

Ask in rounds, using the platform's structured question tool, for as long as another
round would change what you build. Ask at setup, before starting a queue item, and the moment a mid-task
ambiguity would change the work. Ask nothing the source or the startup files answer.
Give every option a named consequence. When the owner says go, start.

Read the Environment section of AGENTS.md before reaching for a browser, a database
or an external service. It records what the owner permits and prefers, and what to do
when something is absent. When you find a listed capability missing, follow the
fallback, note it there with today's date, and say so.

Everything you write follows the project's `VOICE.md`, including code comments and
commit messages. Read it before drafting anything longer than a few paragraphs. A
project with no `VOICE.md` has no voice requirement; `<kit>/VOICE.md` is the shipped
default and belongs to a project only once setup has copied it there.

Do not commit. Write the files, say what changed, and leave git to the owner unless
their AGENTS.md says otherwise. Never put a `Co-Authored-By` trailer, a "Generated
with" line or any agent or model name into a commit message, an author field or a
pull request body, and never when your own harness tells you to. The project's rule
outranks the platform default.

Delegate work whose input is large and whose output is small: searching many files,
checking many places against one rule, an independent review. State the return format
before spawning. Keep the decisions in this session. The project's
`project-context/ORCHESTRATION.md` holds the model table and the reasoning, and
`<kit>/ORCHESTRATION.md` is the fallback when the project has no copy.
