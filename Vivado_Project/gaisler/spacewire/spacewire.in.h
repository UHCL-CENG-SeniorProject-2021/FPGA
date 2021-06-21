#ifndef CONFIG_SPW_ENABLE
#define CONFIG_SPW_ENABLE 0
#endif

#ifndef CONFIG_SPW_NUM
#define CONFIG_SPW_NUM 1
#endif

#if defined CONFIG_SPW_AHBFIFO4
#define CONFIG_SPW_AHBFIFO 4
#elif defined CONFIG_SPW_AHBFIFO8
#define CONFIG_SPW_AHBFIFO 8
#elif defined CONFIG_SPW_AHBFIFO16
#define CONFIG_SPW_AHBFIFO 16
#elif defined CONFIG_SPW_AHBFIFO32
#define CONFIG_SPW_AHBFIFO 32
#elif defined CONFIG_SPW_AHBFIFO64
#define CONFIG_SPW_AHBFIFO 64
#else
#define CONFIG_SPW_AHBFIFO 4
#endif

#if defined CONFIG_SPW_RXFIFO16
#define CONFIG_SPW_RXFIFO 16
#elif defined CONFIG_SPW_RXFIFO32
#define CONFIG_SPW_RXFIFO 32
#elif defined CONFIG_SPW_RXFIFO64
#define CONFIG_SPW_RXFIFO 64
#else
#define CONFIG_SPW_RXFIFO 16
#endif

#ifndef CONFIG_SPW_RMAP
#define CONFIG_SPW_RMAP 0
#endif

#if defined CONFIG_SPW_RMAPBUF2
#define CONFIG_SPW_RMAPBUF 2
#elif defined CONFIG_SPW_RMAPBUF4
#define CONFIG_SPW_RMAPBUF 4
#elif defined CONFIG_SPW_RMAPBUF6
#define CONFIG_SPW_RMAPBUF 6
#elif defined CONFIG_SPW_RMAPBUF8
#define CONFIG_SPW_RMAPBUF 8
#else
#define CONFIG_SPW_RMAPBUF 4
#endif

#ifndef CONFIG_SPW_RMAPCRC
#define CONFIG_SPW_RMAPCRC 0
#endif

#ifndef CONFIG_SPW_RXUNAL
#define CONFIG_SPW_RXUNAL 0
#endif

#ifndef CONFIG_SPW_NETLIST
#define CONFIG_SPW_NETLIST 0
#endif

#if defined CONFIG_SPW_FT_DMR
#define CONFIG_SPW_FT 1
#elif defined CONFIG_SPW_FT_TMR
#define CONFIG_SPW_FT 2
#elif defined CONFIG_SPW_FT_BCH
#define CONFIG_SPW_FT 4
#elif defined CONFIG_SPW_FT_TECHSPEC
#define CONFIG_SPW_FT 5
#else
#define CONFIG_SPW_FT 0
#endif

#if defined CONFIG_SPW_GRSPW1
#define CONFIG_SPW_GRSPW 1
#else
#define CONFIG_SPW_GRSPW 2
#endif

#ifndef CONFIG_SPW_DMACHAN
#define CONFIG_SPW_DMACHAN 1
#endif

#ifndef CONFIG_SPW_PORTS
#define CONFIG_SPW_PORTS 1
#endif

#if defined CONFIG_SPW_RX_SDR
#define CONFIG_SPW_INPUT 2
#elif defined CONFIG_SPW_RX_DDR
#define CONFIG_SPW_INPUT 3
#elif defined CONFIG_SPW_RX_PAD
#define CONFIG_SPW_INPUT 4
#elif defined CONFIG_SPW_RX_XOR
#define CONFIG_SPW_INPUT 0
#elif defined CONFIG_SPW_RX_XORER1
#define CONFIG_SPW_INPUT 5
#elif defined CONFIG_SPW_RX_XORER2
#define CONFIG_SPW_INPUT 6
#elif defined CONFIG_SPW_RX_AFLEX
#define CONFIG_SPW_INPUT 1
#else
#define CONFIG_SPW_INPUT 2
#endif

#if defined CONFIG_SPW_TX_SDR
#define CONFIG_SPW_OUTPUT 0
#elif defined CONFIG_SPW_TX_DDR
#define CONFIG_SPW_OUTPUT 1
#elif defined CONFIG_SPW_TX_AFLEX
#define CONFIG_SPW_OUTPUT 2
#else
#define CONFIG_SPW_OUTPUT 0
#endif

#ifndef CONFIG_SPW_RTSAME
#define CONFIG_SPW_RTSAME 0
#endif
