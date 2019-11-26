library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;
library xil_defaultlib;
use xil_defaultlib.Common.all;

entity tb_Register is
end tb_Register;


architecture behavior of tb_Register is

    component Selective16to128Register is port ( 
        FullInput : in std_logic_vector(127 downto 0);
        SelectiveInput : in std_logic_vector(15 downto 0);
        FullOutput : out std_logic_vector(127 downto 0);
        SelectiveOutput : out std_logic_vector(15 downto 0);
        --Select lines, if there is either input or output selection
        Sel : in std_logic_vector(2 downto 0);
        --All active High, except clear
        --Selective Input, Not Selective Output
        SInotSO : in std_logic;
        --Full Bus, Not Select
        FBnotS : in std_logic;
        --Write Enable
        WE : in std_logic;
        --clock
        clock : in std_logic;
        --clear all contents, active low
        clear_L : in std_logic);
    end component;

    constant half_period : time := 50ns;

    signal input : std_logic_vector(15 downto 0);
    signal output : std_logic_vector(15 downto 0);
    signal full_input : std_logic_vector(127 downto 0);
    signal full_output : std_logic_vector(127 downto 0);

    signal sel : std_logic_vector(2 downto 0);
    signal si_not_so : std_logic;
    signal fb_not_s : std_logic;
    signal we : std_logic;
    signal clk : std_logic := '0';
    signal clear : std_logic := '1';
   
    signal filler : std_logic_vector(127 downto 0) := x"5468617473206d79204b756e67204679";

begin

    test : Selective16to128Register port map(
        FullInput => full_input,
        SelectiveInput => input,
        FullOutput => full_output,
        SelectiveOutput => output,
        Sel => sel,
        SInotSo => si_not_so,
        FBnotS => fb_not_s,
        WE => we,
        clock => clk,
        clear_L => clear
    );

    clk <= not clk after half_period;

    process
    begin
        --Basic test to see if fullbus gets passed through.
        sel <= "000";
        fb_not_s <= '0';
        si_not_so <= '1';
        we <= '1';
        full_input <= x"2B7E151628AED2A6ABF7158809CF4F3C";
        input <= filler(127 downto 112);
        wait for 200 ns;
        input <= filler(111 downto 96);
        sel <= "001";
        wait for 200 ns;
        input <= filler(95 downto 80);
        sel <= "010";
        wait for 200 ns;
        wait;
    end process;


end behavior;
