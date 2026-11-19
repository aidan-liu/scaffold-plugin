# Scaffold

Scaffold turns recurring work you ask Claude for — "every weekday at 9am, get
the top Hacker News stories and summarize them" — into a durable automation:
scripts for the mechanical steps, Claude only where judgement is needed, and
runs that heal themselves from their own history.

## Use it

- **Ask for something recurring**, in chat, Cowork or Claude Code. Claude plans
  it with Scaffold, shows you how Scaffold changed it (which steps became
  scripts, and the exact commands they run), and saves it to your Scaffold
  account.
- **Ask how an automation is doing** to see its runs, roughly how many tokens
  its scripts saved, and what Scaffold healed and why.
- **Ask Claude to delete an automation**, with its run records.

Automations run on your own computer, through Scaffold's local runner, never in
the cloud. A saved automation runs once a computer linked to your Scaffold
account has the local runner: https://scaffold-ai.tech/docs explains how.

## What's in this plugin

- **The `scaffold-automations` skill**: instructions that tell Claude to build
  recurring requests with Scaffold.
- **The Scaffold connector** (`scaffold`, `https://api.scaffold-ai.tech/mcp`):
  connect it once from the plugin's Connectors tab and sign in with Google.

Nothing in this plugin runs on your computer: no local server, hooks or scripts.

## What it sends, and where

To **`https://api.scaffold-ai.tech`**, Scaffold's server, when Claude uses one of
Scaffold's tools for you:

- **Plans** to draw and to check against shared run evidence: step types, the
  hosts they call, and operation templates such as `GET /v1/items/{id}`.
- **Automations you save**: their plan and scripts, kept in your account until
  you delete them.
- **Field notes**: short facts about a service that Claude chooses to record.

To **`https://api.github.com`**, only when you ask Scaffold to read a public
repository.

## Privacy

Privacy policy: <https://scaffold-ai.tech/privacy>. Delete an automation by
asking Claude, or your whole account and its data at
<https://api.scaffold-ai.tech/account/delete>.
