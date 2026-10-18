;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.6.0 #16555 (MINGW64)
;--------------------------------------------------------
	.module weather_8051
	
	.optsdcc -mmcs51 --model-small
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _now
	.globl _serial_isr
	.globl _timer0_isr
	.globl _CY
	.globl _AC
	.globl _F0
	.globl _RS1
	.globl _RS0
	.globl _OV
	.globl _F1
	.globl _P
	.globl _PS
	.globl _PT1
	.globl _PX1
	.globl _PT0
	.globl _PX0
	.globl _RD
	.globl _WR
	.globl _T1
	.globl _T0
	.globl _INT1
	.globl _INT0
	.globl _TXD
	.globl _RXD
	.globl _P3_7
	.globl _P3_6
	.globl _P3_5
	.globl _P3_4
	.globl _P3_3
	.globl _P3_2
	.globl _P3_1
	.globl _P3_0
	.globl _EA
	.globl _ES
	.globl _ET1
	.globl _EX1
	.globl _ET0
	.globl _EX0
	.globl _P2_7
	.globl _P2_6
	.globl _P2_5
	.globl _P2_4
	.globl _P2_3
	.globl _P2_2
	.globl _P2_1
	.globl _P2_0
	.globl _SM0
	.globl _SM1
	.globl _SM2
	.globl _REN
	.globl _TB8
	.globl _RB8
	.globl _TI
	.globl _RI
	.globl _P1_7
	.globl _P1_6
	.globl _P1_5
	.globl _P1_4
	.globl _P1_3
	.globl _P1_2
	.globl _P1_1
	.globl _P1_0
	.globl _TF1
	.globl _TR1
	.globl _TF0
	.globl _TR0
	.globl _IE1
	.globl _IT1
	.globl _IE0
	.globl _IT0
	.globl _P0_7
	.globl _P0_6
	.globl _P0_5
	.globl _P0_4
	.globl _P0_3
	.globl _P0_2
	.globl _P0_1
	.globl _P0_0
	.globl _B
	.globl _ACC
	.globl _PSW
	.globl _IP
	.globl _P3
	.globl _IE
	.globl _P2
	.globl _SBUF
	.globl _SCON
	.globl _P1
	.globl _TH1
	.globl _TH0
	.globl _TL1
	.globl _TL0
	.globl _TMOD
	.globl _TCON
	.globl _PCON
	.globl _DPH
	.globl _DPL
	.globl _SP
	.globl _P0
	.globl _hash_seen
	.globl _newcmd
	.globl _cmd
	.globl _ticks
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0	=	0x0080
_SP	=	0x0081
_DPL	=	0x0082
_DPH	=	0x0083
_PCON	=	0x0087
_TCON	=	0x0088
_TMOD	=	0x0089
_TL0	=	0x008a
_TL1	=	0x008b
_TH0	=	0x008c
_TH1	=	0x008d
_P1	=	0x0090
_SCON	=	0x0098
_SBUF	=	0x0099
_P2	=	0x00a0
_IE	=	0x00a8
_P3	=	0x00b0
_IP	=	0x00b8
_PSW	=	0x00d0
_ACC	=	0x00e0
_B	=	0x00f0
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
	.area RSEG    (ABS,DATA)
	.org 0x0000
