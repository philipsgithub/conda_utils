# Utils
air() {
  if [[ $(which conda) ]]; then
    if [[ $1 == "" || $1 == "--help" || ( $1 != "" && $2 == "" ) ]]; then
      echo "--- usage: air ENV PY_SCRIPT ---"
      return
    fi
    envlist=$(conda env list | tail +3 | head -n -1)
    path=$(grep ^$1 <<< "$envlist" | awk '{print $2}')
    if [[ $path ]]; then
      if [ "${path}" = "*" ]; then
        echo "--- running in base env not possible ---"
        return
      fi
      binpath="${path}/bin/python"
      echo "--- using: ${binpath} ---"
      $binpath $2
    else
      echo "--- no env starting with \"$1\", current list:  ---"
      awk '{print $1}' <<< $envlist
      echo "---"
    fi
  else
    echo "--- conda is not sourced ---"
  fi
}
