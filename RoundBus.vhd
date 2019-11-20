library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;


entity RoundBus is port(
    in_state : in std_logic_vector(127 downto 0);
    RoundKey : in std_logic_vector(127 downto 0);
    out_state : out std_logic_vector(127 downto 0)
);
end RoundBus;



architecture behavior of RoundBus is

    component Round is port(
        in_state : in state;
        RoundKey : in state_byte;
        out_state : out state);
    end component;

    component BusToBytes is port(
        in_state : in std_logic_vector(127 downto 0);
        out_state : out state_byte);
    end component;

    component ToStateColumn is port(
        in_state : in state_byte;
        out_state : out state);
    end component;


    component ToStateByte is port(
        in_state : in state;
        out_state : out state_byte);
    end component;


    signal RoundKey_bytes : state_byte;
    signal out_state_bytes : state_byte;
    signal in_state_bytes : state_byte;

    signal Round_State_Input : state;
    signal Round_State_Output : state;

    signal Round_State_bytes : state_byte;

begin
    -- Converts busses to state_byte format. Will need to do further conversion for Round
    BusToBytes0: BusToBytes port map(in_state => in_state, out_state =>in_state_bytes);    
    BusToBytes2: BusToBytes port map(in_state => RoundKey, out_state =>RoundKey_bytes);    

    -- Convert bytes to encipher in state format for Round entity.
    ToStateColumn0: ToStateColumn port map(in_state => in_state_bytes, out_state => Round_State_Input);

    -- Do Round
    Round0: Round port map(in_state => Round_State_Input, RoundKey => RoundKey_bytes, out_state => Round_State_Output);

    --Now have to convert output back to a bus, first convert to bytes again.

    ToStateByte0: ToStateByte port map(in_state => Round_State_Output, out_state => Round_State_bytes);

    out_state(7 downto 0) <= Round_State_bytes(15);
    out_state(15 downto 8) <= Round_State_bytes(14);
    out_state(23 downto 16)<= Round_State_bytes(13);
    out_state(31 downto 24)<= Round_State_bytes(12);
    out_state(39 downto 32) <= Round_State_bytes(11);
    out_state(47 downto 40) <= Round_State_bytes(10);
    out_state(55 downto 48) <= Round_State_bytes(9);
    out_state(63 downto 56) <= Round_State_bytes(8);
    out_state(71 downto 64) <= Round_State_bytes(7);
    out_state(79 downto 72) <= Round_State_bytes(6);
    out_state(87 downto 80) <= Round_State_bytes(5);
    out_state(95 downto 88) <= Round_State_bytes(4);
    out_state(103 downto 96) <= Round_State_bytes(3);
    out_state(111 downto 104) <= Round_State_bytes(2);
    out_state(119 downto 112) <= Round_State_bytes(1);
    out_state(127 downto 120) <= Round_State_bytes(0);
end;
