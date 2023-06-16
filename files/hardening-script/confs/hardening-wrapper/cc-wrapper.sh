#!/bin/bash

. "${0%/*}/../common.sh"

declare -A default
while IFS== read key value; do
  default["$key"]="$value"
done < /etc/hardening-wrapper.conf

force_fPIE="${HARDENING_PIE:-"${default[HARDENING_PIE]:-1}"}"
force_fortify="${HARDENING_FORTIFY:-"${default[HARDENING_FORTIFY]:-2}"}"
force_pie="${HARDENING_PIE:-"${default[HARDENING_PIE]:-1}"}"
force_stack_check="${HARDENING_STACK_CHECK:-"${default[HARDENING_STACK_CHECK]:-1}"}"
force_stack_protector="${HARDENING_STACK_PROTECTOR:-"${default[HARDENING_STACK_PROTECTOR]:-3}"}"

optimizing=0

for opt; do
  case "$opt" in
    -fno-PIC|-fno-pic|-fno-PIE|-fno-pie|-nopie|-static|--static|-shared|--shared|-D__KERNEL__|-nostdlib|-nostartfiles|-mcmodel=kernel)
      force_fPIE=1
      force_pie=1
      ;;
    -fPIC|-fpic|-fPIE|-fpie)
      force_fPIE=1
      ;;
    -c|-E|-S)
      force_pie=1
      ;;
    -nostdlib|-ffreestanding)
      force_stack_protector=3
      ;;
    -D_FORTIFY_SOURCE*)
      force_fortify=2
      ;;
    -O0)
      optimizing=0
      ;;
    -O*)
      optimizing=2
      ;;
  esac
done

arguments=(-B/usr/lib/hardening-wrapper/bin)

case "$force_fPIE" in
  0) ;;
  1) arguments+=(-fPIE) ;;
  *) error 'invalid value for HARDENING_PIE' ;;
esac

case "$force_fortify" in
  0) ;;
  1|2) (( optimizing )) && arguments+=(-D_FORTIFY_SOURCE=$force_fortify) ;;
  *) error 'invalid value for HARDENING_FORTIFY' ;;
esac

case "$force_pie" in
  0) ;;
  1) arguments+=(-pie) ;;
  *) error 'invalid value for HARDENING_PIE' ;;
esac

case "$force_stack_check" in
  0) ;;
  1) arguments+=(-fstack-check) ;;
  *) error 'invalid value for HARDENING_STACK_CHECK' ;;
esac

case "$force_stack_protector" in
  0) ;;
  1) arguments+=(-fstack-protector) ;;
  2) arguments+=(-fstack-protector-strong) ;;
  3) arguments+=(-fstack-protector-all) ;;
  *) error 'invalid value for HARDENING_STACK_PROTECTOR' ;;
esac

run_wrapped_binary "$@"
