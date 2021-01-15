; vasmm68k_mot -Fhunkexe -nosym -IFiles:dev/NDK_3.9/Include/include_i -o detect_vampire detect_vampire.s

    INCLUDE "exec/execbase.i"

main:
    moveq #5,d0             ; WARN return code by default
    move.l 4.w,a6           ; execbase
    move.w AttnFlags(a6),d1
    btst #10,d1             ; 68080 bit
    beq.s end
    moveq #0,d0
end:
    rts

