#!/usr/bin/env zsh

set -o pipefail
set -e
set -u
set +x

# TODO: write a script like $venv-add pipname that will maintain the requirements.txt file
# does this need a $venv-remove

PARAMETERS=("${(@s/ /)*}")  # convert string to array https://stackoverflow.com/a/2930519/1698426
VIRTUAL_ENV=${1:A}  # expand VIRTUAL_ENV to be the full path to the first parameter
VIRTUAL_ENV_NAME=$(basename "${VIRTUAL_ENV}")
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

activate_script_name="${VIRTUAL_ENV}-activate.zsh"
activate_script="${activate_doc/VIRTUAL_ENV_PLACE_HOLDER/${VIRTUAL_ENV}}"
echo "${activate_script}" > "${activate_script_name}"
chmod +x "${activate_script_name}"

# TODO: the venv should have -venv appended to it
# ---- create the script to create the virtualenv and alsoe the requirements file
mkvenv_doc=$(cat << 'mkvenv_doc_end'
#!/usr/bin/env zsh

set -o pipefail
set -e
set -u
set +x

python3 -m venv VIRTUAL_ENV_PLACE_HOLDER
VIRTUAL_ENV_PLACE_HOLDER/bin/pip3 install --upgrade pip
REQUIREMENTS_PLACE_HOLDER
mkvenv_doc_end
)

mkvenv_script_name="mk-${VIRTUAL_ENV_NAME}-venv.zsh"
mkvenv_doc="${mkvenv_doc/VIRTUAL_ENV_PLACE_HOLDER/${VIRTUAL_ENV}}"
mkvenv_doc="${mkvenv_doc/VIRTUAL_ENV_PLACE_HOLDER/${VIRTUAL_ENV}}"  # yes, this line is duplicated because VIRTUAL_ENV_PLACE_HOLDER occurs twice
if [[ -v REQUIREMENTS_FILE ]]; then
    echo "#  requirements for ${VIRTUAL_ENV_NAME}" > "${REQUIREMENTS_FILE}"
    for parameter in ${PARAMETERS}; do
        echo "${parameter}" >> "${REQUIREMENTS_FILE}"
    done
    mkvenv_script="${mkvenv_doc/REQUIREMENTS_PLACE_HOLDER/${VIRTUAL_ENV}/bin/pip3 install --requirement ${REQUIREMENTS_FILE}}"
else
    mkvenv_script="${mkvenv_doc/REQUIREMENTS_PLACE_HOLDER/}"
fi
echo "${mkvenv_script}" > "${mkvenv_script_name}"
chmod +x "${mkvenv_script_name}"
