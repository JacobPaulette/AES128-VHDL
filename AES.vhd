library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;
library xil_defaultlib;
use xil_defaultlib.Common.all;

--Intend to make this the top level design file


entity AES is port(
    input : in std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0);
    clock : in std_logic;
    clear_L : in std_logic;
    enable : in std_logic;
    EnotD : in std_logic --encipher not decipher
);
end AES;


architecture behavior of AES is


    --COMPONENT DECLARATIONS

    component Cipher is port(
        in_state : in state;
        RoundKeys : in RoundKeys;
        out_state : out state);
    end component;

    component Decipher is port(
        in_state : in state;
        RoundKeys : in RoundKeys;
        out_state : out state);
    end component;

    component BusToBytes is port(
        in_state : in std_logic_vector(127 downto 0);
        out_state : out state_byte);
    end component;

    component ToStateByte is port(
        in_state : in state;
        out_state : out state_byte);
    end component;

    component BytesToBus is port(
        in_bytes : in state_byte;
        out_bus : out std_logic_vector(127 downto 0));
    end component;

    component ToStateColumn is port(
        in_state : in state_byte;
        out_state : out state);
    end component;
    
    component Selective16to128Register is port(
        FullInput : in std_logic_vector(127 downto 0);
        SelectiveInput : in std_logic_vector(15 downto 0);
        FullOutput : out std_logic_vector(127 downto 0);
        SelectiveOutput : out std_logic_vector(15 downto 0);
        Sel : in std_logic_vector(2 downto 0);
        SInotSO : in std_logic;
        FBnotS : in std_logic;
        WE : in std_logic;
        clock : in std_logic;
        clear_L : in std_logic);
    end component;

    component Counter3Bit is port(
        clock : in std_logic;
        clear_L : in std_logic;
        count : out std_logic_vector(2 downto 0);
        enable : in std_logic);
    end component;

    --SIGNAL DECLARATIONS

    --Inverted clock,
    signal not_clock : std_logic;

    signal inputtext : std_logic_vector(127 downto 0);
    signal outputtext : std_logic_vector(127 downto 0);

    signal inputtext_bytes : state_byte;

    signal filler : std_logic_vector(127 downto 0) := x"2B7E151628AED2A6ABF7158809CF4F3C";

    --For Cipher and Decipher
    signal plaintext_state : state;
    signal ciphertext_state : state;
    signal RoundKeys : RoundKeys; --RoundKeys are a constant for now, will add
                                -- Input functionality later.

    signal inputtext_state : state;
    signal outputtext_state : state;
    
    signal outputtext_bytes : state_byte;
    
    signal register_input : std_logic_vector(15 downto 0);
    signal count : std_logic_vector(2 downto 0);
    signal InputRegBus : std_logic_vector(127 downto 0);

    --Control variables for registers.
    signal buffer_reg_WE : std_logic := '0';
    signal output_reg_WE : std_logic := '0';
    signal FullBus : std_logic := '1';
    signal SI : std_logic := '1';
    signal SO : std_logic := '0';
    signal SelectiveBus : std_logic := '0';



