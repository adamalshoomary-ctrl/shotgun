# Learning mode

The owner of a project directs the work without reading every line of code. Learning mode makes
each completed item leave behind an explanation the owner can actually read, so the person holding
the decisions keeps up with the system that carries them out.

Learning mode is on by default at level 2. An agent reads this file when it is about to finish a
queue item, not at startup.

## Levels

| Level | Behaviour | Blocks the queue |
| --- | --- | --- |
| 0 | Off. No explainer, no questions. | No |
| 1 | The agent writes an explainer file for each completed item. | No |
| 2 | Explainer file, then two or three comprehension questions answered by the owner, then one correction. Default. | Once, briefly |

The active level lives in AGENTS.md under Learning mode. An instruction in the current conversation
overrides the file for that session; write the change into AGENTS.md only when the owner says the
change is permanent.

## Where explainers live

`learning/<task-id>-<short-slug>.md`, one file per completed queue item. For example
`learning/Q3-session-cookie-expiry.md`.

The `learning/` directory sits outside the startup reading set. An agent writes there and does not
read it back, with one exception: at level 2 the agent may open the single file it is currently
writing. Never load the directory to "get context". The explainers exist for the owner.

Add one line under the finished task in improvement-plan.md:

    Explainer: learning/Q3-session-cookie-expiry.md

That line is the only trace the queue carries. It costs about ten tokens and makes the record
navigable a month later.

### Optional retention setting

An owner who wants the directory to stay at one file can set this in AGENTS.md:

    Learning retention: latest only

With that line present, the agent deletes the previous explainer when it writes a new one, and
removes the stale `Explainer:` line from the queue. Without the line, every explainer is kept.
Never turn this on by yourself. Deleting somebody's notes because a directory looked large is not
a decision an agent gets to make.

## What an explainer contains

Length follows the change. A one-line configuration edit earns eighty words. A new authentication
flow earns twelve hundred. Write for a reader who cannot yet read the code and who will be asked
about this work in a meeting.

Use these headings, and drop any that would be empty:

**What I changed.** Files, and what each one now does. Name them.

**Why it was needed.** The problem in the owner's terms. What a user or the system could not do
before.

**How it works.** The mechanism in plain language. Follow one request, one click or one run from
start to finish. Use the real names from the code so the owner can find them, and explain each
name the first time it appears.

**The concept worth knowing.** One idea, chosen because it will come up again in this project.
Session tokens, idempotency, a migration, a race condition. Teach it on its own terms, then point
at the line where it appears here.

**What I rejected and why.** The other approach that was reasonable, and the reason this one won.
This is the section that teaches judgement rather than facts.

**What to check if it breaks.** The first two places to look, the command to run, and what a
healthy result looks like.

Follow VOICE.md. Plain language is not baby language: no metaphors doing the work of an
explanation, no cheerfulness, and no claim the evidence does not support. If something is genuinely
uncertain, write that it is uncertain.

## Level 2: questions and correction

After writing the explainer, ask two or three questions in the conversation. Then stop and wait.

### Three rules for a question

**Ask about something the owner watched happen.** They sat through this session. They
saw the thing break, saw you choose, saw the check pass. A question about that has a
way in. A question about a general principle asks them to learn the principle and apply
it in the same breath, which is two hard things at once and they will bounce off both.

**Use the words that were used at the time.** No term the explainer has not already
defined and no term that arrived with you. If the session called it "the warning that
was wrong", the question says that, whatever the field calls it.

**Ask what would change, and make the answer matter.** A good question has a
consequence the owner can picture. "What happens to you after the third wrong warning?"
teaches. "What is the name of the function?" teaches nothing, and so does anything the
explainer answers in a sentence they can copy back.

### Worked pair

The same question, twice.

> Bad: I argued false positives are worse than false negatives here. What is the
> specific behaviour that makes them worse?

Two terms the owner has never used, a comparison stated as a premise they have to
accept before they can answer, and nothing from the session in it. This question was
asked on 2026-09-15 and the owner answered "what?".

> Good: Three times today the update told us a field was missing and it was sitting
> right there in the file. If that kept happening, what do you think you would start
> doing when it showed you the next report?

Same idea. It names what they watched, it asks about them rather than about a category
of error, and the answer is something they already know about themselves.

### When the owner cannot follow the question

That is your fault and you fix it on the spot. Answer all of the questions yourself, in
the plainest language you have, and write "not answered" against each one. Log the
cause under **Recurring gap**, naming what made the question unanswerable. Then move on.

Never re-ask a reworded version in the same session. The owner has already told you the
question missed, and asking again makes them pay twice for your mistake.

When an answer is wrong or partial, correct it once, in one reply, plainly. Then continue to the
next item. Do not re-ask, do not quiz around the edges, and do not make the owner earn their way
out. Record the exchange at the bottom of the explainer file under **Questions and answers**, with
the owner's answer as given and the correction underneath it.

If the owner declines to answer, says skip, or does not respond, write "not answered" in that
section and carry on. Level 2 costs one pause per item. It must never cost two.

If the same misunderstanding appears in a second explainer, add one line under
**Recurring gap** naming it, and pitch the next explainer's concept section at that gap. Do not
build a separate tracking file for this.

## Cost

An explainer is written by the agent that did the work, because that agent already holds the
context. Delegating the writing to a cheaper model means sending the whole change across, which
costs more than writing it directly. A typical level-1 explainer adds five hundred to fifteen
hundred output tokens per completed item. Level 2 adds one short exchange.
