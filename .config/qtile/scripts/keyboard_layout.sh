while true; do
  layout=$(xkblayout-state print "%s")
  qtile cmd-obj -o widget layout -f update -a "$layout"
  sleep 1
done
