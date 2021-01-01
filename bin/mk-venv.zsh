#!/usr/bin/env zsh

set -e
set -u
set -o pipefail
set +x

PARAMETERS=("${(@s/ /)*}")  # convert string to array https://stackoverflow.com/a/2930519/1698426
VIRTUAL_ENV=${1:A}  # expand VIRTUAL_ENV to be the full path to the first parameter
shift PARAMETERS

unset PYTHONHOME

# create a new venv
python3 -m venv ${VIRTUAL_ENV}

# activate the new venv
export VIRTUAL_ENV=${VIRTUAL_ENV}
export PS1="($(basename \"$VIRTUAL_ENV\")${PS1}"
export PATH=${VIRTUAL_ENV}/bin:"$PATH"

# upgrade pip and install required packages
pip install --upgrade pip  # avoid the pip prompt to upgrade
if [[ ${#PARAMETERS[@]} -ne 0 ]]; then
    pip --no-input install ${PARAMETERS}
fi

activate_doc=$(cat << 'EOF'
#!/usr/bin/env zsh

unset PYTHONHOME
export VIRTUAL_ENV=VIRTUAL_ENV_PLACE_HOLDER
export PS1=$(basename ${VIRTUAL_ENV})" ${PS1}"
export PATH=${VIRTUAL_ENV}/bin:${PATH}

zsh -i
EOF
)

activate_script=${activate_doc/VIRTUAL_ENV_PLACE_HOLDER/${VIRTUAL_ENV}}
echo ${activate_script} > activate.zsh
