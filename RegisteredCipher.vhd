library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;
library xil_defaultlib;
use xil_defaultlib.Common.all;




entity RegisteredCipher is port(
    input : in std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0);
    clock : in std_logic;
    counter : in std_logic_vector(2 downto 0)
);
end RegisteredCipher;


architecture behavior of RegisteredCipher is

    component Cipher is port(
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


    signal plaintext : std_logic_vector(127 downto 0);
    signal ciphertext : std_logic_vector(127 downto 0);

    signal plaintext_bytes : state_byte;

    signal filler : std_logic_vector(127 downto 0) := x"2B7E151628AED2A6ABF7158809CF4F3C";

    signal plaintext_state : state;
    signal ciphertext_state : state;
    signal RoundKeys : RoundKeys;

    signal ciphertext_bytes : state_byte;
    
    signal register_input : std_logic_vector(15 downto 0);
    signal Sel : std_ulogic_vector(2 downto 0) := "000";
    signal SI : std_logic := '1';
    signal FBnotS : std_logic := '0';
    signal WE : std_logic := '1';
    signal clear_L : std_logic := '1';
    

begin

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
        FullOutput => plaintext,
        Sel => Counter,
        SInotSO => SI,
        FBnotS => FBnotS,
        WE => WE,
        clock => clock,
        clear_L => clear_L);

    outputreg : Selective16to128Register port map(
        FullInput => ciphertext,
        SelectiveInput => filler(15 downto 0),
        SelectiveOutput => output,
        Sel => Counter,
        SInotSO => '0',
        FBnotS => FBnotS,
        WE => WE,
        clock => clock,
        clear_L => clear_L);

        
    
    --Convert plaintext to state format

    BusToBytes12 : BusToBytes port map(plaintext, plaintext_bytes);
    ToStateColumn0 : ToStateColumn port map(plaintext_bytes, plaintext_state);
    
    --Now do Cipher

    Cipher0 : Cipher port map(in_state => plaintext_state, RoundKeys => RoundKeys, out_state => ciphertext_state);
    
    --Convert Cipher output to ciphertext
    ToStateByte0 : ToStateByte port map(ciphertext_state, ciphertext_bytes);
    BytesToBus0 : BytesToBus port map(ciphertext_bytes, ciphertext); 

end;
