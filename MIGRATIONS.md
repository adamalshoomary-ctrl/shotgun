# Migrations

`/handoff update` works by comparing structure. It reads each file in `templates/`,
reads the project's corresponding file, and compares section headings, marker lines
and file presence. Anything the template carries and the project lacks is a feature
the project has not adopted yet.

That comparison stays correct without anybody maintaining it, because the templates
are the specification. Editing a template updates the check.

This file exists for the changes that comparison cannot see: a changed default, a
reordered reading list, a rewritten table, a rule whose wording matters. Most releases
add nothing here. Add a block only when you have asked yourself whether the heading
comparison would catch the change and the answer is no.

Human-facing release notes belong in the GitHub release, not here. Write these blocks
as instructions to an agent.

Format: one block per version, newest first. An agent reads only the blocks above the
version recorded in the project's AGENTS.md.

---

## 2.2 (2026-09-15)

AGENTS.md gains a `## Commits` section. The structure check finds it, and the wording
comes from the template unchanged.

The default changed. Agents no longer commit at all; the owner reads the diff and
writes the history. A project whose AGENTS.md already grants commit permission keeps
that grant, and you ask the owner whether they still want it before touching the line.
Show them the old wording and the new default side by side.

The attribution rule inside that section is neither a setting nor a question. Apply it
whatever the owner chooses about committing.

Say this to the owner in plain words when you apply it: a coding agent's own harness
often instructs it to add a `Co-Authored-By` trailer, which makes the model a visible
contributor on GitHub. This section overrides that instruction. Where earlier commits
already carry the trailer, offer to amend the recent ones, and tell them a force push
is needed for anything already pushed.

---

## 2.1 (2026-09-15)

The handoff files now stay out of the published repository by default. Copy
`templates/.gitignore.template` to the project root as `.gitignore` when the project
has none, and merge its entries when one exists. Ask the owner first, and tell them
what it costs: a collaborator cloning the remote receives no handoff files, and an
agent on another machine sees the current state only once file sync has finished.

Where the owner wants the repository to carry continuity for a team, uncomment the
four state files in that template and say so in the project's AGENTS.md Authority
section.

The startup reading target in the README moved from roughly 2,000 words to roughly
3,000. Nothing was cut to reach it. No project needs changing.

---

## 2.0 (2026-09-15)

Files to copy into the project if absent:

- `VOICE.md` at the project root. Ask the owner whether the shipped guide is theirs
  before leaving it in place.
- `project-context/LEARNING.md`
- `project-context/ORCHESTRATION.md`, replacing any 1.x copy. The 1.x version carried
  a Codex-only model table and no account of delegation cost.

Values the owner must choose, because no default is safe to assume:

- `Learning mode:` in AGENTS.md. Describe levels 0, 1 and 2 in one sentence each,
  then ask. The starter default is 2.
- Every line of the AGENTS.md Environment section. Ask; write "none" where the owner
  has no such access.

Do not backfill explainers for tasks completed before the upgrade. Offer
`/handoff explain <task-id>` for any single item the owner wants written up.

---

## 1.0 (2026-09-06)

First release. Four startup files, templates, ORCHESTRATION.md.
