library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hazard is 
    port (clk, write_d, branch, regwrite, writereg: in std_logic;  
			 flush, stall: out std_logic;
			 rs_d, rt_d, rdest, rd1, rd2, writereg_e, writereg_m: in std_logic_vector(31 downto 0);
		    regwrite_e, memreg_e, memreg_m: in std_logic;
	       mux0, mux1: out std_logic_vector(1 downto 0);
	    	 mux2, mux3: out std_logic); 
end hazard;

architecture behavior of hazard is 
begin
    process(clk)  
    begin 
        if rising_edge(clk) then 
            -- Forwarding for mux0
            if (((writereg_m = rs_d) and memreg_m='1') and rs_d /= (others=>'0')) then
                mux0 <= "10";  -- Forward from ex/mem to rd1
            elsif (((writereg_e = rs_d) and regwrite_e='1') and rs_d /= (others=>'0')) then
                mux0 <= "01";  -- Forward from mem/wb to rd1
            else
                mux0 <= "00";
            end if;

            -- Forwarding for mux1
            if (((writereg_m = rt_d) and memreg_m='1') and rt_d /= (others=>'0')) then
                mux1 <= "10";  -- Forward from ex/mem to rd2
            elsif (((writereg_e = rt_d) and regwrite_e='1') and rt_d /= (others=>'0')) then
                mux1 <= "01";  -- Forward from mem/wb to rd2
            else
                mux1 <= "00";
            end if;

            -- Stall for load word instruction
            if ((rs_d = rt_d or rt_d = rt_d) and memreg_e='1') then
                stall <= '1';
                flush <= '1';
            end if;

            -- Branch stall hazard
            if (((rs_d = writereg_e) or (rt_d = writereg_e)) and branch='1' and regwrite_e='1') or (((rs_d = writereg_m) or (rt_d = writereg_m)) and branch='1' and memreg_m='1') then
                stall <= '1';
                flush <= '1';
            end if;
        end if;
    end process;
end behavior;
