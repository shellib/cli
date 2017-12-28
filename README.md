# cli 

A simple shell library with cli utilities.

## hasflag
 Checks if a flag is present in the arguments. Returns 'true' if its present, or nothing otherwise.
 
Example:
    
    hasflag --help $*
    
## readopt
Read the value of an option. It returns the next argument following the option.

Example:
    
    readopt --log-level $*

## or
Returns the first argument if not empty, the second otherwise.

    value=$(or $candidate "default value")
