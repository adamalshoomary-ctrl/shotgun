# Portable project handoffs

Use this starter for sequential work by different coding agents on the same project.
The repository files carry continuity; conversations provide current instructions.
No plugin, memory server or provider-specific feature is required. A Claude Code
skill is included as a convenience wrapper, and every file works without it.

## Three things this system does

**Continuity.** Four small files let any agent, on any platform, pick up where the
last one stopped, including mid-task.

**Learning.** Every completed item leaves a plain-language explainer written for the
owner. The person directing the work keeps up with the system doing it, even without
reading the code. [LEARNING.md](LEARNING.md) holds the three levels and the default.

**Voice.** Everything written in a project, including code comments and commit
messages, follows [VOICE.md](VOICE.md). Replace that file with your own guide and
the rule follows you.

**Your name on your work.** Agents write files and stop. You read the diff and make
the commit. No agent name, model name or `Co-Authored-By` trailer reaches a commit
message or a pull request body, and the rule holds against whatever instruction the
agent's own platform gives it. Most harnesses tell a model to sign its work, and most
owners find out when GitHub lists a model as a contributor.

**Fit to your setup.** Agents ask you questions in rounds, using the structured
question tool the platform provides, and keep asking for as long as another round
would change the work. What they learn about your browser access, your database, your
design sources and your preferences goes into one Environment section in AGENTS.md as
permission, preference and pointers. No tool inventory is written, because every entry
carries a fallback for its own absence, so somebody who clones the project without
your setup can still work.

## Which agent you open

Whichever one you like. Your session is your choice, and nothing here has a vote in
it. No agent may change it or suggest changing it unless you ask.

A recommendation, and only that. On Codex, GPT-6 Astra at Medium. On Claude Code,
Opus 5 at medium.

Subagents are a separate matter. An agent spawns those during a task, without asking,
and [ORCHESTRATION.md](ORCHESTRATION.md) holds the table telling it which model to
request for which kind of delegated work. That file also carries the checkpoint
protocol and an account of what delegation actually costs and saves.

## Start a new project

1. Open the intended project folder in your coding agent. Give it the contents of
   [SETUP.md](SETUP.md), or ask it to read that file and apply it to the target folder.
   In Claude Code, `/handoff setup` does the same thing.
2. Describe the project outcome and any hard constraints. The agent inspects the
   folder and adapts the five [templates](templates/) to the actual project.
3. Answer the learning-mode question. The default is 2.
4. Review the initial purpose and task queue. Authorize the first implementation
   item when ready.

Template files use `.template` suffixes so a tool will not accidentally load their
unfinished instructions as rules for this repository. The setup agent writes their
contents to the corresponding `.md` files in the target, replacing placeholders.
Setup also copies ORCHESTRATION.md and LEARNING.md into the target's project-context
directory, and VOICE.md to the target root. Those three are supporting references,
and none of them joins the mandatory startup set. Do not copy this app's current
state, queue, accounts, Forge rules or history.

## Continue with another agent

Open the same project folder, then use [CONTINUE.md](CONTINUE.md), or
`/handoff continue` in Claude Code. The full startup reading is for a new agent taking
over queue work; follow-ups reuse context, and small explicit standalone edits need
only relevant instructions and files. This starter never grants commit or push
authority.

### How the files travel

By file sync. Setup offers a `.gitignore` that keeps the handoff system out of the
published repository, so iCloud Drive, Dropbox or whatever keeps the folder on your
other machines is what carries continuity between them.

Two consequences, and you should know both before you rely on it. A collaborator who
clones the remote receives no handoff files at all, so they start by running setup
themselves. And an agent on another machine sees the current state only once sync has
finished, so check that before asking one to continue.

Where a team needs the repository to carry the queue, uncomment the four state files
in [templates/.gitignore.template](templates/.gitignore.template). Everything then
works the way it did before 2.1, and the explainers under `learning/` can stay
private while the rest is shared.

Some tools discover AGENTS.md automatically; others need the explicit prompt.
If a platform requires its own entry file, put only a pointer there: "Read and
follow the repository-root AGENTS.md." Do not maintain two copies of the rules.
Verify the tool actually reads the file. Naming a file correctly is not integration.
All project references should be relative to the project root, and none to your
machine.

## What is kept

- AGENTS.md: working rules, authority, permissions, reading order, learning mode,
  voice, the asking protocol, the environment section, the commit rule, and handoff.
- project-purpose.md: problem, user, success, constraints and non-goals.
- current-state.md: present facts, limitations and interrupted-work pointer.
- improvement-plan.md: ordered task statuses, acceptance, evidence and explainer links.
- learning/: one explainer per completed item, written by agents, read by the owner.
  Never loaded for context.

Create project-context only when a decision, proof or operational detail needs its
own home. A short progress index is optional; do not add another current-status list.
Create a task evidence file when proof becomes too detailed for a concise queue
entry. Do not start with empty folders, large architecture maps or speculative tasks.

## Updating a project to a newer starter

Every project records the version it adopted, as one line at the top of its AGENTS.md.
Pull a newer copy of this starter, open the project, and run `/handoff update`, or ask
any agent to read [MIGRATIONS.md](MIGRATIONS.md) and apply it.

The agent compares structure against the templates: section headings, marker lines and
file presence. Whatever the templates carry and the project lacks is a feature the
project has not adopted. Everything written underneath a heading belongs to the owner
and stays untouched. [MIGRATIONS.md](MIGRATIONS.md) covers only the changes structure
cannot show, so most releases add nothing to it.

The update shows you a plan and waits. It adds and it asks. It rewrites nothing.

## The Claude Code skill

[.claude/skills/handoff/SKILL.md](.claude/skills/handoff/SKILL.md) provides
`/handoff setup`, `/handoff continue`, `/handoff status`, `/handoff learn <0|1|2>`,
`/handoff explain` and `/handoff update`. Copy the `.claude/skills/handoff` folder into a project, or
into `~/.claude/skills/` to have it everywhere.

The skill routes to the `.md` files and holds no rules of its own. Delete it and the
system still works on any platform. That constraint is deliberate: a rule that lives
only in the skill would disappear the moment somebody opened the project in Codex.

## Handoff quality check

Before finishing setup, confirm the startup files let a reader answer: what is the
project for; what exists; which task is next; what is blocked; what would prove
completion; who may change external state; and how to resume partial work?
Check every local link, remove placeholders, and separate observed facts from
assumptions. Simulate an interrupted task: the instructions must resume it rather
than start the next one. Simulate a blocked task: the blocker and unblock action
must be visible without becoming a fake completion.

Aim for roughly 3,000 words or less of mandatory startup reading, excluding the
selected task's needed detail. The figure was 2,000 through version 1.x, when the
four files carried rules, authority and the queue and nothing else. Learning mode,
the voice requirement, the asking protocol and the environment section have arrived
since, each one earning its place and each one costing words in the file every agent
reads first. Nothing was cut to hold the old number, and pretending it still held
would have been the worse answer.

This is a prompt-volume budget, and it is neither a universal optimum nor a measured
cost saving. Keep critical constraints even when that needs more.

Origin: adapted from the Attachment Content Search cleanup, 2026-09-05. Learning
mode, the voice requirement, the asking protocol, the environment section and the
Claude Code mapping were added 2026-09-15. The
starter contains a method, and none of this project's facts. Copy this entire folder
to reuse it.
