/*
 * AES.c
 *
 * Created: 11/29/2019 6:28:58 PM
 * Author : Jacob
 */ 

#include <avr/io.h>

#define clk PIN0_bm
#define clear_L PIN1_bm
#define enable PIN2_bm
#define EnotD PIN3_bm
#define LRK PIN4_bm

#define CTRL PORTF
#define MOSI_LOW PORTJ
#define MOSI_HIGH PORTK
#define MISO_LOW PORTC
#define MISO_HIGH PORTA

//Control signals with port F
#define reset_clock() PORTF.OUTCLR = clk
#define reset_device() PORTF.OUTCLR = clear_L; PORTF.OUTSET = clear_L
#define half_clock() PORTF.OUTTGL = clk;
#define enable_device() PORTF.OUTSET = enable;
#define disable_device() PORTF.OUTCLR = enable;
#define set_encrypt() CTRL.OUTSET = EnotD;
#define set_decrypt() CTRL.OUTCLR = EnotD;



// write to AES device using ports JK
#define write_low(byte) PORTJ.OUT = byte;
#define write_high(byte) PORTK.OUT = byte;

//read from AES device using ports AC
#define read_low() PORTC.IN;
#define read_high() PORTA.IN;


void tcc0_init()
{
	TCC0.CNT = 0;
	TCC0.PER = (32E6/1024)/5;
	TCC0.CTRLA = TC_CLKSEL_DIV1024_gc;
}

uint8_t sonnet[] = 
"When forty winters shall beseige thy brow,\
And dig deep trenches in thy beauty's field,\
Thy youth's proud livery, so gazed on now,\
Will be a tatter'd weed, of small worth held:\
Then being ask'd where all thy beauty lies,\
Where all the treasure of thy lusty days,\
To say, within thine own deep-sunken eyes,\
Were an all-eating shame and thriftless praise.\
How much more praise deserved thy beauty's use,\
If thou couldst answer 'This fair child of mine\
Shall sum my count and make my old excuse,'\
Proving his beauty by succession thine!\
This were to be new made when thou art old,\
And see thy blood warm when thou feel'st it cold.";

uint8_t test[] = {0x2b, 0x7e, 0x15, 0x16,
				0x28, 0xae, 0xd2, 0xa6,
				0xab, 0xf7, 0x15, 0x88,
				0x09, 0xcf, 0x4f, 0x3c,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00};
				
uint8_t test1[] = {0x7e, 0x2e, 0x16, 0x15,
				0xae, 0x28, 0xa6, 0xd2,
				0xf7, 0xab, 0x88, 0x15,
				0xcf, 0x09, 0x3c, 0x4f};
				
uint8_t test2[] = {0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00,
				0x00, 0x00, 0x00, 0x00};
				
uint8_t testa[] = "over the moon";
				
				
uint8_t roundkeys[] = {
0x54,0x68,0x61,0x74,0x73,0x20,0x6d,0x79,
0x20,0x4b,0x75,0x6e,0x67,0x20,0x46,0x79,
0xe2,0x32,0xd7,0xf1,0x91,0x12,0xba,0x88,
0xb1,0x59,0xcf,0xe6,0xd6,0x79,0x89,0x9f,
0x56,0x95,0xc,0x7,0xc7,0x87,0xb6,0x8f,
0x76,0xde,0x79,0x69,0xa0,0xa7,0xf0,0xf6,
0xe,0x19,0x4e,0xe7,0xc9,0x9e,0xf8,0x68,
0xbf,0x40,0x81,0x1,0x1f,0xe7,0x71,0xf7,
0x92,0xba,0x26,0x27,0x5b,0x24,0xde,0x4f,
0xe4,0x64,0x5f,0x4e,0xfb,0x83,0x2e,0xb9,
0x6e,0x8b,0x70,0x28,0x35,0xaf,0xae,0x67,
0xd1,0xcb,0xf1,0x29,0x2a,0x48,0xdf,0x90,
0x1c,0x15,0x10,0xcd,0x29,0xba,0xbe,0xaa,
0xf8,0x71,0x4f,0x83,0xd2,0x39,0x90,0x13,
0x4e,0x75,0x6d,0x78,0x67,0xcf,0xd3,0xd2,
0x9f,0xbe,0x9c,0x51,0x4d,0x87,0xc,0x42,
0xd9,0x8b,0x41,0x9b,0xbe,0x44,0x92,0x49,
0x21,0xfa,0xe,0x18,0x6c,0x7d,0x2,0x5a,
0x3d,0xfc,0xff,0xcb,0x83,0xb8,0x6d,0x82,
0xa2,0x42,0x63,0x9a,0xce,0x3f,0x61,0xc0,
0x7e,0x13,0x45,0x40,0xfd,0xab,0x28,0xc2,
0x5f,0xe9,0x4b,0x58,0x91,0xd6,0x2a,0x98
};


