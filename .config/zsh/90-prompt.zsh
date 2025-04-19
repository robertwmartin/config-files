
# Prompt colors
PROMPT_DIR_COLOR="%F{cyan}"         # cwd path
PROMPT_LABEL_COLOR="%F{yellow}"     # "Currently working in"
PROMPT_SYMBOL_COLOR="%F{green}"     # actual prompt character
RESET="%f"                          # reset color

# Custom prompt line — note the double quotes!
# One leading newline for breathing room
PROMPT="
${PROMPT_LABEL_COLOR}Currently working in ${PROMPT_DIR_COLOR}%~${RESET}
${PROMPT_SYMBOL_COLOR}➜ ${RESET}"

