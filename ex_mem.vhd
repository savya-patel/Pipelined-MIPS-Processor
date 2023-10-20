library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_mem is 
    port (clk, reset, regwrite_e, memreg_e, memwrite_e: in std_logic;  
          regwrite_m, memreg_m, memwrite_m: out std_logic;  
          aluin_e, writedata_e, writereg_e: in std_logic_vector(31 downto 0);  
          aluin_m, writedata_m, writereg_m: out std_logic_vector(31 downto 0));  
end ex_mem;

architecture behavior of ex_mem is  
begin
    process(clk)  
    begin 
        if rising_edge(clk) then 
            if reset = '1' then -- Reset condition
                regwrite_m <= '0';
                memreg_m <= '0';
                memwrite_m <= '0';
                aluin_m <= (others => '0');
                writedata_m <= (others => '0');
                writereg_m <= (others => '0');
            else
                -- Pass input signals to output
                regwrite_m <= regwrite_e;
                memreg_m <= memreg_e;
                memwrite_m <= memwrite_e;
                aluin_m <= aluin_e;
                writedata_m <= writedata_e;
                writereg_m <= writereg_e;
            end if;
        end if;
    end process;
end behavior;
