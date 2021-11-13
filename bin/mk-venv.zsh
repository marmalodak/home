#!/usr/bin/env zsh

set -o pipefail
set -e
set -u
set +x

# should there be automation for adding or removing packages from the requirements file?
# or should the customer simply modify the requirements file by hand?

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
VIRTUAL_ENV=${1:A}  # expand VIRTUAL_ENV to be the full path to the first parameter
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

zsh -i
activate_doc_end
)

activate_script_name="${VIRTUAL_ENV_NAME}-activate.zsh"
activate_script="${activate_doc/VIRTUAL_ENV_PLACE_HOLDER/${VIRTUAL_ENV_NAME}}"
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
VIRTUAL_ENV_PLACE_HOLDER/bin/pip3 --no-input install --upgrade pip
REQUIREMENTS_PLACE_HOLDER
mkvenv_doc_end
)

mkvenv_script_name="mk-${VIRTUAL_ENV_NAME}.zsh"
mkvenv_doc="${mkvenv_doc//VIRTUAL_ENV_PLACE_HOLDER/${VIRTUAL_ENV_NAME}}"
if [[ -v REQUIREMENTS_FILE ]]; then
    echo "#  requirements for ${VIRTUAL_ENV_NAME}" > "${REQUIREMENTS_FILE}"
    for parameter in ${PARAMETERS}; do
        echo "${parameter}" >> "${REQUIREMENTS_FILE}"
    done
    mkvenv_script="${mkvenv_doc/REQUIREMENTS_PLACE_HOLDER/${VIRTUAL_ENV_NAME}/bin/pip3 --no-input install --requirement ${REQUIREMENTS_FILE}}"
else
    mkvenv_script="${mkvenv_doc/REQUIREMENTS_PLACE_HOLDER/}"
fi
echo "${mkvenv_script}" > "${mkvenv_script_name}"
chmod +x "${mkvenv_script_name}"
