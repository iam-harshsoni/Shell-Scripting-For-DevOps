#!/bin/bash
#
echo this is a very long command that will cause an error because it exceeds the line length limit

echo this is a very long command \
that will not cause an error \
because it uses line continuation
