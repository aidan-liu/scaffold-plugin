# Scaffold

Scaffold turns recurring work you ask Claude for — "every weekday at 9am, get
the top Hacker News stories and summarize them" — into a durable automation:
scripts for the mechanical steps, Claude only where judgement is needed, and
runs that heal themselves from their own history.

## Use it

- **Ask for something recurring**, in chat or in Claude Code. Claude plans it
  with Scaffold, shows you how Scaffold changed it (which steps became scripts,
  and the exact commands they run), and schedules it on your computer.
- **Automations you build in chat** are saved to your Scaffold account. If chat
  can't schedule on your computer, Claude Code offers to set them up the next
  time you open it.
- **Ask how an automation is doing** to see its runs, roughly how many tokens
  its scripts saved, and what Scaffold healed and why.

For chat, add the Scaffold connector once: Customize → Connectors → Add custom
connector, with the URL `https://api.scaffold-ai.tech/mcp`. Running
automations needs Node.js 22.13 or newer on your computer.

## What it runs on your computer

- **The `scaffold-automations` skill** — instructions that tell Claude to build
  recurring requests with Scaffold.
- **A local server** (`server/server.mjs`, started by `scripts/scaffold-server.sh`,
  which looks for Node.js 22.13+). It provides Scaffold's tools and runs an
  automation's script steps in that automation's folder under `~/Scaffold/`.
  It only runs the commands you were shown when the automation was scheduled:
  if a saved plan's commands change without your approval, it refuses to run.
- **A `UserPromptSubmit` hook** (`scripts/route-recurring.sh`). It checks your
  message on your computer for scheduling words ("every weekday", "daily",
  "cron" and so on) and, if it finds them, adds a short note reminding Claude to
  use Scaffold. Nothing from this hook leaves your computer.
- **A `SessionStart` hook** (`scaffold-server.sh pending`). When a Claude Code
  session starts, it asks Scaffold's server which automations in your account
  haven't run on this computer yet, so Claude can offer to schedule them. It
  creates nothing without your yes.

## What it sends, and where

To **`https://api.scaffold-ai.tech`**, Scaffold's server, with your Scaffold key
when you've set one:

- **Plans to check against shared run evidence** — structure only: step types,
  the hosts they call, and operation templates such as `GET /v1/items/{id}`.
  Never inputs, outputs, or file contents.
- **Run outcomes, when "Share run outcomes" is on** (it is by default): which
  host and operation a step used, whether it worked, and the kind of error.
  Never inputs, outputs, or file contents. Turn it off in the plugin's settings
  and outcomes stay on your computer.
- **Automations saved from chat**: their plan and scripts are downloaded into
  `~/Scaffold/<automation>/`, and each run's record goes back to your account —
  step statuses, timings, a savings estimate, and what was healed — along with
  any script Claude repaired, so your account's copy stays current.
- **Field notes** — short facts about a service that Claude chooses to record.

To **`https://api.github.com`**, only when you ask Scaffold to read a public
repository (`analyze_repo`).

The scripts in your automations call whatever services they were written for.

Scaffold keeps its data on your computer in `~/.scaffold-connector/` (run
history, and the outbox of records waiting to be sent) and `~/Scaffold/` (your
automations' folders).

## Settings

- **Scaffold key** (optional) — links the plugin to your Scaffold account.
  Without it, everything runs locally on the free tier.
- **Share run outcomes** — on by default; turn it off to keep outcomes on this
  computer.

## Support

Open an issue at <https://github.com/aidan-liu/scaffold-plugin/issues>.

## License

All rights reserved — see [LICENSE](LICENSE).
