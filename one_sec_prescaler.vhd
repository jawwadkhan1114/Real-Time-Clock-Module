-------------------------------------------------------------------------------
--
-- Title       : one_sec_prescaler
-- Design      : lab10
-- Author      : JawwadKhan
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\lab10\lab10\lab10\src\one_sec_prescaler.vhd
-- Generated   : Mon Apr 19 22:44:47 2021
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {one_sec_prescaler} architecture {one_sec_prescaler_arch}}


library IEEE;
use IEEE.std_logic_1164.all;
use work.all;
entity one_sec_prescalar is
port(
clk : in std_logic; -- system clock
rst_n : in std_logic; -- active low synchronous reset
clr_n : in std_logic; -- synchronous clear
cnt_en : in std_logic; -- count enable
one_hz : out std_logic; -- one Hz square wave output
one_sec_tick : out std_logic -- one clock wide pulse every sec
);
end one_sec_prescalar;


--}} End of automatically maintained section
architecture one_sec_prescaler_arch of one_sec_prescalar is	 
signal temp_one_hz : std_logic;	 
signal hold_count : integer range 0 to 32768;	
begin	 				
	--set both outputs to 0
	process(clk, rst_n, clr_n, cnt_en)	
	begin
		if rising_edge (clk) then 
			one_sec_tick <= '0'; 
			if (rst_n = '0' or clr_n = '0') then 
				hold_count <= 0;   
				one_hz <= '0';	   
				temp_one_hz <= '0';
				one_sec_tick <= '0';
			elsif cnt_en = '1' then 
				if hold_count = 32767 then 	  
					temp_one_hz <= not temp_one_hz; 
					one_sec_tick <= '1';	
					hold_count <= 0;
				elsif hold_count = 16384 then 
					temp_one_hz <= not temp_one_hz; 
					hold_count <= hold_count + 1;	  
				else 
					hold_count <= hold_count + 1;
				end if;
			end if;	
		end if;
		one_hz <= not temp_one_hz;
	end process;
end one_sec_prescaler_arch;
