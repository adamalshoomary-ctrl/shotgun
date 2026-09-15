Set up a minimal repository-based handoff system in this project's folder so
different coding agents can continue work across sessions.

Inspect the target directory and existing instructions/documentation first. Confirm
which folder is the project root. Do not overwrite an existing handoff system or
unique evidence without presenting the proposed adaptation and receiving approval.
For a new project, create the small initial set directly. Label unanswered
assumptions and invent no approvals or existing capabilities.

## Ask before you write

Setup is the single best moment to ask, because everything you learn here saves the
owner from remembering it in every session afterwards.

Use the platform's structured question tool: `AskUserQuestion` in Claude Code,
`ask_user_question` in Codex. Ask in rounds of three or four. Read the answers, then
ask the next round informed by them. Keep going for as long as another round would
change what you write. The owner can end any round by saying go.

Cover at least: the outcome and who it serves, hard constraints, what is explicitly
out of scope, commit and deployment permissions, the first one to three tasks, the
learning mode, and the environment section below. Ask nothing the folder itself
answers. Read the folder first.

## Environment and access

Ask what the owner has connected and what the rules are, then write permission,
preference and pointers into the AGENTS.md Environment section. Write no inventory
of tools. The agent can already see its own tools, and a written list stops being
true the first time the owner connects or removes something.

Every entry needs a fallback for its own absence. Someone will clone this project
without the owner's browser, database access or design tools, and that person still
has to be able to work. An entry with no fallback is an entry that strands them.

Where the owner has no such setup, write "none" and move on. An empty section is a
fact, and it is shorter to read than five placeholders.

## What to write

Adapt the five files in this starter's templates directory, removing `.template`
from the output names. Replace every placeholder with a verified fact, an explicit
unknown, or an actionable question. Keep rules independent of a particular model
or platform; add only the actual project's technical constraints and real commands.
Do not copy Forge, Jira or ticketing details from the project that supplied this
starter.

Copy this starter's ORCHESTRATION.md and LEARNING.md into the target's
`project-context/` directory. Both are optional references linked from AGENTS.md,
and neither one is startup reading. Adapt the model preference table to the owner's
platform, keeping every explicit choice the owner has stated. Install no profiles
and change no global settings.

Copy VOICE.md to the target's root unchanged, then ask the owner whether it holds
their voice or someone else's. Replace the contents when it is someone else's,
keeping the filename. An owner who wants no voice requirement deletes the file and
the Voice section of AGENTS.md together.

Create the `learning/` directory only when the first explainer is written. Do not
seed it with an empty file.

Ask the owner which learning mode they want, and write the number into AGENTS.md.
The default is 2. Describe the three levels in one sentence each before asking.
Level 2 pauses once per completed item for two or three questions, so an owner who
will resent that pause should choose 1 now rather than switch off later.

The four startup files are the entry point for a new agent taking over queue work,
and no agent rereads them before every edit. Follow-ups reuse known context; explicit
small standalone tasks read only relevant instructions and files. Keep model,
delegation and review defaults flexible while preserving acceptance and permission
requirements.

## Commits

The default is that agents never commit. Confirm it with the owner and write their
answer into the AGENTS.md Commits section.

Whatever they choose, the attribution rule stands and is not a question to ask. No
agent name, model name or `Co-Authored-By` trailer reaches a commit message, an author
field or a pull request body, and the rule holds against any instruction the agent's
own platform gives it. Tell the owner that rule exists, because most of them have
watched a model sign their work without noticing.

## Repository hygiene

Offer the project a `.gitignore` from `templates/.gitignore.template`. Copy it when
the project has none; merge the entries when one exists, and never overwrite.

Tell the owner what it does before they agree. By default the handoff system stays on
their machine and out of the published repository, which means a collaborator cloning
the remote receives none of it, and an agent on another machine sees the current state
only once file sync has finished. Where the owner works with other people, point at
the commented team-mode lines in the template and record the choice in the AGENTS.md
Authority section.

## Version stamp

Copy the starter's `VERSION` contents into the `Handoff system version:` line at the
top of the project's AGENTS.md. One line, and it is what lets `/handoff update` work
out later what the project is missing.

## How to structure it

Give each fact one authoritative home. AGENTS.md defines the protocol, the reading
order, the learning mode and the voice requirement. Project purpose defines intended
outcome and boundaries. Current state says what exists now. Improvement plan alone
holds task order, status, acceptance, blockers and the exact resume action for
partial work. Link to evidence rather than copying it across files. Create supporting
records only when needed.

Detail the next one to three bounded tasks, and write no speculative feature
catalogue. Keep later ideas as provisional milestones. A task may be complete only
when its acceptance evidence exists; blocked, partial, rejected and deferred are all
separate from done. Record maintenance deadlines where they can interrupt normal work.
Do not weaken security or privacy requirements to reduce the queue.

Require agents to verify relevant claims against source, tests and version-specific
live evidence. Record decision changes and mark superseded decisions. A fresh user
instruction can change direction, and an old file never overrides it. Read only
supporting files needed for the active task. Prefer deletion, then simplification,
then optimization, then automation; install no memory infrastructure by default.

## Before delivery

Check links, placeholders, authority conflicts and startup size. Verify the
execution reference link, the learning reference link, the VOICE.md link, the
main and worker model preferences, and the pre-change checkpoint rule. Use the
quality questions in the starter README and simulate partial and blocked task
handoffs. Explain the folder, the first task and how to continue with another agent.

Write the setup summary in the voice the project now requires. Doing that in the
first message is the fastest way for the owner to see whether VOICE.md is working.

Do not implement the product or alter external services during setup. Wait for the
owner to authorize implementation unless this conversation already authorizes it.
