library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity id_ex is 
    port (clk, reset, flush: in std_logic;  
          rd1_d, rd2_d, rs_d, rt_d, rd_d: in std_logic_vector(31 downto 0);
          regwrite_d, memreg_d, memwrite_d, alusrc_d, regdst_d, signimm_d: in std_logic; -- Control signals as input
          alucontrol_d: in std_logic_vector(1 downto 0);
          rd1_e, rd2_e, rs_e, rt_e, rd_e: out std_logic_vector(31 downto 0);
          regwrite_e, memreg_e, memwrite_e, alusrc_e, regdst_e, signimm_e: out std_logic;
          alucontrol_e: out std_logic_vector(1 downto 0));  -- Control signals as output
end id_ex;

architecture behavior of id_ex is 
begin
    process(clk)  
    begin 
        if rising_edge(clk) then 
            if reset='1' or flush='1' then -- Reset condition, flush for beq instruction 
                rd1_e <= (others => '0');
                rd2_e <= (others => '0');
                rs_e <= (others => '0');
                rt_e <= (others => '0');
                rd_e <= (others => '0');
                regwrite_e <= '0';
                memreg_e <= '0';
                memwrite_e <= '0';
                alucontrol_e <= (others => '0');
                alusrc_e <= '0';
                regdst_e <= '0';
                signimm_e <= '0';
            else
                rd1_e <= rd1_d;
                rd2_e <= rd2_d;
                rs_e <= rs_d;
                rt_e <= rt_d;
                rd_e <= rd_d;
                regwrite_e <= regwrite_d;
                memreg_e <= memreg_d;
                memwrite_e <= memwrite_d;
                alucontrol_e <= alucontrol_d;
                alusrc_e <= alusrc_d;
                regdst_e <= regdst_d;
                signimm_e <= signimm_d;
            end if;
        end if;
    end process;
end behavior;
