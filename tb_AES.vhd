library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;
library xil_defaultlib;
use xil_defaultlib.Common.all;



entity tb_AES is
end tb_AES;


architecture behavior of tb_AES is


    component AES is port(
        input : in std_logic_vector(15 downto 0);
        output : out std_logic_vector(15 downto 0);
        clock : in std_logic;
        clear_L : in std_logic;
        enable : in std_logic;
        EnotD : in std_logic;
        LRK : in std_logic);
    end component;

    signal input : std_logic_vector(15 downto 0);
    signal output : std_logic_vector(15 downto 0);
    signal clock : std_logic := '0';
    signal clear_L : std_logic := '1';
    signal enable : std_logic :='1';
    signal EnotD : std_logic := '0';
    signal LRK : std_logic := '1';

    constant half_period : time := 500 ns;
    
    signal super_long : std_logic_vector(1407 downto 0) := x"5468617473206d79204b756e67204679e232d7f19112ba88b159cfe6d679899f56950c07c787b68f76de7969a0a7f0f60e194ee7c99ef868bf4081011fe771f792ba26275b24de4fe4645f4efb832eb96e8b702835afae67d1cbf1292a48df901c1510cd29babeaaf8714f83d23990134e756d7867cfd3d29fbe9c514d870c42d98b419bbe44924921fa0e186c7d025a3dfcffcb83b86d82a242639ace3f61c07e134540fdab28c25fe94b5891d62a98";
    signal x : unsigned(10 downto 0) := to_unsigned(1408, 11);    
    signal test: integer;                                                

begin
    clock <= not clock after half_period;

    AES0 : AES port map(
        input => input,
        output => output,
        clock => clock,
        clear_L => clear_L,
        enable => enable,
        EnotD => EnotD,
        LRK => LRK);
        
    --set RoundKeys
    --BusToBytes0 : BusToBytes port map(x"5468617473206d79204b756e67204679", RoundKeys(0));
    --BusToBytes1 : BusToBytes port map(x"e232d7f19112ba88b159cfe6d679899f", RoundKeys(1));
    --BusToBytes2 : BusToBytes port map(x"56950c07c787b68f76de7969a0a7f0f6", RoundKeys(2));
    --BusToBytes3 : BusToBytes port map(x"0e194ee7c99ef868bf4081011fe771f7", RoundKeys(3));
    --BusToBytes4 : BusToBytes port map(x"92ba26275b24de4fe4645f4efb832eb9", RoundKeys(4));
    --BusToBytes5 : BusToBytes port map(x"6e8b702835afae67d1cbf1292a48df90", RoundKeys(5));
    --BusToBytes6 : BusToBytes port map(x"1c1510cd29babeaaf8714f83d2399013", RoundKeys(6));
    --BusToBytes7 : BusToBytes port map(x"4e756d7867cfd3d29fbe9c514d870c42", RoundKeys(7));
    --BusToBytes8 : BusToBytes port map(x"d98b419bbe44924921fa0e186c7d025a", RoundKeys(8));
    --BusToBytes9 : BusToBytes port map(x"3dfcffcb83b86d82a242639ace3f61c0", RoundKeys(9));
    --BusToBytes10 : BusToBytes port map(x"7e134540fdab28c25fe94b5891d62a98", RoundKeys(10));
    --x"2B7E151628AED2A6ABF7158809CF4F3C";

    --x"8610 18ef 8133 6a3b  21c9 ba1f 16dc cf87";
    process
    begin
          if (x /= 0)  then
            input <= super_long(to_integer(x)-1 downto to_integer(x)-16);
            x <= x - 16;
            wait for 2*half_period;
            
          else
            LRK <= '0';
            input <= x"8610";
            wait for 2*half_period;
            input <= x"18EF";
            wait for 2*half_period;
            input <= x"8133";
            wait for 2*half_period;
            input <= x"6A3B";
            wait for 2*half_period;
            input <= x"21C9";
            wait for 2*half_period;
            input <= x"BA1F";
            wait for 2*half_period;
            input <= x"16DC";
            wait for 2*half_period;
            input <= x"CF87";
            wait for 9*half_period;
            wait;
          end if;
    end process;
end;
