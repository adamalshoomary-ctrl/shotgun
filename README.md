# Shotgun

You ride shotgun. The agent drives, you watch the road, and you come out of the trip
knowing the route.

Eight projects will hand your context to the next agent. This one also explains to you
what just got built.

## What it does

Three problems, one small set of files that lives in your project folder.

**Your agent forgets everything between sessions.** Four markdown files carry the
project's purpose, its current state, its task queue and its rules. Any agent, on any
platform, on any day, reads those four and knows exactly where the work stopped,
including halfway through a task.

**You end up shipping code you cannot read.** After every finished task the agent
writes you an explainer in plain language: what it changed, why, how it works, what it
rejected, and what to check when it breaks. Then it asks you two or three questions
about the work and corrects you once if you are off. Nobody else in this space does
this, and it is the reason the project exists.

**Everything an agent writes sounds like an agent wrote it.** One file holds your
writing rules, and they bind on documentation, commit messages, pull request bodies
and code comments. Swap the file, and every agent in the project writes like you.

Two smaller things fall out of the same design. Agents ask you questions in rounds,
using your platform's own question picker, until asking again would not change what
they build. And agents never commit, never sign anything, and never put a model's name
on your work.

## Install

```sh
npx skills add adamalshoomary-ctrl/shotgun
```

That is the [Agent Skills](https://agentskills.io) installer, and it knows where Claude
Code, Codex, Cursor, Gemini CLI, OpenCode and around seventy other agents keep their
skills. Add `--global` to install it for every project rather than this one.

In Claude Code you can install it as a plugin instead, which also puts it in the
Discover tab:

```
/plugin marketplace add adamalshoomary-ctrl/shotgun
/plugin install shotgun@shotgun
```

Without node, or if you would rather read the script first:

```sh
curl -fsSL https://raw.githubusercontent.com/adamalshoomary-ctrl/shotgun/main/install.sh | sh
```

That one writes the same file into `~/.claude/skills/` and `~/.agents/skills/`, which
between them cover the platforms most people are on.

Restart your agent afterwards, or it will not see the skill.

## Use it

Open a project folder and run one command. Claude Code uses `/handoff`, Codex uses
`$handoff`, and everything after the name is the same.

```
/handoff setup
```

Run once per project. The agent reads the folder, asks you several rounds of questions
about what you are building, and writes the four files. It implements nothing and it
waits for you.

```
/handoff continue
```

Run at the start of every session. The agent reads the four files, resumes anything it
left unfinished, explains the next task in plain language, and waits for you to say
begin.

```
/handoff status
```

Reads and writes nothing. What is in progress, what is next, what is blocked, and which
learning level you are on.

```
/handoff learn 2
```

Sets how much the agent teaches you. `0` writes nothing. `1` writes an explainer file
after every task. `2` writes the explainer, then asks you questions about it. Two is the
default, and the setting stays until you change it.

```
/handoff explain
```

Writes an explainer for the last finished task, or one you name, whatever level you are
on.

```
/handoff update
```

Run after pulling a newer version of this repository. The agent works out what your
project is missing, shows you a plan, and waits before changing anything.

## What ends up in your project

| File | Holds |
| --- | --- |
| `AGENTS.md` | The rules. Permissions, reading order, learning level, voice, what you have connected. |
| `project-purpose.md` | What you are building, for whom, and what is out of scope. |
| `current-state.md` | What exists right now, and what is unproven. |
| `improvement-plan.md` | The task queue. Order, status, and what counts as done. |
| `learning/` | One explainer per finished task. Agents write here and never read it back. |
| `VOICE.md` | Your writing rules. |

Nothing else. No database, no memory server, no dashboard, no background process.

By default these stay on your machine and out of your published repository, so they
travel between your own machines by iCloud, Dropbox or whatever syncs the folder. A
team that wants the repository to carry them uncomments four lines in
[templates/.gitignore.template](templates/.gitignore.template).

## Which agent you open

Whichever one you like. Your session is your choice and nothing here has a vote in it.

A recommendation, and only that. On Codex, GPT-6 Astra at Medium. On Claude Code, Opus
5 at medium.

Subagents are a different decision, made by the agent during a task without asking you.
[ORCHESTRATION.md](ORCHESTRATION.md) holds the table telling it which model to request
for which kind of delegated work, along with an account of what delegation actually
costs and what it saves.

## Using it without the skill

Every rule lives in the markdown files, and the skill only routes to them. So any agent
can run this without installing anything: open your project folder and give it the
contents of [SETUP.md](SETUP.md) to start, or [CONTINUE.md](CONTINUE.md) to carry on.

That is the whole fallback. If a tool of yours has no skill support, or you would rather
not install anything, you lose the slash commands and nothing else.

## Updating

Two things can fall behind, and one command handles both.

```
/handoff update
```

**The skill on your machine.** It checks the published version against yours, tells you
both numbers, and shows you the reinstall command. On your go it runs it. Restart your
agent afterwards, because neither Claude Code nor Codex rescans skill directories
mid-session.

**Your project.** Each project records the version it adopted, as one line at the top of
its AGENTS.md. The agent compares your files against the current templates, reads
[MIGRATIONS.md](MIGRATIONS.md) for anything a comparison cannot see, then shows you a
plan and waits. It adds and it asks. It rewrites nothing.

To update the skill on its own, without touching a project:

```sh
npx skills update -g
```

Then check what you got and restart your agent:

```sh
cat ~/.claude/skills/handoff/VERSION
ls ~/.claude/skills/handoff/
```

Nine entries is a healthy install. One entry means only `SKILL.md` was copied and every
command that reads a template will fail; reinstall with
`npx skills add adamalshoomary-ctrl/shotgun -g`.

## Before you rely on it

Some honest limits. The startup files aim for roughly 3,000 words of mandatory reading,
which is a prompt-volume budget and neither a universal optimum nor a measured cost
saving. Learning mode costs you one pause per finished task at level 2, and an owner
who will resent that should start at level 1. And the system asks a lot of questions on
purpose, which is the point of it and also the thing people turn off first.

Origin: adapted from a real cleanup project, 2026-09-05. Learning mode, the voice
requirement, the asking protocol, the environment section, the commit rule and the
cross-platform install came later. The repository contains a method and none of that
project's facts.
