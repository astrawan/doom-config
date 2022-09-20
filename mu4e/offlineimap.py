#!/usr/bin/env python

import re

from subprocess import check_output


def get_authinfo_pass(gpgfile: str, machine: str, login: str, port: int):
    authinfo = check_output(
        "gpg -dq %s" % gpgfile,
        shell=True
    ).decode().strip("\n")

    s = "machine %s login %s port %d password ([^ ]*)\n" % (
        machine,
        login,
        port
    )
    p = re.compile(s)

    return p.search(authinfo).group(1)
