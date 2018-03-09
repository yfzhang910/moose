"""
Tools for parsing key value pairs from a raw string (e.g., 'key=value foo=bar')
"""
import re
import copy

import exceptions

SETTINGS_RE = re.compile(r'(?P<key>[^\s=]+)=(?P<value>.*?)(?=(?:\s[^\s=]+=|$))',
                         flags=re.MULTILINE|re.UNICODE)

def match_settings(defaults, raw):
    """
    Parses a raw string for key, value pairs separated by an equal sign.

    Inputs:
        default[dict]: The default values for the known keys.
        raw[str]: The raw string to parse and inject into a dict().
    """
    known = dict((k, v[0]) for k, v in copy.deepcopy(defaults).iteritems())
    unknown = dict()

    if not raw:
        return known, unknown

    for match in SETTINGS_RE.finditer(raw.replace('\n', ' ')):

        key = match.group('key').strip()
        value = match.group('value').strip()

        if value.lower() == 'true':
            value = True
        elif value.lower() == 'false':
            value = False
        elif value.lower() == 'none':
            value = None
        elif all([v.isdigit() for v in value]):
            value = float(value) #pylint: disable=redefined-variable-type

        if key in known:
            known[key] = value
        else:
            unknown[key] = value

    return known, unknown

def parse_settings(defaults, local, error_on_unknown=True, exc=exceptions.TokenizeException):
    """
    Method for parsing settings given a dict() of defaults. If options are supplied that do not
    have an item in defaults and exception will be raised.

    Inputs:
        defaults[dict]: Default settings.
        local[str]: A string of settings to be parsed.
        error_on_unknown[bool]: If True through an exception if values are provided that are not
                                in the default list.
        exc[Exception]: The Exception type to raise, by default it raises a TokenizeException since
                        this function is used during the tokenization process by MooseDocs.
    """
    settings, unknown = match_settings(defaults, local)
    if error_on_unknown and unknown:
        msg = "The following key, value settings are unknown:"
        for key, value in unknown.iteritems():
            msg += '\n{}{}={}'.format(' '*4, key, repr(value))
        raise exc(msg)
    return settings, unknown