_P0_0	=	0x0080
_P0_1	=	0x0081
_P0_2	=	0x0082
_P0_3	=	0x0083
_P0_4	=	0x0084
_P0_5	=	0x0085
_P0_6	=	0x0086
_P0_7	=	0x0087
_IT0	=	0x0088
_IE0	=	0x0089
_IT1	=	0x008a
_IE1	=	0x008b
_TR0	=	0x008c
_TF0	=	0x008d
_TR1	=	0x008e
_TF1	=	0x008f
_P1_0	=	0x0090
_P1_1	=	0x0091
_P1_2	=	0x0092
_P1_3	=	0x0093
_P1_4	=	0x0094
_P1_5	=	0x0095
_P1_6	=	0x0096
_P1_7	=	0x0097
_RI	=	0x0098
_TI	=	0x0099
_RB8	=	0x009a
_TB8	=	0x009b
_REN	=	0x009c
_SM2	=	0x009d
_SM1	=	0x009e
_SM0	=	0x009f
_P2_0	=	0x00a0
_P2_1	=	0x00a1
_P2_2	=	0x00a2
_P2_3	=	0x00a3
_P2_4	=	0x00a4
_P2_5	=	0x00a5
_P2_6	=	0x00a6
_P2_7	=	0x00a7
_EX0	=	0x00a8
_ET0	=	0x00a9
_EX1	=	0x00aa
_ET1	=	0x00ab
_ES	=	0x00ac
_EA	=	0x00af
_P3_0	=	0x00b0
_P3_1	=	0x00b1
_P3_2	=	0x00b2
_P3_3	=	0x00b3
_P3_4	=	0x00b4
_P3_5	=	0x00b5
_P3_6	=	0x00b6
_P3_7	=	0x00b7
_RXD	=	0x00b0
_TXD	=	0x00b1
_INT0	=	0x00b2
_INT1	=	0x00b3
_T0	=	0x00b4
_T1	=	0x00b5
_WR	=	0x00b6
_RD	=	0x00b7
_PX0	=	0x00b8
_PT0	=	0x00b9
_PX1	=	0x00ba
_PT1	=	0x00bb
_PS	=	0x00bc
_P	=	0x00d0
_F1	=	0x00d1
_OV	=	0x00d2
_RS0	=	0x00d3
_RS1	=	0x00d4
_F0	=	0x00d5
_AC	=	0x00d6
_CY	=	0x00d7
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	.area REG_BANK_0	(REL,OVR,DATA)
	.ds 8
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	.area DSEG    (DATA)
_ticks::
	.ds 2
_cmd::
	.ds 1
_newcmd::
	.ds 1
_hash_seen::
	.ds 1
_main_storm_start_10000_16:
	.ds 2
_main_prev_10000_16:
	.ds 1
;--------------------------------------------------------
; overlayable items in internal ram
;--------------------------------------------------------
	.area	OSEG    (OVR,DATA)
;--------------------------------------------------------
; Stack segment in internal ram
;--------------------------------------------------------
	.area SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	.area ISEG    (DATA)
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	.area IABS    (ABS,DATA)
	.area IABS    (ABS,DATA)
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	.area BSEG    (BIT)
_main_sloc0_1_0:
	.ds 1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	.area PSEG    (PAG,XDATA)
