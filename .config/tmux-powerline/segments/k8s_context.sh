run_segment() {
  if type kubectx >/dev/null 2>&1; then
    __ctx="$(kubectx -c)"
    if [ "${#__ctx}" -gt 32 ]; then
      __ctx="$(echo "$__ctx" | cut -c1-29)..."
    fi
    echo "$__ctx"
  fi
}
