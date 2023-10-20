library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_wb is 
    port (clk, reset, regwrite_m, memreg_m: in std_logic;  
          regwrite_w, memreg_w: out std_logic;  
          aluout_w, writereg_w, readdata_w: out std_logic_vector(31 downto 0);  
          aluout_m, writereg_m, readdata_m: in std_logic_vector(31 downto 0));  
end mem_wb;

architecture behavior of mem_wb is  
begin
    process(clk)  
    begin 
        if rising_edge(clk) then 
            if reset = '1' then -- Reset condition
                regwrite_w <= '0';
                memreg_w <= '0';
                aluout_w <= (others => '0');
                writereg_w <= (others => '0');
                readdata_w <= (others => '0');
            else
                -- Pass input signals to output
                regwrite_w <= regwrite_m;
                memreg_w <= memreg_m;
                aluout_w <= aluout_m;
                writereg_w <= writereg_m;
                readdata_w <= readdata_m;
            end if;
        end if;
    end process;
end behavior;
