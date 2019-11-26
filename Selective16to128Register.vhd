library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

--128 bit register that can have either 128 bit or One way 16 bit IO.
--If Full Bus is true, io is 123 to 128. If false, then either the 
--input or the output uses the select lines to R/W to 8 possible
--addresses. At least one side in all cases remains a 128 bit bussed
--register.
entity Selective16to128Register is port ( 
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
    clear_L : in std_logic
);
end Selective16to128Register;

architecture behavior of Selective16to128Register is

    signal register128_val : std_logic_vector(127 downto 0);

begin

    process(FBnotS, SInotSO, Sel, register128_val)
    begin
        if (FBnotS or SInotSO) = '1' then
            FullOutput <= register128_val;
        else
            if Sel = "111" then
                SelectiveOutput <= register128_val(15 downto 0);
            elsif Sel = "110" then
                SelectiveOutput <= register128_val(31 downto 16);
            elsif Sel = "101" then
                SelectiveOutput <= register128_val(47 downto 32);
            elsif Sel = "100" then
                SelectiveOutput <= register128_val(63 downto 48);
            elsif Sel = "011" then
                SelectiveOutput <= register128_val(79 downto 64);
            elsif Sel = "010" then
                SelectiveOutput <= register128_val(95 downto 80);
            elsif Sel = "001" then
                SelectiveOutput <= register128_val(111 downto 96);
            elsif Sel = "000" then
                SelectiveOutput <= register128_val(127 downto 112);
            end if;
        end if;
    end process;

    process(clear_L, FBnotS, SinotSO, Sel, FullInput, SelectiveInput)
    begin
        if clear_L='0' then
            register128_val <= x"00000000000000000000000000000000";
        elsif (rising_edge(clock) and (WE = '1')) then
            if ((FBnotS) or (not SInotSO)) = '1' then
                register128_val <= FullInput;
            else
                if Sel = "111" then
                    register128_val(15 downto 0) <= SelectiveInput;
                elsif Sel = "110" then
                    register128_val(31 downto 16) <= SelectiveInput;
                elsif Sel = "101" then
                    register128_val(47 downto 32) <= SelectiveInput;
                elsif Sel = "100" then
                    register128_val(63 downto 48) <= SelectiveInput;
                elsif Sel = "011" then
                    register128_val(79 downto 64) <= SelectiveInput;
                elsif Sel = "010" then
                    register128_val(95 downto 80) <= SelectiveInput;
                elsif Sel = "001" then
                    register128_val(111 downto 96) <= SelectiveInput;
                elsif Sel = "000" then
                    register128_val(127 downto 112) <= SelectiveInput;
                end if;
            end if;
        end if;
    end process;

end behavior;