;--------------------------------------------------------
; uninitialized external ram data
;--------------------------------------------------------
	.area XSEG    (XDATA)
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area XABS    (ABS,XDATA)
;--------------------------------------------------------
; initialized external ram data
;--------------------------------------------------------
	.area XISEG   (XDATA)
	.area HOME    (CODE)
	.area GSINIT0 (CODE)
	.area GSINIT1 (CODE)
	.area GSINIT2 (CODE)
	.area GSINIT3 (CODE)
	.area GSINIT4 (CODE)
	.area GSINIT5 (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area CSEG    (CODE)
;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------
	.area HOME    (CODE)
__interrupt_vect:
	ljmp	__sdcc_gsinit_startup
	reti
	.ds	7
	ljmp	_timer0_isr
	.ds	5
	reti
	.ds	7
	reti
	.ds	7
	ljmp	_serial_isr
; restartable atomic support routines
	.ds	2
sdcc_atomic_exchange_rollback_start::
	nop
	nop
sdcc_atomic_exchange_pdata_impl:
	movx	a, @r0
	mov	r3, a
	mov	a, r2
	movx	@r0, a
	sjmp	sdcc_atomic_exchange_exit
	nop
	nop
sdcc_atomic_exchange_xdata_impl:
	movx	a, @dptr
	mov	r3, a
	mov	a, r2
	movx	@dptr, a
	sjmp	sdcc_atomic_exchange_exit
sdcc_atomic_compare_exchange_idata_impl:
	mov	a, @r0
	cjne	a, ar2, .+#5
	mov	a, r3
	mov	@r0, a
	ret
	nop
sdcc_atomic_compare_exchange_pdata_impl:
	movx	a, @r0
	cjne	a, ar2, .+#5
	mov	a, r3
	movx	@r0, a
	ret
	nop
sdcc_atomic_compare_exchange_xdata_impl:
	movx	a, @dptr
	cjne	a, ar2, .+#5
	mov	a, r3
	movx	@dptr, a
	ret
sdcc_atomic_exchange_rollback_end::

sdcc_atomic_exchange_gptr_impl::
	jnb	b.6, sdcc_atomic_exchange_xdata_impl
	mov	r0, dpl
	jb	b.5, sdcc_atomic_exchange_pdata_impl
sdcc_atomic_exchange_idata_impl:
	mov	a, r2
	xch	a, @r0
	mov	dpl, a
	ret
sdcc_atomic_exchange_exit:
	mov	dpl, r3
	ret
sdcc_atomic_compare_exchange_gptr_impl::
	jnb	b.6, sdcc_atomic_compare_exchange_xdata_impl
	mov	r0, dpl
	jb	b.5, sdcc_atomic_compare_exchange_pdata_impl
	sjmp	sdcc_atomic_compare_exchange_idata_impl
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME    (CODE)
	.area GSINIT  (CODE)
	.area GSFINAL (CODE)
	.area GSINIT  (CODE)
	.globl __sdcc_gsinit_startup
	.globl __sdcc_program_startup
	.globl __start__stack
	.globl __mcs51_genXINIT
	.globl __mcs51_genXRAMCLEAR
	.globl __mcs51_genRAMCLEAR
;	weather_8051.c:29: volatile unsigned int  ticks = 0;     /* +1 every 10 ms */
	clr	a
	mov	_ticks,a
	mov	(_ticks + 1),a
;	weather_8051.c:30: volatile unsigned char cmd = 'S';     /* last status letter */
	mov	_cmd,#0x53
;	weather_8051.c:31: volatile unsigned char newcmd = 0;
	mov	_newcmd,a
;	weather_8051.c:32: volatile unsigned char hash_seen = 0; /* '#' received, letter comes next */
	mov	_hash_seen,a
	.area GSFINAL (CODE)
	ljmp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME    (CODE)
	.area HOME    (CODE)
__sdcc_program_startup:
	lcall	_main
__sdcc_program_exit:
	sjmp	.
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CSEG    (CODE)
;------------------------------------------------------------
;Allocation info for local variables in function 'timer0_isr'
;------------------------------------------------------------
;	weather_8051.c:35: void timer0_isr(void) __interrupt(1)
;	-----------------------------------------
;	 function timer0_isr
;	-----------------------------------------
_timer0_isr:
	ar7 = 0x07
	ar6 = 0x06
	ar5 = 0x05
	ar4 = 0x04
	ar3 = 0x03
	ar2 = 0x02
	ar1 = 0x01
	ar0 = 0x00
	push	acc
	push	ar7
	push	ar6
	push	psw
	mov	psw,#0x00
;	weather_8051.c:37: TH0 = 0xDC; TL0 = 0x00;           /* 65536 - 9216 = 0xDC00 */
	mov	_TH0,#0xdc
	mov	_TL0,#0x00
;	weather_8051.c:38: ticks++;
	mov	r6,_ticks
	mov	r7,(_ticks + 1)
	mov	a,#0x01
	add	a, r6
	mov	_ticks,a
	clr	a
	addc	a, r7
	mov	(_ticks + 1),a
;	weather_8051.c:39: }
	pop	psw
	pop	ar6
	pop	ar7
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'serial_isr'
;------------------------------------------------------------
;c             Allocated to registers r7 
;------------------------------------------------------------
;	weather_8051.c:42: void serial_isr(void) __interrupt(4)
;	-----------------------------------------
;	 function serial_isr
;	-----------------------------------------
_serial_isr:
	push	acc
	push	ar7
	push	psw
	mov	psw,#0x00
