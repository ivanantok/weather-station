/*  =====================================================================
    MINI WEATHER STATION  -  8051 side (ALARM UNIT)
    Board  : AT89S52 (any 8052) @ 11.0592 MHz crystal
    Tool   : SDCC compiler (run from VS Code: Ctrl+Shift+B)
    Output : 8051/build/weather_8051.hex  -> load into Proteus AT89C52

    The ESP32 sends a status every 2 s on RXD (9600 baud): '#' then a letter
        'S' = stable      'I' = improving
        'R' = rain likely 'W' = storm warning

    The 8051 drives the alarm:
        S / I  -> LED off, buzzer off
        R      -> LED on (steady)
        W      -> LED blinks, buzzer beeps for 10 s then stops
        no letter for 5 s (ESP32 off / wire loose) -> LED blinks fast
    ===================================================================== */

#include <8051.h>

#define BUZ P1_2            /* buzzer (active-LOW) */
#define LED P1_3            /* LED cathode to pin, anode via resistor to VCC */

#define ON   0              /* active-LOW outputs */
#define OFF  1

#define BEEP_TIME  1000     /* 10 s   (in 10 ms ticks) */
#define NO_DATA    500      /* 5 s    */

volatile unsigned int  ticks = 0;     /* +1 every 10 ms */
volatile unsigned char cmd = 'S';     /* last status letter */
volatile unsigned char newcmd = 0;
volatile unsigned char hash_seen = 0; /* '#' received, letter comes next */

/* Timer0: 10 ms tick */
void timer0_isr(void) __interrupt(1)
{
    TH0 = 0xDC; TL0 = 0x00;           /* 65536 - 9216 = 0xDC00 */
    ticks++;
}

/* Serial: receive status letter */
void serial_isr(void) __interrupt(4)
{
    unsigned char c;
    if (RI) {
        RI = 0;
        c = SBUF;
        if (c == '#') {
            hash_seen = 1;                    /* start of a status */
        } else {
            if (hash_seen && (c == 'S' || c == 'I' || c == 'R' || c == 'W')) {
                cmd = c;
                newcmd = 1;
            }
            hash_seen = 0;                    /* ignore any other text */
        }
    }
    if (TI) TI = 0;
}

unsigned int now(void)                /* safe read of 16-bit tick count */
{
    unsigned int t;
    ET0 = 0; t = ticks; ET0 = 1;
    return t;
}

void main(void)
{
    unsigned int t0, last_rx = 0, storm_start = 0;
    unsigned char prev = 'S', nodata;

    BUZ = OFF; LED = OFF;

    TMOD = 0x21;          /* Timer1 mode 2 (baud), Timer0 mode 1 (tick) */
    TH1  = 0xFD;          /* 9600 baud @ 11.0592 MHz */
    SCON = 0x50;          /* serial mode 1, receive on */
    TR1  = 1;
    TH0  = 0xDC; TL0 = 0x00; TR0 = 1;
    ET0  = 1; ES = 1; EA = 1;

    last_rx = now() - NO_DATA;        /* start in "no data" until ESP32 talks */

    while (1) {
        t0 = now();

        if (newcmd) {                 /* new letter arrived */
            newcmd = 0;
            last_rx = t0;
            if (cmd == 'W' && prev != 'W') storm_start = t0;   /* storm just started */
            prev = cmd;
        }

        nodata = ((t0 - last_rx) >= NO_DATA);

        /* LED */
        if (nodata)          LED = ((t0 / 10) & 1) ? ON : OFF;  /* fast blink: 0.1 s */
        else if (cmd == 'W') LED = ((t0 / 50) & 1) ? ON : OFF;  /* slow blink: 0.5 s */
        else if (cmd == 'R') LED = ON;
        else                 LED = OFF;

        /* buzzer: beeps for 10 s when storm starts */
        BUZ = (!nodata && cmd == 'W' && (t0 - storm_start) < BEEP_TIME
               && ((t0 / 50) & 1)) ? ON : OFF;
    }
}
