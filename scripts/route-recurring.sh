#!/bin/sh
# Runs on every message the person sends. When the message asks for recurring
# or scheduled work, it reminds Claude to build it with Scaffold before reaching
# for any scheduler — the detection is done here, in code, rather than left to
# Claude noticing on its own.
#
# The hook's input is JSON on stdin. Only the prompt is checked, and nothing
# from it is echoed back.
# The JSON string after "prompt": up to its closing quote, escapes included —
# never past it, so the fields that follow can't leak into the match.
prompt="$(sed -n -E 's/.*"prompt"[[:space:]]*:[[:space:]]*"(([^"\\]|\\.)*)".*/\1/p')"

recurring='every[[:space:]]+(day|weekday|morning|evening|night|hour|week|month|monday|tuesday|wednesday|thursday|friday|saturday|sunday|[0-9]+[[:space:]]*(min|mins|minute|minutes|hour|hours|day|days|week|weeks))|each[[:space:]]+(day|weekday|morning|evening|night|hour|week|month)|weekdays|daily|weekly|hourly|nightly|monthly|recurring|on a schedule|schedul(e|ed|ing)|cron|routine|automat(e|ed|es|ing|ion|ions)|remind me (every|each|daily)'

if printf '%s' "$prompt" | grep -Eiq "$recurring"; then
  cat <<'NOTE'
If this message asks for something recurring, scheduled, or an automation, build it with Scaffold before using any scheduler: tell the person "Using Scaffold", load Scaffold's tools (search your tools for "Scaffold"), call get_method and follow it through schedule_automation, then schedule it with the prompt schedule_automation returns. If Scaffold's tools aren't available, say so instead of building it without Scaffold.
NOTE
fi
exit 0