;	weather_8051.c:45: if (RI) {
;	weather_8051.c:46: RI = 0;
;	assignBit
	jbc	_RI,00165$
	sjmp	00111$
00165$:
;	weather_8051.c:47: c = SBUF;
	mov	r7,_SBUF
;	weather_8051.c:48: if (c == '#') {
	cjne	r7,#0x23,00108$
;	weather_8051.c:49: hash_seen = 1;                    /* start of a status */
	mov	_hash_seen,#0x01
	sjmp	00111$
00108$:
;	weather_8051.c:51: if (hash_seen && (c == 'S' || c == 'I' || c == 'R' || c == 'W')) {
	mov	a,_hash_seen
	jz	00102$
	cjne	r7,#0x53,00169$
	sjmp	00101$
00169$:
	cjne	r7,#0x49,00170$
	sjmp	00101$
00170$:
	cjne	r7,#0x52,00171$
	sjmp	00101$
00171$:
	cjne	r7,#0x57,00102$
00101$:
;	weather_8051.c:52: cmd = c;
	mov	_cmd,r7
;	weather_8051.c:53: newcmd = 1;
	mov	_newcmd,#0x01
00102$:
;	weather_8051.c:55: hash_seen = 0;                    /* ignore any other text */
	mov	_hash_seen,#0x00
00111$:
;	weather_8051.c:58: if (TI) TI = 0;
;	assignBit
	jbc	_TI,00174$
00174$:
;	weather_8051.c:59: }
	pop	psw
	pop	ar7
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'now'
;------------------------------------------------------------
;t             Allocated to registers 
;------------------------------------------------------------
;	weather_8051.c:61: unsigned int now(void)                /* safe read of 16-bit tick count */
;	-----------------------------------------
;	 function now
;	-----------------------------------------
_now:
;	weather_8051.c:64: ET0 = 0; t = ticks; ET0 = 1;
;	assignBit
	clr	_ET0
	mov	dpl,_ticks
	mov	dph,(_ticks + 1)
;	assignBit
	setb	_ET0
;	weather_8051.c:65: return t;
;	weather_8051.c:66: }
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;t0            Allocated to registers r1 r2 
;last_rx       Allocated to registers r3 r4 
;storm_start   Allocated with name '_main_storm_start_10000_16'
;prev          Allocated with name '_main_prev_10000_16'
;nodata        Allocated to registers r0 
;------------------------------------------------------------
;	weather_8051.c:68: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	weather_8051.c:70: unsigned int t0, last_rx = 0, storm_start = 0;
	clr	a
	mov	_main_storm_start_10000_16,a
	mov	(_main_storm_start_10000_16 + 1),a
;	weather_8051.c:71: unsigned char prev = 'S', nodata;
	mov	_main_prev_10000_16,#0x53
;	weather_8051.c:73: BUZ = OFF; LED = OFF;
;	assignBit
	setb	_P1_2
;	assignBit
	setb	_P1_3
;	weather_8051.c:75: TMOD = 0x21;          /* Timer1 mode 2 (baud), Timer0 mode 1 (tick) */
	mov	_TMOD,#0x21
;	weather_8051.c:76: TH1  = 0xFD;          /* 9600 baud @ 11.0592 MHz */
	mov	_TH1,#0xfd
;	weather_8051.c:77: SCON = 0x50;          /* serial mode 1, receive on */
	mov	_SCON,#0x50
;	weather_8051.c:78: TR1  = 1;
;	assignBit
	setb	_TR1
;	weather_8051.c:79: TH0  = 0xDC; TL0 = 0x00; TR0 = 1;
	mov	_TH0,#0xdc
	mov	_TL0,#0x00
;	assignBit
	setb	_TR0
;	weather_8051.c:80: ET0  = 1; ES = 1; EA = 1;
;	assignBit
	setb	_ET0
;	assignBit
	setb	_ES
;	assignBit
	setb	_EA
;	weather_8051.c:82: last_rx = now() - NO_DATA;        /* start in "no data" until ESP32 talks */
	lcall	_now
	mov	a, dpl
	mov	b, dph
	add	a,#0x0c
	mov	r3,a
	mov	a,b
	addc	a,#0xfe
	mov	r4,a
;	weather_8051.c:84: while (1) {
00116$:
;	weather_8051.c:85: t0 = now();
	push	ar4
	push	ar3
	lcall	_now
	mov	r1, dpl
	mov	r2, dph
	pop	ar3
	pop	ar4
;	weather_8051.c:87: if (newcmd) {                 /* new letter arrived */
	mov	a,_newcmd
	jz	00105$
;	weather_8051.c:88: newcmd = 0;
	mov	_newcmd,#0x00
;	weather_8051.c:89: last_rx = t0;
	mov	ar3,r1
	mov	ar4,r2
;	weather_8051.c:90: if (cmd == 'W' && prev != 'W') storm_start = t0;   /* storm just started */
	mov	a,#0x57
	cjne	a,_cmd,00102$
	mov	a,#0x57
	cjne	a,_main_prev_10000_16,00200$
	sjmp	00102$
00200$:
	mov	_main_storm_start_10000_16,r1
	mov	(_main_storm_start_10000_16 + 1),r2
00102$:
;	weather_8051.c:91: prev = cmd;
	mov	_main_prev_10000_16,_cmd
00105$:
;	weather_8051.c:94: nodata = ((t0 - last_rx) >= NO_DATA);
	mov	a,r1
	clr	c
	subb	a,r3
	mov	r0,a
	mov	a,r2
	subb	a,r4
	mov	r5,a
	clr	c
	mov	a,r0
	subb	a,#0xf4
	mov	a,r5
	subb	a,#0x01
	cpl	c
	mov	_main_sloc0_1_0,c
	clr	a
	rlc	a
;	weather_8051.c:97: if (nodata)          LED = ((t0 / 10) & 1) ? ON : OFF;  /* fast blink: 0.1 s */
	mov	r0,a
	jz	00113$
	mov	__divuint_PARM_2,#0x0a
	mov	(__divuint_PARM_2 + 1),#0x00
	mov	dpl, r1
	mov	dph, r2
	push	ar4
	push	ar3
	push	ar2
	push	ar1
	push	ar0
	lcall	__divuint
	mov	a, dpl
	mov	b, dph
	pop	ar0
	pop	ar1
	pop	ar2
	pop	ar3
	pop	ar4
	anl	a,#0x01
	mov	r7,#0x00
	orl	a,r7
	cjne	a,#0x01,00202$
00202$:
	mov	_P1_3,c
	sjmp	00114$
00113$:
;	weather_8051.c:98: else if (cmd == 'W') LED = ((t0 / 50) & 1) ? ON : OFF;  /* slow blink: 0.5 s */
	mov	a,#0x57
	cjne	a,_cmd,00110$
	mov	__divuint_PARM_2,#0x32
	mov	(__divuint_PARM_2 + 1),#0x00
	mov	dpl, r1
	mov	dph, r2
	push	ar4
	push	ar3
	push	ar2
	push	ar1
	push	ar0
	lcall	__divuint
	mov	a, dpl
	mov	b, dph
	pop	ar0
	pop	ar1
	pop	ar2
	pop	ar3
	pop	ar4
	anl	a,#0x01
	mov	r7,#0x00
	orl	a,r7
	cjne	a,#0x01,00205$
00205$:
	mov	_P1_3,c
	sjmp	00114$
00110$:
;	weather_8051.c:99: else if (cmd == 'R') LED = ON;
	mov	a,#0x52
	cjne	a,_cmd,00107$
;	assignBit
	clr	_P1_3
	sjmp	00114$
00107$:
;	weather_8051.c:100: else                 LED = OFF;
;	assignBit
	setb	_P1_3
00114$:
;	weather_8051.c:103: BUZ = (!nodata && cmd == 'W' && (t0 - storm_start) < BEEP_TIME
	mov	a,r0
	jnz	00120$
	mov	a,#0x57
	cjne	a,_cmd,00120$
	mov	a,r1
	clr	c
	subb	a,_main_storm_start_10000_16
	mov	r6,a
	mov	a,r2
	subb	a,(_main_storm_start_10000_16 + 1)
	mov	r7,a
	clr	c
	mov	a,r6
	subb	a,#0xe8
	mov	a,r7
	subb	a,#0x03
	jnc	00120$
;	weather_8051.c:104: && ((t0 / 50) & 1)) ? ON : OFF;
	mov	__divuint_PARM_2,#0x32
	mov	(__divuint_PARM_2 + 1),#0x00
	mov	dpl, r1
	mov	dph, r2
	push	ar4
	push	ar3
	lcall	__divuint
	mov	r6, dpl
	pop	ar3
	pop	ar4
	mov	a,r6
	anl	a,#0x01
	jnz	00121$
00120$:
;	assignBit
	clr	_main_sloc0_1_0
	sjmp	00122$
00121$:
;	assignBit
	setb	_main_sloc0_1_0
00122$:
	mov	c,_main_sloc0_1_0
	cpl	c
	mov	_P1_2,c
;	weather_8051.c:106: }
	ljmp	00116$
	.area CSEG    (CODE)
	.area CONST   (CODE)
	.area XINIT   (CODE)
	.area CABS    (ABS,CODE)
