#!/usr/bin/env python3

import sys
import sqlite3
import subprocess

try:
  db_path = subprocess.Popen(
    args="lsof -p $(ps aux | grep -m1 usernoted | awk '{ print $2 }')| awk '{ print $NF }' | grep 'db2/db$'",
    stdout=subprocess.PIPE,
    shell=True
  ).communicate()[0].decode('ascii').strip()

  conn = sqlite3.connect(db_path)

  notifications = conn.execute("SELECT count(*) FROM record WHERE ((style = 1 AND presented = 1) OR (style = 2)) AND delivered_date > (strftime('%s', datetime('now', 'start of day')) -  978307200)").fetchone()[0]

  conn.close()

  if notifications > 0:
    print("#[fg=brightwhite,bg=red,bold] %d " % notifications, end = "")
except:
  sys.exit(1)
