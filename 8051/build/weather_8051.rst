                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.6.0 #16555 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module weather_8051
                                      6 	
                                      7 	.optsdcc -mmcs51 --model-small
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _now
                                     13 	.globl _serial_isr
                                     14 	.globl _timer0_isr
                                     15 	.globl _CY
                                     16 	.globl _AC
                                     17 	.globl _F0
                                     18 	.globl _RS1
                                     19 	.globl _RS0
                                     20 	.globl _OV
                                     21 	.globl _F1
                                     22 	.globl _P
                                     23 	.globl _PS
                                     24 	.globl _PT1
                                     25 	.globl _PX1
                                     26 	.globl _PT0
                                     27 	.globl _PX0
                                     28 	.globl _RD
                                     29 	.globl _WR
                                     30 	.globl _T1
                                     31 	.globl _T0
                                     32 	.globl _INT1
                                     33 	.globl _INT0
                                     34 	.globl _TXD
                                     35 	.globl _RXD
                                     36 	.globl _P3_7
                                     37 	.globl _P3_6
                                     38 	.globl _P3_5
                                     39 	.globl _P3_4
                                     40 	.globl _P3_3
                                     41 	.globl _P3_2
                                     42 	.globl _P3_1
                                     43 	.globl _P3_0
                                     44 	.globl _EA
                                     45 	.globl _ES
                                     46 	.globl _ET1
                                     47 	.globl _EX1
                                     48 	.globl _ET0
                                     49 	.globl _EX0
                                     50 	.globl _P2_7
                                     51 	.globl _P2_6
                                     52 	.globl _P2_5
                                     53 	.globl _P2_4
                                     54 	.globl _P2_3
                                     55 	.globl _P2_2
                                     56 	.globl _P2_1
                                     57 	.globl _P2_0
                                     58 	.globl _SM0
                                     59 	.globl _SM1
                                     60 	.globl _SM2
                                     61 	.globl _REN
                                     62 	.globl _TB8
                                     63 	.globl _RB8
                                     64 	.globl _TI
                                     65 	.globl _RI
                                     66 	.globl _P1_7
                                     67 	.globl _P1_6
                                     68 	.globl _P1_5
                                     69 	.globl _P1_4
                                     70 	.globl _P1_3
                                     71 	.globl _P1_2
                                     72 	.globl _P1_1
                                     73 	.globl _P1_0
                                     74 	.globl _TF1
                                     75 	.globl _TR1
                                     76 	.globl _TF0
                                     77 	.globl _TR0
                                     78 	.globl _IE1
                                     79 	.globl _IT1
                                     80 	.globl _IE0
                                     81 	.globl _IT0
                                     82 	.globl _P0_7
                                     83 	.globl _P0_6
                                     84 	.globl _P0_5
                                     85 	.globl _P0_4
                                     86 	.globl _P0_3
                                     87 	.globl _P0_2
                                     88 	.globl _P0_1
                                     89 	.globl _P0_0
                                     90 	.globl _B
                                     91 	.globl _ACC
                                     92 	.globl _PSW
                                     93 	.globl _IP
                                     94 	.globl _P3
                                     95 	.globl _IE
                                     96 	.globl _P2
                                     97 	.globl _SBUF
                                     98 	.globl _SCON
                                     99 	.globl _P1
                                    100 	.globl _TH1
                                    101 	.globl _TH0
                                    102 	.globl _TL1
                                    103 	.globl _TL0
                                    104 	.globl _TMOD
                                    105 	.globl _TCON
                                    106 	.globl _PCON
                                    107 	.globl _DPH
                                    108 	.globl _DPL
                                    109 	.globl _SP
                                    110 	.globl _P0
                                    111 	.globl _hash_seen
                                    112 	.globl _newcmd
                                    113 	.globl _cmd
                                    114 	.globl _ticks
                                    115 ;--------------------------------------------------------
                                    116 ; special function registers
                                    117 ;--------------------------------------------------------
                                    118 	.area RSEG    (ABS,DATA)
      000000                        119 	.org 0x0000
                           000080   120 _P0	=	0x0080
                           000081   121 _SP	=	0x0081
                           000082   122 _DPL	=	0x0082
                           000083   123 _DPH	=	0x0083
                           000087   124 _PCON	=	0x0087
                           000088   125 _TCON	=	0x0088
                           000089   126 _TMOD	=	0x0089
                           00008A   127 _TL0	=	0x008a
                           00008B   128 _TL1	=	0x008b
                           00008C   129 _TH0	=	0x008c
                           00008D   130 _TH1	=	0x008d
                           000090   131 _P1	=	0x0090
                           000098   132 _SCON	=	0x0098
                           000099   133 _SBUF	=	0x0099
                           0000A0   134 _P2	=	0x00a0
                           0000A8   135 _IE	=	0x00a8
                           0000B0   136 _P3	=	0x00b0
                           0000B8   137 _IP	=	0x00b8
                           0000D0   138 _PSW	=	0x00d0
                           0000E0   139 _ACC	=	0x00e0
                           0000F0   140 _B	=	0x00f0
                                    141 ;--------------------------------------------------------
                                    142 ; special function bits
                                    143 ;--------------------------------------------------------
                                    144 	.area RSEG    (ABS,DATA)
      000000                        145 	.org 0x0000
                           000080   146 _P0_0	=	0x0080
                           000081   147 _P0_1	=	0x0081
                           000082   148 _P0_2	=	0x0082
                           000083   149 _P0_3	=	0x0083
                           000084   150 _P0_4	=	0x0084
                           000085   151 _P0_5	=	0x0085
                           000086   152 _P0_6	=	0x0086
                           000087   153 _P0_7	=	0x0087
                           000088   154 _IT0	=	0x0088
                           000089   155 _IE0	=	0x0089
                           00008A   156 _IT1	=	0x008a
                           00008B   157 _IE1	=	0x008b
                           00008C   158 _TR0	=	0x008c
                           00008D   159 _TF0	=	0x008d
                           00008E   160 _TR1	=	0x008e
                           00008F   161 _TF1	=	0x008f
                           000090   162 _P1_0	=	0x0090
                           000091   163 _P1_1	=	0x0091
                           000092   164 _P1_2	=	0x0092
                           000093   165 _P1_3	=	0x0093
                           000094   166 _P1_4	=	0x0094
                           000095   167 _P1_5	=	0x0095
                           000096   168 _P1_6	=	0x0096
                           000097   169 _P1_7	=	0x0097
                           000098   170 _RI	=	0x0098
                           000099   171 _TI	=	0x0099
                           00009A   172 _RB8	=	0x009a
                           00009B   173 _TB8	=	0x009b
                           00009C   174 _REN	=	0x009c
                           00009D   175 _SM2	=	0x009d
                           00009E   176 _SM1	=	0x009e
                           00009F   177 _SM0	=	0x009f
                           0000A0   178 _P2_0	=	0x00a0
                           0000A1   179 _P2_1	=	0x00a1
                           0000A2   180 _P2_2	=	0x00a2
                           0000A3   181 _P2_3	=	0x00a3
                           0000A4   182 _P2_4	=	0x00a4
                           0000A5   183 _P2_5	=	0x00a5
                           0000A6   184 _P2_6	=	0x00a6
                           0000A7   185 _P2_7	=	0x00a7
                           0000A8   186 _EX0	=	0x00a8
                           0000A9   187 _ET0	=	0x00a9
                           0000AA   188 _EX1	=	0x00aa
                           0000AB   189 _ET1	=	0x00ab
                           0000AC   190 _ES	=	0x00ac
                           0000AF   191 _EA	=	0x00af
                           0000B0   192 _P3_0	=	0x00b0
                           0000B1   193 _P3_1	=	0x00b1
                           0000B2   194 _P3_2	=	0x00b2
                           0000B3   195 _P3_3	=	0x00b3
                           0000B4   196 _P3_4	=	0x00b4
                           0000B5   197 _P3_5	=	0x00b5
                           0000B6   198 _P3_6	=	0x00b6
                           0000B7   199 _P3_7	=	0x00b7
                           0000B0   200 _RXD	=	0x00b0
                           0000B1   201 _TXD	=	0x00b1
                           0000B2   202 _INT0	=	0x00b2
                           0000B3   203 _INT1	=	0x00b3
                           0000B4   204 _T0	=	0x00b4
                           0000B5   205 _T1	=	0x00b5
                           0000B6   206 _WR	=	0x00b6
                           0000B7   207 _RD	=	0x00b7
                           0000B8   208 _PX0	=	0x00b8
                           0000B9   209 _PT0	=	0x00b9
                           0000BA   210 _PX1	=	0x00ba
                           0000BB   211 _PT1	=	0x00bb
                           0000BC   212 _PS	=	0x00bc
                           0000D0   213 _P	=	0x00d0
                           0000D1   214 _F1	=	0x00d1
                           0000D2   215 _OV	=	0x00d2
                           0000D3   216 _RS0	=	0x00d3
                           0000D4   217 _RS1	=	0x00d4
                           0000D5   218 _F0	=	0x00d5
                           0000D6   219 _AC	=	0x00d6
                           0000D7   220 _CY	=	0x00d7
                                    221 ;--------------------------------------------------------
                                    222 ; overlayable register banks
                                    223 ;--------------------------------------------------------
                                    224 	.area REG_BANK_0	(REL,OVR,DATA)
      000000                        225 	.ds 8
                                    226 ;--------------------------------------------------------
                                    227 ; internal ram data
                                    228 ;--------------------------------------------------------
                                    229 	.area DSEG    (DATA)
      000008                        230 _ticks::
      000008                        231 	.ds 2
      00000A                        232 _cmd::
      00000A                        233 	.ds 1
      00000B                        234 _newcmd::
      00000B                        235 	.ds 1
      00000C                        236 _hash_seen::
      00000C                        237 	.ds 1
      00000D                        238 _main_storm_start_10000_16:
      00000D                        239 	.ds 2
      00000F                        240 _main_prev_10000_16:
      00000F                        241 	.ds 1
                                    242 ;--------------------------------------------------------
                                    243 ; overlayable items in internal ram
                                    244 ;--------------------------------------------------------
                                    245 	.area	OSEG    (OVR,DATA)
                                    246 ;--------------------------------------------------------
                                    247 ; Stack segment in internal ram
                                    248 ;--------------------------------------------------------
                                    249 	.area SSEG
      000021                        250 __start__stack:
      000021                        251 	.ds	1
                                    252 
                                    253 ;--------------------------------------------------------
                                    254 ; indirectly addressable internal ram data
                                    255 ;--------------------------------------------------------
                                    256 	.area ISEG    (DATA)
                                    257 ;--------------------------------------------------------
                                    258 ; absolute internal ram data
                                    259 ;--------------------------------------------------------
                                    260 	.area IABS    (ABS,DATA)
                                    261 	.area IABS    (ABS,DATA)
                                    262 ;--------------------------------------------------------
                                    263 ; bit data
                                    264 ;--------------------------------------------------------
                                    265 	.area BSEG    (BIT)
      000000                        266 _main_sloc0_1_0:
      000000                        267 	.ds 1
                                    268 ;--------------------------------------------------------
                                    269 ; paged external ram data
                                    270 ;--------------------------------------------------------
                                    271 	.area PSEG    (PAG,XDATA)
                                    272 ;--------------------------------------------------------
                                    273 ; uninitialized external ram data
                                    274 ;--------------------------------------------------------
                                    275 	.area XSEG    (XDATA)
                                    276 ;--------------------------------------------------------
                                    277 ; absolute external ram data
                                    278 ;--------------------------------------------------------
                                    279 	.area XABS    (ABS,XDATA)
                                    280 ;--------------------------------------------------------
                                    281 ; initialized external ram data
                                    282 ;--------------------------------------------------------
                                    283 	.area XISEG   (XDATA)
                                    284 	.area HOME    (CODE)
                                    285 	.area GSINIT0 (CODE)
                                    286 	.area GSINIT1 (CODE)
                                    287 	.area GSINIT2 (CODE)
                                    288 	.area GSINIT3 (CODE)
                                    289 	.area GSINIT4 (CODE)
                                    290 	.area GSINIT5 (CODE)
                                    291 	.area GSINIT  (CODE)
                                    292 	.area GSFINAL (CODE)
                                    293 	.area CSEG    (CODE)
                                    294 ;--------------------------------------------------------
                                    295 ; interrupt vector
                                    296 ;--------------------------------------------------------
                                    297 	.area HOME    (CODE)
      000000                        298 __interrupt_vect:
      000000 02 00 6E         [24]  299 	ljmp	__sdcc_gsinit_startup
      000003 32               [24]  300 	reti
      000004                        301 	.ds	7
      00000B 02 00 D6         [24]  302 	ljmp	_timer0_isr
      00000E                        303 	.ds	5
      000013 32               [24]  304 	reti
      000014                        305 	.ds	7
      00001B 32               [24]  306 	reti
      00001C                        307 	.ds	7
      000023 02 00 FD         [24]  308 	ljmp	_serial_isr
                                    309 ; restartable atomic support routines
      000026                        310 	.ds	2
      000028                        311 sdcc_atomic_exchange_rollback_start::
      000028 00               [12]  312 	nop
      000029 00               [12]  313 	nop
      00002A                        314 sdcc_atomic_exchange_pdata_impl:
      00002A E2               [24]  315 	movx	a, @r0
      00002B FB               [12]  316 	mov	r3, a
      00002C EA               [12]  317 	mov	a, r2
      00002D F2               [24]  318 	movx	@r0, a
      00002E 80 2C            [24]  319 	sjmp	sdcc_atomic_exchange_exit
      000030 00               [12]  320 	nop
      000031 00               [12]  321 	nop
      000032                        322 sdcc_atomic_exchange_xdata_impl:
      000032 E0               [24]  323 	movx	a, @dptr
      000033 FB               [12]  324 	mov	r3, a
      000034 EA               [12]  325 	mov	a, r2
      000035 F0               [24]  326 	movx	@dptr, a
      000036 80 24            [24]  327 	sjmp	sdcc_atomic_exchange_exit
      000038                        328 sdcc_atomic_compare_exchange_idata_impl:
      000038 E6               [12]  329 	mov	a, @r0
      000039 B5 02 02         [24]  330 	cjne	a, ar2, .+#5
      00003C EB               [12]  331 	mov	a, r3
      00003D F6               [12]  332 	mov	@r0, a
      00003E 22               [24]  333 	ret
      00003F 00               [12]  334 	nop
      000040                        335 sdcc_atomic_compare_exchange_pdata_impl:
      000040 E2               [24]  336 	movx	a, @r0
      000041 B5 02 02         [24]  337 	cjne	a, ar2, .+#5
      000044 EB               [12]  338 	mov	a, r3
      000045 F2               [24]  339 	movx	@r0, a
      000046 22               [24]  340 	ret
      000047 00               [12]  341 	nop
      000048                        342 sdcc_atomic_compare_exchange_xdata_impl:
      000048 E0               [24]  343 	movx	a, @dptr
      000049 B5 02 02         [24]  344 	cjne	a, ar2, .+#5
      00004C EB               [12]  345 	mov	a, r3
      00004D F0               [24]  346 	movx	@dptr, a
      00004E 22               [24]  347 	ret
      00004F                        348 sdcc_atomic_exchange_rollback_end::
                                    349 
      00004F                        350 sdcc_atomic_exchange_gptr_impl::
      00004F 30 F6 E0         [24]  351 	jnb	b.6, sdcc_atomic_exchange_xdata_impl
      000052 A8 82            [24]  352 	mov	r0, dpl
      000054 20 F5 D3         [24]  353 	jb	b.5, sdcc_atomic_exchange_pdata_impl
      000057                        354 sdcc_atomic_exchange_idata_impl:
      000057 EA               [12]  355 	mov	a, r2
      000058 C6               [12]  356 	xch	a, @r0
      000059 F5 82            [12]  357 	mov	dpl, a
      00005B 22               [24]  358 	ret
      00005C                        359 sdcc_atomic_exchange_exit:
      00005C 8B 82            [24]  360 	mov	dpl, r3
      00005E 22               [24]  361 	ret
      00005F                        362 sdcc_atomic_compare_exchange_gptr_impl::
      00005F 30 F6 E6         [24]  363 	jnb	b.6, sdcc_atomic_compare_exchange_xdata_impl
      000062 A8 82            [24]  364 	mov	r0, dpl
      000064 20 F5 D9         [24]  365 	jb	b.5, sdcc_atomic_compare_exchange_pdata_impl
      000067 80 CF            [24]  366 	sjmp	sdcc_atomic_compare_exchange_idata_impl
                                    367 ;--------------------------------------------------------
                                    368 ; global & static initialisations
                                    369 ;--------------------------------------------------------
                                    370 	.area HOME    (CODE)
                                    371 	.area GSINIT  (CODE)
                                    372 	.area GSFINAL (CODE)
                                    373 	.area GSINIT  (CODE)
                                    374 	.globl __sdcc_gsinit_startup
                                    375 	.globl __sdcc_program_startup
                                    376 	.globl __start__stack
                                    377 	.globl __mcs51_genXINIT
                                    378 	.globl __mcs51_genXRAMCLEAR
                                    379 	.globl __mcs51_genRAMCLEAR
                                    380 ;	weather_8051.c:29: volatile unsigned int  ticks = 0;     /* +1 every 10 ms */
      0000C7 E4               [12]  381 	clr	a
      0000C8 F5 08            [12]  382 	mov	_ticks,a
      0000CA F5 09            [12]  383 	mov	(_ticks + 1),a
                                    384 ;	weather_8051.c:30: volatile unsigned char cmd = 'S';     /* last status letter */
      0000CC 75 0A 53         [24]  385 	mov	_cmd,#0x53
                                    386 ;	weather_8051.c:31: volatile unsigned char newcmd = 0;
      0000CF F5 0B            [12]  387 	mov	_newcmd,a
                                    388 ;	weather_8051.c:32: volatile unsigned char hash_seen = 0; /* '#' received, letter comes next */
      0000D1 F5 0C            [12]  389 	mov	_hash_seen,a
                                    390 	.area GSFINAL (CODE)
      0000D3 02 00 69         [24]  391 	ljmp	__sdcc_program_startup
                                    392 ;--------------------------------------------------------
                                    393 ; Home
                                    394 ;--------------------------------------------------------
                                    395 	.area HOME    (CODE)
                                    396 	.area HOME    (CODE)
      000069                        397 __sdcc_program_startup:
      000069 12 01 48         [24]  398 	lcall	_main
      00006C                        399 __sdcc_program_exit:
      00006C 80 FE            [24]  400 	sjmp	.
                                    401 ;	return from main will return to caller
                                    402 ;--------------------------------------------------------
                                    403 ; code
                                    404 ;--------------------------------------------------------
                                    405 	.area CSEG    (CODE)
                                    406 ;------------------------------------------------------------
                                    407 ;Allocation info for local variables in function 'timer0_isr'
                                    408 ;------------------------------------------------------------
                                    409 ;	weather_8051.c:35: void timer0_isr(void) __interrupt(1)
                                    410 ;	-----------------------------------------
                                    411 ;	 function timer0_isr
                                    412 ;	-----------------------------------------
      0000D6                        413 _timer0_isr:
                           000007   414 	ar7 = 0x07
                           000006   415 	ar6 = 0x06
                           000005   416 	ar5 = 0x05
                           000004   417 	ar4 = 0x04
                           000003   418 	ar3 = 0x03
                           000002   419 	ar2 = 0x02
                           000001   420 	ar1 = 0x01
                           000000   421 	ar0 = 0x00
      0000D6 C0 E0            [24]  422 	push	acc
      0000D8 C0 07            [24]  423 	push	ar7
      0000DA C0 06            [24]  424 	push	ar6
      0000DC C0 D0            [24]  425 	push	psw
      0000DE 75 D0 00         [24]  426 	mov	psw,#0x00
                                    427 ;	weather_8051.c:37: TH0 = 0xDC; TL0 = 0x00;           /* 65536 - 9216 = 0xDC00 */
      0000E1 75 8C DC         [24]  428 	mov	_TH0,#0xdc
      0000E4 75 8A 00         [24]  429 	mov	_TL0,#0x00
                                    430 ;	weather_8051.c:38: ticks++;
      0000E7 AE 08            [24]  431 	mov	r6,_ticks
      0000E9 AF 09            [24]  432 	mov	r7,(_ticks + 1)
      0000EB 74 01            [12]  433 	mov	a,#0x01
      0000ED 2E               [12]  434 	add	a, r6
      0000EE F5 08            [12]  435 	mov	_ticks,a
      0000F0 E4               [12]  436 	clr	a
      0000F1 3F               [12]  437 	addc	a, r7
      0000F2 F5 09            [12]  438 	mov	(_ticks + 1),a
                                    439 ;	weather_8051.c:39: }
      0000F4 D0 D0            [24]  440 	pop	psw
      0000F6 D0 06            [24]  441 	pop	ar6
      0000F8 D0 07            [24]  442 	pop	ar7
      0000FA D0 E0            [24]  443 	pop	acc
      0000FC 32               [24]  444 	reti
                                    445 ;	eliminated unneeded push/pop dpl
                                    446 ;	eliminated unneeded push/pop dph
                                    447 ;	eliminated unneeded push/pop b
                                    448 ;------------------------------------------------------------
                                    449 ;Allocation info for local variables in function 'serial_isr'
                                    450 ;------------------------------------------------------------
                                    451 ;c             Allocated to registers r7 
                                    452 ;------------------------------------------------------------
                                    453 ;	weather_8051.c:42: void serial_isr(void) __interrupt(4)
                                    454 ;	-----------------------------------------
                                    455 ;	 function serial_isr
                                    456 ;	-----------------------------------------
      0000FD                        457 _serial_isr:
      0000FD C0 E0            [24]  458 	push	acc
      0000FF C0 07            [24]  459 	push	ar7
      000101 C0 D0            [24]  460 	push	psw
      000103 75 D0 00         [24]  461 	mov	psw,#0x00
                                    462 ;	weather_8051.c:45: if (RI) {
                                    463 ;	weather_8051.c:46: RI = 0;
                                    464 ;	assignBit
      000106 10 98 02         [24]  465 	jbc	_RI,00165$
      000109 80 28            [24]  466 	sjmp	00111$
      00010B                        467 00165$:
                                    468 ;	weather_8051.c:47: c = SBUF;
      00010B AF 99            [24]  469 	mov	r7,_SBUF
                                    470 ;	weather_8051.c:48: if (c == '#') {
      00010D BF 23 05         [24]  471 	cjne	r7,#0x23,00108$
                                    472 ;	weather_8051.c:49: hash_seen = 1;                    /* start of a status */
      000110 75 0C 01         [24]  473 	mov	_hash_seen,#0x01
      000113 80 1E            [24]  474 	sjmp	00111$
      000115                        475 00108$:
                                    476 ;	weather_8051.c:51: if (hash_seen && (c == 'S' || c == 'I' || c == 'R' || c == 'W')) {
      000115 E5 0C            [12]  477 	mov	a,_hash_seen
      000117 60 17            [24]  478 	jz	00102$
      000119 BF 53 02         [24]  479 	cjne	r7,#0x53,00169$
      00011C 80 0D            [24]  480 	sjmp	00101$
      00011E                        481 00169$:
      00011E BF 49 02         [24]  482 	cjne	r7,#0x49,00170$
      000121 80 08            [24]  483 	sjmp	00101$
      000123                        484 00170$:
      000123 BF 52 02         [24]  485 	cjne	r7,#0x52,00171$
      000126 80 03            [24]  486 	sjmp	00101$
      000128                        487 00171$:
      000128 BF 57 05         [24]  488 	cjne	r7,#0x57,00102$
      00012B                        489 00101$:
                                    490 ;	weather_8051.c:52: cmd = c;
      00012B 8F 0A            [24]  491 	mov	_cmd,r7
                                    492 ;	weather_8051.c:53: newcmd = 1;
      00012D 75 0B 01         [24]  493 	mov	_newcmd,#0x01
      000130                        494 00102$:
                                    495 ;	weather_8051.c:55: hash_seen = 0;                    /* ignore any other text */
      000130 75 0C 00         [24]  496 	mov	_hash_seen,#0x00
      000133                        497 00111$:
                                    498 ;	weather_8051.c:58: if (TI) TI = 0;
                                    499 ;	assignBit
      000133 10 99 00         [24]  500 	jbc	_TI,00174$
      000136                        501 00174$:
                                    502 ;	weather_8051.c:59: }
      000136 D0 D0            [24]  503 	pop	psw
      000138 D0 07            [24]  504 	pop	ar7
      00013A D0 E0            [24]  505 	pop	acc
      00013C 32               [24]  506 	reti
                                    507 ;	eliminated unneeded push/pop dpl
                                    508 ;	eliminated unneeded push/pop dph
                                    509 ;	eliminated unneeded push/pop b
                                    510 ;------------------------------------------------------------
                                    511 ;Allocation info for local variables in function 'now'
                                    512 ;------------------------------------------------------------
                                    513 ;t             Allocated to registers 
                                    514 ;------------------------------------------------------------
                                    515 ;	weather_8051.c:61: unsigned int now(void)                /* safe read of 16-bit tick count */
                                    516 ;	-----------------------------------------
                                    517 ;	 function now
                                    518 ;	-----------------------------------------
      00013D                        519 _now:
                                    520 ;	weather_8051.c:64: ET0 = 0; t = ticks; ET0 = 1;
                                    521 ;	assignBit
      00013D C2 A9            [12]  522 	clr	_ET0
      00013F 85 08 82         [24]  523 	mov	dpl,_ticks
      000142 85 09 83         [24]  524 	mov	dph,(_ticks + 1)
                                    525 ;	assignBit
      000145 D2 A9            [12]  526 	setb	_ET0
                                    527 ;	weather_8051.c:65: return t;
                                    528 ;	weather_8051.c:66: }
      000147 22               [24]  529 	ret
                                    530 ;------------------------------------------------------------
                                    531 ;Allocation info for local variables in function 'main'
                                    532 ;------------------------------------------------------------
                                    533 ;t0            Allocated to registers r1 r2 
                                    534 ;last_rx       Allocated to registers r3 r4 
                                    535 ;storm_start   Allocated with name '_main_storm_start_10000_16'
                                    536 ;prev          Allocated with name '_main_prev_10000_16'
                                    537 ;nodata        Allocated to registers r0 
                                    538 ;------------------------------------------------------------
                                    539 ;	weather_8051.c:68: void main(void)
                                    540 ;	-----------------------------------------
                                    541 ;	 function main
                                    542 ;	-----------------------------------------
      000148                        543 _main:
                                    544 ;	weather_8051.c:70: unsigned int t0, last_rx = 0, storm_start = 0;
      000148 E4               [12]  545 	clr	a
      000149 F5 0D            [12]  546 	mov	_main_storm_start_10000_16,a
      00014B F5 0E            [12]  547 	mov	(_main_storm_start_10000_16 + 1),a
                                    548 ;	weather_8051.c:71: unsigned char prev = 'S', nodata;
      00014D 75 0F 53         [24]  549 	mov	_main_prev_10000_16,#0x53
                                    550 ;	weather_8051.c:73: BUZ = OFF; LED = OFF;
                                    551 ;	assignBit
      000150 D2 92            [12]  552 	setb	_P1_2
                                    553 ;	assignBit
      000152 D2 93            [12]  554 	setb	_P1_3
                                    555 ;	weather_8051.c:75: TMOD = 0x21;          /* Timer1 mode 2 (baud), Timer0 mode 1 (tick) */
      000154 75 89 21         [24]  556 	mov	_TMOD,#0x21
                                    557 ;	weather_8051.c:76: TH1  = 0xFD;          /* 9600 baud @ 11.0592 MHz */
      000157 75 8D FD         [24]  558 	mov	_TH1,#0xfd
                                    559 ;	weather_8051.c:77: SCON = 0x50;          /* serial mode 1, receive on */
      00015A 75 98 50         [24]  560 	mov	_SCON,#0x50
                                    561 ;	weather_8051.c:78: TR1  = 1;
                                    562 ;	assignBit
      00015D D2 8E            [12]  563 	setb	_TR1
                                    564 ;	weather_8051.c:79: TH0  = 0xDC; TL0 = 0x00; TR0 = 1;
      00015F 75 8C DC         [24]  565 	mov	_TH0,#0xdc
      000162 75 8A 00         [24]  566 	mov	_TL0,#0x00
                                    567 ;	assignBit
      000165 D2 8C            [12]  568 	setb	_TR0
                                    569 ;	weather_8051.c:80: ET0  = 1; ES = 1; EA = 1;
                                    570 ;	assignBit
      000167 D2 A9            [12]  571 	setb	_ET0
                                    572 ;	assignBit
      000169 D2 AC            [12]  573 	setb	_ES
                                    574 ;	assignBit
      00016B D2 AF            [12]  575 	setb	_EA
                                    576 ;	weather_8051.c:82: last_rx = now() - NO_DATA;        /* start in "no data" until ESP32 talks */
      00016D 12 01 3D         [24]  577 	lcall	_now
      000170 E5 82            [12]  578 	mov	a, dpl
      000172 85 83 F0         [24]  579 	mov	b, dph
      000175 24 0C            [12]  580 	add	a,#0x0c
      000177 FB               [12]  581 	mov	r3,a
      000178 E5 F0            [12]  582 	mov	a,b
      00017A 34 FE            [12]  583 	addc	a,#0xfe
      00017C FC               [12]  584 	mov	r4,a
                                    585 ;	weather_8051.c:84: while (1) {
      00017D                        586 00116$:
                                    587 ;	weather_8051.c:85: t0 = now();
      00017D C0 04            [24]  588 	push	ar4
      00017F C0 03            [24]  589 	push	ar3
      000181 12 01 3D         [24]  590 	lcall	_now
      000184 A9 82            [24]  591 	mov	r1, dpl
      000186 AA 83            [24]  592 	mov	r2, dph
      000188 D0 03            [24]  593 	pop	ar3
      00018A D0 04            [24]  594 	pop	ar4
                                    595 ;	weather_8051.c:87: if (newcmd) {                 /* new letter arrived */
      00018C E5 0B            [12]  596 	mov	a,_newcmd
      00018E 60 1A            [24]  597 	jz	00105$
                                    598 ;	weather_8051.c:88: newcmd = 0;
      000190 75 0B 00         [24]  599 	mov	_newcmd,#0x00
                                    600 ;	weather_8051.c:89: last_rx = t0;
      000193 89 03            [24]  601 	mov	ar3,r1
      000195 8A 04            [24]  602 	mov	ar4,r2
                                    603 ;	weather_8051.c:90: if (cmd == 'W' && prev != 'W') storm_start = t0;   /* storm just started */
      000197 74 57            [12]  604 	mov	a,#0x57
      000199 B5 0A 0B         [24]  605 	cjne	a,_cmd,00102$
      00019C 74 57            [12]  606 	mov	a,#0x57
      00019E B5 0F 02         [24]  607 	cjne	a,_main_prev_10000_16,00200$
      0001A1 80 04            [24]  608 	sjmp	00102$
      0001A3                        609 00200$:
      0001A3 89 0D            [24]  610 	mov	_main_storm_start_10000_16,r1
      0001A5 8A 0E            [24]  611 	mov	(_main_storm_start_10000_16 + 1),r2
      0001A7                        612 00102$:
                                    613 ;	weather_8051.c:91: prev = cmd;
      0001A7 85 0A 0F         [24]  614 	mov	_main_prev_10000_16,_cmd
      0001AA                        615 00105$:
                                    616 ;	weather_8051.c:94: nodata = ((t0 - last_rx) >= NO_DATA);
      0001AA E9               [12]  617 	mov	a,r1
      0001AB C3               [12]  618 	clr	c
      0001AC 9B               [12]  619 	subb	a,r3
      0001AD F8               [12]  620 	mov	r0,a
      0001AE EA               [12]  621 	mov	a,r2
      0001AF 9C               [12]  622 	subb	a,r4
      0001B0 FD               [12]  623 	mov	r5,a
      0001B1 C3               [12]  624 	clr	c
      0001B2 E8               [12]  625 	mov	a,r0
      0001B3 94 F4            [12]  626 	subb	a,#0xf4
      0001B5 ED               [12]  627 	mov	a,r5
      0001B6 94 01            [12]  628 	subb	a,#0x01
      0001B8 B3               [12]  629 	cpl	c
      0001B9 92 00            [24]  630 	mov	_main_sloc0_1_0,c
      0001BB E4               [12]  631 	clr	a
      0001BC 33               [12]  632 	rlc	a
                                    633 ;	weather_8051.c:97: if (nodata)          LED = ((t0 / 10) & 1) ? ON : OFF;  /* fast blink: 0.1 s */
      0001BD F8               [12]  634 	mov	r0,a
      0001BE 60 32            [24]  635 	jz	00113$
      0001C0 75 10 0A         [24]  636 	mov	__divuint_PARM_2,#0x0a
      0001C3 75 11 00         [24]  637 	mov	(__divuint_PARM_2 + 1),#0x00
      0001C6 89 82            [24]  638 	mov	dpl, r1
      0001C8 8A 83            [24]  639 	mov	dph, r2
      0001CA C0 04            [24]  640 	push	ar4
      0001CC C0 03            [24]  641 	push	ar3
      0001CE C0 02            [24]  642 	push	ar2
      0001D0 C0 01            [24]  643 	push	ar1
      0001D2 C0 00            [24]  644 	push	ar0
      0001D4 12 02 78         [24]  645 	lcall	__divuint
      0001D7 E5 82            [12]  646 	mov	a, dpl
      0001D9 85 83 F0         [24]  647 	mov	b, dph
      0001DC D0 00            [24]  648 	pop	ar0
      0001DE D0 01            [24]  649 	pop	ar1
      0001E0 D0 02            [24]  650 	pop	ar2
      0001E2 D0 03            [24]  651 	pop	ar3
      0001E4 D0 04            [24]  652 	pop	ar4
      0001E6 54 01            [12]  653 	anl	a,#0x01
      0001E8 7F 00            [12]  654 	mov	r7,#0x00
      0001EA 4F               [12]  655 	orl	a,r7
      0001EB B4 01 00         [24]  656 	cjne	a,#0x01,00202$
      0001EE                        657 00202$:
      0001EE 92 93            [24]  658 	mov	_P1_3,c
      0001F0 80 42            [24]  659 	sjmp	00114$
      0001F2                        660 00113$:
                                    661 ;	weather_8051.c:98: else if (cmd == 'W') LED = ((t0 / 50) & 1) ? ON : OFF;  /* slow blink: 0.5 s */
      0001F2 74 57            [12]  662 	mov	a,#0x57
      0001F4 B5 0A 32         [24]  663 	cjne	a,_cmd,00110$
      0001F7 75 10 32         [24]  664 	mov	__divuint_PARM_2,#0x32
      0001FA 75 11 00         [24]  665 	mov	(__divuint_PARM_2 + 1),#0x00
      0001FD 89 82            [24]  666 	mov	dpl, r1
      0001FF 8A 83            [24]  667 	mov	dph, r2
      000201 C0 04            [24]  668 	push	ar4
      000203 C0 03            [24]  669 	push	ar3
      000205 C0 02            [24]  670 	push	ar2
      000207 C0 01            [24]  671 	push	ar1
      000209 C0 00            [24]  672 	push	ar0
      00020B 12 02 78         [24]  673 	lcall	__divuint
      00020E E5 82            [12]  674 	mov	a, dpl
      000210 85 83 F0         [24]  675 	mov	b, dph
      000213 D0 00            [24]  676 	pop	ar0
      000215 D0 01            [24]  677 	pop	ar1
      000217 D0 02            [24]  678 	pop	ar2
      000219 D0 03            [24]  679 	pop	ar3
      00021B D0 04            [24]  680 	pop	ar4
      00021D 54 01            [12]  681 	anl	a,#0x01
      00021F 7F 00            [12]  682 	mov	r7,#0x00
      000221 4F               [12]  683 	orl	a,r7
      000222 B4 01 00         [24]  684 	cjne	a,#0x01,00205$
      000225                        685 00205$:
      000225 92 93            [24]  686 	mov	_P1_3,c
      000227 80 0B            [24]  687 	sjmp	00114$
      000229                        688 00110$:
                                    689 ;	weather_8051.c:99: else if (cmd == 'R') LED = ON;
      000229 74 52            [12]  690 	mov	a,#0x52
      00022B B5 0A 04         [24]  691 	cjne	a,_cmd,00107$
                                    692 ;	assignBit
      00022E C2 93            [12]  693 	clr	_P1_3
      000230 80 02            [24]  694 	sjmp	00114$
      000232                        695 00107$:
                                    696 ;	weather_8051.c:100: else                 LED = OFF;
                                    697 ;	assignBit
      000232 D2 93            [12]  698 	setb	_P1_3
      000234                        699 00114$:
                                    700 ;	weather_8051.c:103: BUZ = (!nodata && cmd == 'W' && (t0 - storm_start) < BEEP_TIME
      000234 E8               [12]  701 	mov	a,r0
      000235 70 33            [24]  702 	jnz	00120$
      000237 74 57            [12]  703 	mov	a,#0x57
      000239 B5 0A 2E         [24]  704 	cjne	a,_cmd,00120$
      00023C E9               [12]  705 	mov	a,r1
      00023D C3               [12]  706 	clr	c
      00023E 95 0D            [12]  707 	subb	a,_main_storm_start_10000_16
      000240 FE               [12]  708 	mov	r6,a
      000241 EA               [12]  709 	mov	a,r2
      000242 95 0E            [12]  710 	subb	a,(_main_storm_start_10000_16 + 1)
      000244 FF               [12]  711 	mov	r7,a
      000245 C3               [12]  712 	clr	c
      000246 EE               [12]  713 	mov	a,r6
      000247 94 E8            [12]  714 	subb	a,#0xe8
      000249 EF               [12]  715 	mov	a,r7
      00024A 94 03            [12]  716 	subb	a,#0x03
      00024C 50 1C            [24]  717 	jnc	00120$
                                    718 ;	weather_8051.c:104: && ((t0 / 50) & 1)) ? ON : OFF;
      00024E 75 10 32         [24]  719 	mov	__divuint_PARM_2,#0x32
      000251 75 11 00         [24]  720 	mov	(__divuint_PARM_2 + 1),#0x00
      000254 89 82            [24]  721 	mov	dpl, r1
      000256 8A 83            [24]  722 	mov	dph, r2
      000258 C0 04            [24]  723 	push	ar4
      00025A C0 03            [24]  724 	push	ar3
      00025C 12 02 78         [24]  725 	lcall	__divuint
      00025F AE 82            [24]  726 	mov	r6, dpl
      000261 D0 03            [24]  727 	pop	ar3
      000263 D0 04            [24]  728 	pop	ar4
      000265 EE               [12]  729 	mov	a,r6
      000266 54 01            [12]  730 	anl	a,#0x01
      000268 70 04            [24]  731 	jnz	00121$
      00026A                        732 00120$:
                                    733 ;	assignBit
      00026A C2 00            [12]  734 	clr	_main_sloc0_1_0
      00026C 80 02            [24]  735 	sjmp	00122$
      00026E                        736 00121$:
                                    737 ;	assignBit
      00026E D2 00            [12]  738 	setb	_main_sloc0_1_0
      000270                        739 00122$:
      000270 A2 00            [12]  740 	mov	c,_main_sloc0_1_0
      000272 B3               [12]  741 	cpl	c
      000273 92 92            [24]  742 	mov	_P1_2,c
                                    743 ;	weather_8051.c:106: }
      000275 02 01 7D         [24]  744 	ljmp	00116$
                                    745 	.area CSEG    (CODE)
                                    746 	.area CONST   (CODE)
                                    747 	.area XINIT   (CODE)
                                    748 	.area CABS    (ABS,CODE)
