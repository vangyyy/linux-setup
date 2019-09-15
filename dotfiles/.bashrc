# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

shopt -s expand_aliases # Expand aliases with autocomplete .. no shit Sherlock
shopt -s histappend     # Append to the Bash history file, rather than overwriting it
shopt -s cdspell        # Autocorrect typos in path names when using `cd`
shopt -s autocd         # Prepend cd befor plain path
shopt -s checkwinsize   # Check the window size after each command and resize if needed

complete -cf sudo # Tab-complete command names and file names
