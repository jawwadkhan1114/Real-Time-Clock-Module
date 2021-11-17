-------------------------------------------------------------------------------
--
-- Title       : pos_edge_detector
-- Design      : lab10
-- Author      : JawwadKhan
-- Company     : Stony Brook University
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\lab10\lab10\lab10\src\pos_edge_detector.vhd
-- Generated   : Mon Apr 19 21:54:55 2021
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
--{entity {pos_edge_detector} architecture {pos_edge_arch}}

library IEEE;
use IEEE.std_logic_1164.all;

entity pos_edge_detector is
	 port(
		 a : in STD_LOGIC;
		 rst_n : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 a_pe : out STD_LOGIC
	     );
end pos_edge_detector;

--}} End of automatically maintained section

architecture pos_edge_arch of pos_edge_detector is	 
signal temp : std_logic;
begin  
	process(clk, rst_n)
	begin
	if rising_edge (clk) and rst_n = '0' then 
		a_pe <= '0';		
		temp <= '0';
	elsif rising_edge (clk) then 
		temp <= a;
		a_pe <= not temp and a;
	end if;
	end process;
end pos_edge_arch;
