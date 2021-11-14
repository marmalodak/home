#!/usr/bin/env zsh

set -o pipefail
set -e
set -u
set +x

# TIL about Python's virtualenv tool, it could probably replace all of this...
# TODO: the activate script should check to see if the venv has been created, probably by checking for the existence of the dir or the venv/bin/activate script
# TODO? Should these be renamed? i.e. for a venv named "foo", the filenames are now
# mk-foo-venv.zsh
# foo-requirement.text
# foo-venv
# foo-venv-activate.zsh
# Either rename mk-foo-venv.zsh to foo-mk-venv.zsh to be consistent, so
# foo-mk-venv.zsh
# foo-requirement.text
# foo-venv
# foo-venv-activate.zsh
# The problem is that trying to use completion when using ./foo... will require manual intervention to choose the right completion
# How about:
# mk-foo-venv.zsh
# foo-requirement.text
# foo-venv
# activate-foo-venv.zsh
# That way completions will be more helpful
#
# TODO? Remove the .zsh filename extensions?
#
# TODO? Should there be automation for adding or removing packages from the requirements file?
# No, simply add or delete entries in the requirements file and then run mk-foo-venv... again
#
# I learned about $(echo apath(:A)) from https://stackoverflow.com/a/12566609/1698426
#
# On the mac there is an old Python in /usr/bin and-or /usr/local/bin if the user has tried to install a new Python
# This causes the problem that, when using python3 -m venv ..., the old version of Python will get used to create the virual environment
# So, calling activate without the full path will still invoke the old python, even though there is a newly-created venv
# That's why the newly created activate script must use the full path to the newly-created venv
# This is how I solved the problem of using mk-venv like "mk-venv.zsh foo ipython", then running ipython from the shell would crash because it was invoking the built-in Python

if ((# == 0)); then
    print "${0} MyVenv package1 package2 ..."
    print "Creates two scripts:"
    print "1. mk-MyVenv-venv"
    print "  - run this first, it creates a script called mk-MyVenv-venv.zsh"
    print "  - additionally, this will write a file called MyVenv-venv-requirement.txt which will contain pacage1 package2 ..."
    print "  - when new packages are needed, put them in MyVenv-venv-requirement.txt, the next mk-MyVenv-venv.zsh is run, all the requirements will be installed"
    print "2. MyVenv-venv-activate.zsh -- run this to activate the virtual environtment MyVenv"
    print "  - this will launch a subshell in which MyVenv is activated"
    print "  - simply type exit or control+d to leave the subshell"
    exit 0
fi

PARAMETERS=("${(@s/ /)*}")  # convert string to array https://stackoverflow.com/a/2930519/1698426
VIRTUAL_ENV=${1:A}          # expand VIRTUAL_ENV to be the full path to the first parameter
VIRTUAL_ENV_NAME=$(basename "${VIRTUAL_ENV}")-venv
shift PARAMETERS

if [[ ${#PARAMETERS[@]} -ne 0 ]]; then
    REQUIREMENTS_FILE="${1}"-requirement.text
fi

# ---- create the activate script
activate_doc=$(cat << 'activate_doc_end'
#!/usr/bin/env zsh

set -o pipefail
set -e
set -u
set +x

unset PYTHONHOME
export VIRTUAL_ENV=VIRTUAL_ENV_PLACE_HOLDER
export PS1=$(basename "${VIRTUAL_ENV}" "${PS1}")
export PATH="${VIRTUAL_ENV}/bin:${PATH}"

# WARNING if .zshrc munges the path with Python already, the following will probably have the wrong Python in the PATH
zsh -i  # duh TIL zshrc messes with the path
activate_doc_end
)

activate_script_name="${VIRTUAL_ENV_NAME}-activate.zsh"
activate_script=${activate_doc/VIRTUAL_ENV_PLACE_HOLDER/'$(echo '${VIRTUAL_ENV_NAME}'(:A))'}
echo "${activate_script}" > "${activate_script_name}"
chmod +x "${activate_script_name}"

# ---- create the script to create the virtualenv and also the requirements file
mkvenv_doc=$(cat << 'mkvenv_doc_end'
#!/usr/bin/env zsh

set -o pipefail
set -e
set -u
set +x

python3 -m venv VIRTUAL_ENV_PLACE_HOLDER
venv_path=$(echo b1-venv(:A))

# how did this ever work without the following
unset PYTHONHOME
export VIRTUAL_ENV=${venv_path}
export PS1=$(basename "${VIRTUAL_ENV}" "${PS1}")
export PATH="${venv_path}/bin:${PATH}"

# should the following two use absolute paths?
VIRTUAL_ENV_PLACE_HOLDER/bin/pip3 --no-input install --upgrade pip
REQUIREMENTS_PLACE_HOLDER
mkvenv_doc_end
)


mkvenv_script_name="mk-${VIRTUAL_ENV_NAME}.zsh"
mkvenv_doc=${mkvenv_doc/VIRTUAL_ENV_PATH/'$(echo '${VIRTUAL_ENV_NAME}'(:A))'}
mkvenv_doc="${mkvenv_doc//VIRTUAL_ENV_PLACE_HOLDER/${VIRTUAL_ENV_NAME}}"
if [[ -v REQUIREMENTS_FILE ]]; then
    echo "#  requirements for ${VIRTUAL_ENV_NAME}" > "${REQUIREMENTS_FILE}"
    for python_package in ${PARAMETERS}; do
        echo "${python_package}" >> "${REQUIREMENTS_FILE}"
    done
    mkvenv_script="${mkvenv_doc/REQUIREMENTS_PLACE_HOLDER/${VIRTUAL_ENV_NAME}/bin/pip3 --no-input install --requirement ${REQUIREMENTS_FILE}}"
else
    # if no requirements, no pip -r ... should be present, convert the REQUIREMENtS_PLACE_HOLDER to a blank line
    mkvenv_script="${mkvenv_doc/REQUIREMENTS_PLACE_HOLDER/}"
fi
# WARNING: this next line requires the previous replacement of VIRTUAL_ENV_PLACE_HOLDER to be done already
echo "${mkvenv_script}" > "${mkvenv_script_name}"
chmod +x "${mkvenv_script_name}"
