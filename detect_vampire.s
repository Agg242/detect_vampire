; vasmm68k_mot -Fhunkexe -IFiles:dev/NDK_3.9/Include/include_i -o detect_vampire detect_vampire.s

    INCLUDE "exec/execbase.i"

main:
    moveq #5,d0                 ; WARN return code by default
    move.l 4.w,a6               ; execbase
    move.l MemList+LH_TAILPRED(a6),d1 ; end marker
    move.l MemList+LH_HEAD(a6),a0     ; first node
nodes_loop:
    cmp.l LN_PRED(a0),d1        ; end of list ?
    beq end
    move.l LN_NAME(a0),a1       ; mem node name
    move.l #vampire_name,a2     ; Vampire mem name
    move.w #name_end-vampire_name-1,d2    ; name len
next_char:
    cmp.b (a1)+,(a2)+           ; compare strings
    dbne d2,next_char

    tst.w d2
    bpl next_node               ; >=0 ? compare not completed ?
    clr.l d0                    ; SUCCESS return code
    bra end

next_node:
    move.l LN_SUCC(a0),a0
    bra nodes_loop

end:
    rts

vampire_name:
    dc.b "VampireFastMem",0
name_end:
