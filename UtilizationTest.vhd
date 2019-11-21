library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;



entity UtilizationTest is port(
    in_state : in std_logic_vector(127 downto 0);
    RoundKey : in std_logic_vector(127 downto 0);
    out_state : out std_logic_vector(127 downto 0)
);
end UtilizationTest;

architecture behavior of UtilizationTest is
    signal state0 : std_logic_vector(127 downto 0);
    signal state1 : std_logic_vector(127 downto 0);
    signal state2 : std_logic_vector(127 downto 0);
    signal state3 : std_logic_vector(127 downto 0);
    signal state4 : std_logic_vector(127 downto 0);
    signal state5 : std_logic_vector(127 downto 0);
    signal state6 : std_logic_vector(127 downto 0);
    signal state7 : std_logic_vector(127 downto 0);
    signal state8 : std_logic_vector(127 downto 0);
    --signal state9 : std_logic_vector(127 downto 0);

    component RoundBus is port(
        in_state : in std_logic_vector(127 downto 0);
        RoundKey : in std_logic_vector(127 downto 0);
        out_state : out std_logic_vector(127 downto 0)
    );
    end component;
begin
    RoundBus0 : RoundBus port map(in_state, RoundKey,state0);
    RoundBus1 : RoundBus port map(state0, RoundKey,state1);
    RoundBus2 : RoundBus port map(state1, RoundKey,state2);
    RoundBus3 : RoundBus port map(state2, RoundKey,state3);
    RoundBus4 : RoundBus port map(state3, RoundKey,state4);
    RoundBus5 : RoundBus port map(state4, RoundKey,state5);
    RoundBus6 : RoundBus port map(state5, RoundKey,state6);
    RoundBus7 : RoundBus port map(state6, RoundKey,state7);
    RoundBus8 : RoundBus port map(state7, RoundKey,state8);
    RoundBus9 : RoundBus port map(state8, RoundKey,out_state);
end;




