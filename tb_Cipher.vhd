library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;




entity tb_Cipher is
end tb_Cipher;


architecture behavior of tb_Cipher is

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





    signal plaintext : std_logic_vector(127 downto 0);
    signal ciphertext : std_logic_vector(127 downto 0);

    signal plaintext_state : state;
    signal ciphertext_state : state;
    signal RoundKeys : Roundkeys;

    signal ciphertext_bytes : state_byte;

begin
    --set plain text
    plaintext <= x"2B7E151628AED2A6ABF7158809CF4F3C";
    --set RoundKeys
    BusToBytes0 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(0));
    BusToBytes1 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(1));
    BusToBytes2 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(2));
    BusToBytes3 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(3));
    BusToBytes4 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(4));
    BusToBytes5 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(5));
    BusToBytes6 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(6));
    BusToBytes7 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(7));
    BusToBytes8 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(8));
    BusToBytes9 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(9));
    BusToBytes10 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(10));
    BusToBytes11 : BusToBytes port map(x"2B7E151628AED2A6ABF7158809CF4F3C", RoundKeys(10));
    
    --Now do Cipher

    Cipher0 : Cipher port map(plaintext_state, RoundKeys, ciphertext_state);
    
    --Convert Cipher output to ciphertext
    ToStateByte0 : ToStateByte port map(ciphertext_state, ciphertext_bytes);
    
    

    
end;