begin
    
    --Invert clock signal to trigger component events that happen at falling edges.
    not_clock <= not clock;

    --Instantiate Counter, increments on falling edge.
    Counter3Bit0 : Counter3Bit port map(
        clock => not_clock,
        clear_L => clear_L,
        count => count,
        enable => enable);


    --set RoundKeys
    BusToBytes0 : BusToBytes port map(x"5468617473206d79204b756e67204679", RoundKeys(0));
    BusToBytes1 : BusToBytes port map(x"e232d7f19112ba88b159cfe6d679899f", RoundKeys(1));
    BusToBytes2 : BusToBytes port map(x"56950c07c787b68f76de7969a0a7f0f6", RoundKeys(2));
    BusToBytes3 : BusToBytes port map(x"0e194ee7c99ef868bf4081011fe771f7", RoundKeys(3));
    BusToBytes4 : BusToBytes port map(x"92ba26275b24de4fe4645f4efb832eb9", RoundKeys(4));
    BusToBytes5 : BusToBytes port map(x"6e8b702835afae67d1cbf1292a48df90", RoundKeys(5));
    BusToBytes6 : BusToBytes port map(x"1c1510cd29babeaaf8714f83d2399013", RoundKeys(6));
    BusToBytes7 : BusToBytes port map(x"4e756d7867cfd3d29fbe9c514d870c42", RoundKeys(7));
    BusToBytes8 : BusToBytes port map(x"d98b419bbe44924921fa0e186c7d025a", RoundKeys(8));
    BusToBytes9 : BusToBytes port map(x"3dfcffcb83b86d82a242639ace3f61c0", RoundKeys(9));
    BusToBytes10 : BusToBytes port map(x"7e134540fdab28c25fe94b5891d62a98", RoundKeys(10));


    inputreg : Selective16to128Register port map(
        SelectiveInput => input,
        SelectiveOutput => filler(15 downto 0),
        FullInput => filler,
        FullOutput => InputRegBus,
        Sel => count,
        SInotSO => SI,
        FBnotS => SelectiveBus,
        WE => enable, --Input reg always takes in input as long as device is enabled.
        clock => clock,
        clear_L => clear_L);

    -- Full Input, Full Output. WE enabled at rising clock edge and
    -- count = 7, does full write at the following falling edge.
    -- WE is disabled at rising edge of count = 0.
    bufferreg : Selective16to128Register port map(
            SelectiveInput => filler(15 downto 0),
            SelectiveOutput => filler(15 downto 0),
            FullInput => InputRegBus,
            FullOutput => inputtext,
            Sel => count,
            SInotSO => SI, --Vivado yells if I don't have a default input, this doesn't matter.
            FBnotS => FullBus,
            WE => buffer_reg_WE,
            clock => not_clock,
            clear_L => clear_L);


    outputreg : Selective16to128Register port map(
        FullInput => outputtext,
        SelectiveInput => filler(15 downto 0),
        SelectiveOutput => output,
        Sel => count,
        SInotSO => SO,
        FBnotS => SelectiveBus,
        WE => output_reg_WE,
        clock => not_clock,
        clear_L => clear_L);


    --Controls when registers get written to according to the clock
    --and counter.
    --the two registers that have to have exact R/W timings are 
    --Buffer Reg and Ouput Reg, which are the registers on either
    --end to the Cipher/Decipher components.
    --The write enables and clocks are set up so that the buffer
    --reg receives/locks the input between the last 16 bit word of 
    --plaintext block is received and the first word of the next block.
    --Output Reg needs to do the same.
    REG_CTRL: process(clock, count, enable)
    begin
        if enable = '1' and rising_edge(clock) then
            if count = "111" then
                --Ready bufferreg and outputreg to do write on the next falling edge.
                buffer_reg_WE <= '1';
                output_reg_WE <= '1';
            elsif count = "000" then
                --Disable WE on bufferreg and outputreg before the next falling edge so 
                --so block doesn't get corrupted.
                buffer_reg_WE <= '0';
                output_reg_WE <= '0';
            end if;
        end if;
    end process;

    --state gets Ciphered/Deciphered at same time. EnotD chooses which one 
    -- is the proper output.
    
    --outputtext_state <= plaintext_state;
    
    outputtext_state <= ciphertext_state when (EnotD = '1') else plaintext_state;



    --Convert plaintext to state format

    BusToBytes12 : BusToBytes port map(inputtext, inputtext_bytes);
    ToStateColumn0 : ToStateColumn port map(inputtext_bytes, inputtext_state);
    
    --Now do Cipher and Decipher

    Cipher0 : Cipher port map(in_state => inputtext_state, RoundKeys => RoundKeys, out_state => ciphertext_state);
    
    Decipher0 : Decipher port map(in_state => inputtext_state, RoundKeys => RoundKeys, out_state => plaintext_state);
    --Convert Cipher output to ciphertext
    ToStateByte0 : ToStateByte port map(outputtext_state, outputtext_bytes);
    BytesToBus0 : BytesToBus port map(outputtext_bytes, outputtext); 

end;
