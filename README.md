# can-translate

a macOS utility to read json translation files and append new translation values to related files.

functionality,
- gets user input from NSTextfield,
- check the string and parse "tab-separated values"
- if the input format not proper present a NSAlert
- open a directory picker using NSOpenPanel,
- set the path of the ".json" files directory
...


** Note: 

!!! Command prompt like (CMD+C, CMD+V) not working in NSTextfield,
You should manually add these features to NSTextField by overriding performKeyEquivalent method