void send_roundkeys()
{
	CTRL.OUTSET = LRK;
	reset_clock();
	enable_device();
	uint8_t temp;
	uint16_t i = 0;
	while (2*i < sizeof(roundkeys))
	{
		write_high(roundkeys[2*i]);
		write_low(roundkeys[(2*i)+1]);
		half_clock();
		//don't need to read anything really, but this keeps the clock consistent.
		temp = read_high();
		temp = read_low() + temp;
		half_clock();
		i++;
	}
	CTRL.OUTCLR = LRK;
}

void usart_init(void)
{ //64Kb
	//add names later...
	PORTD.OUTSET = PIN3_bm;
	PORTD.DIRSET = PIN3_bm;
	PORTD.DIRCLR = PIN2_bm;
	
	USARTD0.CTRLB = 0x18; //(USART_RXEN_bm | USART_TXEN_BM);
	USARTD0.CTRLC = 0x03;
	
	//64k baud
	USARTD0.BAUDCTRLA = 121;
	USARTD0.BAUDCTRLB = (-2<<4) & 0xF0;
	//enable uart receive interrupts
	//USARTD0.CTRLA = USART_RXCINTLVL_MED_gc;
}

#define true 1
#define false 0
volatile uint8_t rcv_msg = false;
volatile uint8_t msg_sz = 0;

uint8_t read_char(void)
{
	while ((USARTD0.STATUS & 0x80) != 0x80);
	return USARTD0.DATA;
}

void write_char(char c)
{
	while ((USARTD0.STATUS & 0x20) != 0x20);
	USARTD0.DATA = (uint8_t)c;
}

void transfer(uint8_t* buffer, uint16_t size)
{
	uint16_t i = 0;
	//force clock low
	reset_clock();
	enable_device();
	while (2*i < size)
	{
		write_high(buffer[2*i]);
		write_low(buffer[(2*i)+1]);
		half_clock();
		buffer[2*i] = read_high();
		buffer[(2*i)+1] = read_low();
		half_clock();
		i++;
	}
}

void init_ports()
{
	//set directions for io pins
	CTRL.DIRSET = clk | enable | clear_L| EnotD; // LRK;
	MISO_LOW.DIRCLR = 0xFF;
	MISO_HIGH.DIRCLR = 0xFF;
	MOSI_LOW.DIRSET = 0xFF;
	MOSI_HIGH.DIRSET = 0xFF;
	//reset and disable all control signals as default positions.
	disable_device();
	reset_device();
	reset_clock();
}

int main(void)
{
	clock_init();
	usart_init();
	init_ports();
	//tcc0_init();
	uint8_t ndx = 0;
	uint8_t data[1056];
	set_encrypt();
	disable_device();
	reset_device();
	//send_roundkeys();
	//transfer(test, sizeof(test));
	//transfer(test, sizeof(test)+32);
	uint8_t c;
	uint8_t len_low;
	uint8_t len_high;
	uint16_t len;
    while (1) 
    {
		c = read_char();
		if ((c == 0x00) || (c == 0x01))
		{
			if (c == 0x00) {
				set_encrypt();
			} else {
				set_decrypt();
			}
			len_low = read_char();
			len_high = read_char();
			len = (len_high << 8) | (len_low);
			for (int i=0; i<len; i++)
				data[i] = read_char();
			//set_encrypt();
			disable_device();
			reset_device();
			transfer(data, len+32);
			for (int i=0; i<len; i++)
				write_char(data[i+32]);
			disable_device();
			reset_device();
			reset_clock();
			for (int i=0; i<len+64; i++)
				data[i] = 0;
		}
    }
}

