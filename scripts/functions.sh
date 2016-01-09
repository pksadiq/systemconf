# This file contains some common functions

# Returns "true" if the value is "true" or "false", and "false" otherwise
is_true_false ()
{
    CHECK="$1"

    case "${CHECK,,}" in
	true | false)
	    return $(true)
	    ;;
	*)
	    return $(false)
    esac
}

