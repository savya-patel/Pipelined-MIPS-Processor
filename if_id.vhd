library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity if_id is 
    port (clk, reset, stall: in std_logic;  
		    instr_i,pc_i: in std_logic_vector(31 downto 0);
			 opcode: in std_logic_vector(5 downto 0);
		    instr_d,pc_d: out std_logic_vector(31 downto 0));	  
end if_id;

architecture behavior of if_id is 
	signal internal_instr,internal_pc : std_logic_vector(31 downto 0);  
begin
    process(clk)  
    begin 
        if rising_edge(clk) then 
				if reset='1' then --reset conditiion 
					internal_instr<=(others=>'0');
					internal_pc<=(others=>'0');
				end if;
				
            --
				--stall for load word instruction 
				if (stall='1') or (opcode="000011") then
					internal_instr<=internal_instr;
					internal_pc<=internal_pc;
				else
					internal_instr<=instr_i;
					internal_pc<=pc_i;
				end if;
        end if;
    end process;
	 instr_d<=internal_instr;
	 pc_d<=internal_pc;
end behavior;
