#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reactor
# @raycast.mode compact

# Optional parameters:
# @raycast.argument1 { "type": "text", "placeholder": "Project", "default": "core" }
# @raycast.argument2 { "type": "text", "placeholder": "Issue Number", "optional": true}

# Documentation:
# @raycast.description Open a Reactor project, or specific issue

import sys
import webbrowser
project = "core"
if (len(sys.argv) > 1):
    project = sys.argv[1]
url = "https://github.com/reactor/reactor-" + project + "/issues"
if len(sys.argv) > 2:
    url += "/" + sys.argv[2]
webbrowser.open(url)